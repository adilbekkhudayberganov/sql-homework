SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS running_total
FROM sales_data
ORDER BY customer_id, order_date;

SELECT 
    product_category,
    COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;

SELECT 
    product_category,
    MAX(total_amount) AS max_total_amount
FROM sales_data
GROUP BY product_category;

SELECT 
    product_category,
    MIN(unit_price) AS min_unit_price
FROM sales_data
GROUP BY product_category;

SELECT 
    order_date,
    AVG(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg_3days
FROM sales_data;

SELECT 
    region,
    SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;

SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS total_purchase,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_overall
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY rank_overall;

SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS diff_from_prev
FROM sales_data
ORDER BY customer_id, order_date;

SELECT *
FROM (
    SELECT 
        product_category,
        product_name,
        unit_price,
        DENSE_RANK() OVER (
            PARTITION BY product_category
            ORDER BY unit_price DESC
        ) AS rnk
    FROM sales_data
) t
WHERE rnk <= 3
ORDER BY product_category, rnk;

SELECT 
    region,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY region
        ORDER BY order_date
    ) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date;

SELECT
    product_category,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
    ) AS cumulative_revenue
FROM sales_data
ORDER BY product_category, order_date;

SELECT
    ID,
    SUM(ID) OVER (
        ORDER BY ID
    ) AS SumPreValues
FROM YourTable; 

SELECT
    Value,
    SUM(Value) OVER (
        ORDER BY Value
    ) AS [Sum of Previous]
FROM OneColumn;

SELECT 
    customer_id,
    customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;

WITH region_avg AS (
    SELECT 
        region,
        AVG(total_amount) AS avg_spending
    FROM sales_data
    GROUP BY region
)
SELECT DISTINCT
    s.customer_id,
    s.customer_name,
    s.region
FROM sales_data s
JOIN region_avg r 
    ON s.region = r.region
WHERE s.total_amount > r.avg_spending;

SELECT
    region,
    customer_id,
    customer_name,
    SUM(total_amount) AS total_spending,
    RANK() OVER (
        PARTITION BY region
        ORDER BY SUM(total_amount) DESC
    ) AS region_rank
FROM sales_data
GROUP BY region, customer_id, customer_name
ORDER BY region, region_rank;


SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;

WITH monthly_sales AS (
    SELECT
        FORMAT(order_date, 'yyyy-MM') AS month,
        SUM(total_amount) AS total_sales
    FROM sales_data
    GROUP BY FORMAT(order_date, 'yyyy-MM')
)
SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS prev_month_sales,
    CASE 
        WHEN LAG(total_sales) OVER (ORDER BY month) IS NULL THEN NULL
        ELSE ROUND(
            (total_sales - LAG(total_sales) OVER (ORDER BY month)) 
            / LAG(total_sales) OVER (ORDER BY month) * 100, 2
        )
    END AS growth_rate_percent
FROM monthly_sales;


SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS last_order_amount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    );


