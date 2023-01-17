# NOTE you need to install sanitize gem in order to run this script "gem install sanitize", "gem install httparty".

require 'httparty'
require 'sanitize'

response = HTTParty.get("https://www.nasa.gov/api/2/ubernode/479003")
json = JSON.parse(response.body)
result={}

article = Sanitize.fragment(json["_source"]["body"]).gsub!("\n","").split("  ")[7..-2].join(" ")
result[:title] = json["_source"]["title"]
result[:date] = DateTime.parse(json["_source"]["promo-date-time"]).strftime('%Y-%m-%d')
result[:release_no] = json["_source"]["release-id"]
result[:article] = article.gsub!(".  ",".\n ")
puts result