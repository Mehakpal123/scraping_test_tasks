SELECT 
	GP.`product_name`,
    GP.`product_img_url`,
    GP.`product_url`,
    GP.`product_price_min`,
    GP.`product_short_description`
FROM `grommet_products` GP
INNER JOIN
(
	SELECT `product_id`
		FROM `grommet_product_categories` GPC
	WHERE GPC.product_category_id = (
		SELECT `id` 
		FROM grommet_gifts_categories 
		WHERE `sub_category` = 'Jewelry'
	)
) RawProduct ON RawProduct.product_id = GP.id
WHERE GP.`is_sold_out` = 0;