/*
======================================================
Kiểm tra chất lượng
======================================================
Mục đích của Script:
  Script này thực hiện các kiểm tra chất lượng đối với lớp Gold
  Các kiểm tra bao gồm:
    - Các khóa thay thế trong bảng dimension có là duy nhất hay không?
    - Dữ liệu tham chiếu có chính xác và đầy đủ không?
Lưu ý khi sử dụng:
  Điều tra và giải quyết bất kỳ lỗi nào xuất hiện trong quá trình 
  kiểm tra.
*/
-- Kiểm tra khóa customer_key trong gold.dim_customers
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Kiểm tra khóa product_key trong gold.dim_products
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Kiểm tra bảng gold.fact_sales
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL 
