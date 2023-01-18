SELECT 
	GP.`product_name`,
    GP.`product_img_url`,
    GP.`product_url`,
    GP.`product_price_min`,
    GP.`product_short_description`
FROM `grommet_products` GP
INNER JOIN (
	SELECT product_id
	FROM   
		`grommet_product_categories`
	WHERE `product_category_id` = (  
		SELECT `id`   
		FROM `grommet_gifts_categories`      
		WHERE `sub_category` = 'Beauty & Personal Care' 
	)  
	OR `product_category_id` = 
	(  
		SELECT `id`   
		FROM `grommet_gifts_categories`      
		WHERE `sub_category` = 'Skincare' 
	) 
	UNION
	SELECT product_id
	FROM `grommet_product_to_keyword` 
	WHERE `keyword_id` = (  
		SELECT    
			`id`  
		FROM `grommet_product_keywords`     
		WHERE `keyword` = 'Aromatherapy' 
	)
) RawProducts ON RawProducts.product_id = GP.id
WHERE GP.`is_sold_out` = 0;
-- Query Execution Time : 0.015 sec

--------------------- 2nd query -----------------------------------

SELECT
	DISTINCT GP.`id`,
	GP.`product_name`,
    GP.`product_img_url`,
    GP.`product_url`,
    GP.`product_price_min`,
    GP.`product_short_description`
FROM `grommet_products` GP
LEFT OUTER JOIN `grommet_product_categories` GPC ON GPC.product_id = GP.id
LEFT OUTER JOIN `grommet_gifts_categories` GGC ON GGC.id = GPC.product_category_id
LEFT OUTER JOIN `grommet_product_to_keyword` GPTK ON GP.`id` = GPTK.`product_id`
LEFT OUTER JOIN `grommet_product_keywords` GPK ON GPTK.`keyword_id` = GPK.`id`
WHERE GP.`is_sold_out` = 0 and (GGC.`sub_category` in ('Beauty & Personal Care', 'Skincare') or GPK.`keyword` = 'Aromatherapy');

-- Query Execution Time : 0.094 sec