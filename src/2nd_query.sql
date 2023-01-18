SELECT
	GP.`product_name`,
    GP.`product_img_url`,
    GP.`product_url`,
    GP.`product_price_min`,
    GP.`product_short_description`
FROM `grommet_product_to_keyword` GPTK
INNER JOIN `grommet_product_keywords` GPK
ON GPTK.`keyword_id` = GPK.`id`
INNER JOIN `grommet_products` GP
ON GP.`id` = GPTK.`product_id`
WHERE GPK.`keyword` = 'Hair accessor' AND GP.`is_sold_out` = 0;