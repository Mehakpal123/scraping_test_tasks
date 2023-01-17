SELECT 
	GP.`product_name`,
    GP.`product_img_url`,
    GP.`product_url`,
    GP.`product_price_min`,
    GP.`product_short_description`
FROM `grommet_products` GP
INNER JOIN (
	SELECT *
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
	SELECT * 
	FROM `grommet_product_to_keyword` 
	WHERE `keyword_id` = (  
		SELECT    
			`id`  
		FROM `grommet_product_keywords`     
		WHERE `keyword` = 'Aromatherapy' 
	)
) RawProducts ON RawProducts.product_id = GP.id
WHERE GP.`is_sold_out` = 0;

