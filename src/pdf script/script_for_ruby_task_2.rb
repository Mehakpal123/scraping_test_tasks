# NOTE: you need to install google_drive, stringio, pdf-reader gem and open-uri in order to run this script
# like "gem install google_drive" , "gem install stringio", "gem install pdf-reader" and  "gem install open-uri"
# If you got error then you might need to update the google auth gem version to 0.17.1.

require 'google_drive'
require 'open-uri'
require 'stringio'
require 'pdf-reader'


def get_petitioner(page)
  array = page.split('State of Alaska')
  return '' if array[1].nil?

  array[1]&.split(',')[0].strip
end

def get_state(page)
  array = page.text.split("\n")[0]
  return '' if array.nil?

  array.split('of the')[1].strip || ''
end

def get_amount(page)
  regex = /(\$[0-9,]+(\.[0-9]{2})?)/
  page[regex] || ''
end

def get_date(page)
  regex = %r{\d{1,2}/\d{1,2}/\d{2,4}}
  page[regex] || ''
end

session = GoogleDrive::Session.from_config('config.json')
response = session.files
result = []
response.each do |file|
  sio = StringIO.new
  io = file.download_to_io(sio)
  reader = PDF::Reader.new(io)
  # puts reader.info
  reader.pages.each_with_index do |page, index|
    next unless index.zero?

    gsub_data = page.text.gsub(/\s+/, ' ')
    petitioner = get_petitioner(gsub_data)
    state = get_state(page)
    amount = get_amount(gsub_data)
    date = get_date(gsub_data)
    result << { petitioner: petitioner, state: state, amount: amount, date: date }
  end
end
puts result
