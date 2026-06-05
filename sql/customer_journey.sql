CREATE DATABASE customer_journey;
USE customer_journey;

-- =====================================
-- 1. CREATE RAW TABLES
-- =====================================

CREATE TABLE events (
    event_date DATE,
    event_name VARCHAR(50),
    user_pseudo_id VARCHAR(100),
    item_id VARCHAR(100),
    traffic_source VARCHAR(100)
);

CREATE TABLE users (
    user_id VARCHAR(100),
    user_type VARCHAR(50)
);

CREATE TABLE items (
    item_id VARCHAR(100),
    item_name VARCHAR(255),
    category VARCHAR(100),
    price DECIMAL(10,2)
);

-- =====================================
-- 2. CHECK DATA
-- =====================================

SELECT * FROM events LIMIT 10;
SELECT * FROM users LIMIT 10;
SELECT * FROM items LIMIT 10;

-- =====================================
-- 3. FUNNEL ANALYSIS
-- view_item → add_to_cart → purchase
-- =====================================

CREATE TABLE funnel_metrics AS
WITH funnel AS (

    SELECT
        COUNT(DISTINCT CASE
            WHEN event_name = 'view_item'
            THEN user_pseudo_id
        END) AS viewed_users,

        COUNT(DISTINCT CASE
            WHEN event_name = 'add_to_cart'
            THEN user_pseudo_id
        END) AS cart_users,

        COUNT(DISTINCT CASE
            WHEN event_name = 'purchase'
            THEN user_pseudo_id
        END) AS purchased_users

    FROM events
)

SELECT *,
ROUND((cart_users * 100.0 / viewed_users),2)
AS cart_conversion_rate,

ROUND((purchased_users * 100.0 / cart_users),2)
AS purchase_conversion_rate

FROM funnel;

SELECT * FROM funnel_metrics;

-- =====================================
-- 4. CHANNEL PERFORMANCE
-- =====================================

CREATE TABLE channel_performance AS
SELECT
    traffic_source,

    COUNT(DISTINCT user_pseudo_id)
    AS total_users,

    COUNT(CASE
        WHEN event_name = 'purchase'
        THEN 1
    END) AS purchases,

    ROUND(
        COUNT(CASE
            WHEN event_name = 'purchase'
            THEN 1
        END) * 100.0
        /
        COUNT(DISTINCT user_pseudo_id),
    2) AS conversion_rate

FROM events
GROUP BY traffic_source
ORDER BY conversion_rate DESC;

SELECT * FROM channel_performance;

-- =====================================
-- 5. CUSTOMER SEGMENT ANALYSIS
-- new vs returning users
-- =====================================

CREATE TABLE customer_segments AS
SELECT
    u.user_type,

    COUNT(DISTINCT e.user_pseudo_id)
    AS total_users,

    COUNT(CASE
        WHEN e.event_name = 'purchase'
        THEN 1
    END) AS purchases,

    ROUND(
        COUNT(CASE
            WHEN e.event_name = 'purchase'
            THEN 1
        END) * 100.0
        /
        COUNT(DISTINCT e.user_pseudo_id),
    2) AS conversion_rate

FROM events e
JOIN users u
ON e.user_pseudo_id = u.user_id

GROUP BY u.user_type;

SELECT * FROM customer_segments;

-- =====================================
-- 6. TOP SELLING PRODUCTS
-- =====================================

CREATE TABLE top_products AS
SELECT
    i.item_name,
    i.category,

    COUNT(*) AS total_purchases

FROM events e
JOIN items i
ON e.item_id = i.item_id

WHERE event_name = 'purchase'

GROUP BY i.item_name, i.category
ORDER BY total_purchases DESC
LIMIT 10;

SELECT * FROM top_products;

-- =====================================
-- 7. FIRST TOUCH ATTRIBUTION
-- =====================================

CREATE TABLE first_touch_attribution AS
WITH ranked_events AS (

SELECT
    user_pseudo_id,
    traffic_source,
    event_date,

    ROW_NUMBER() OVER(
        PARTITION BY user_pseudo_id
        ORDER BY event_date
    ) AS rn

FROM events

)

SELECT
    traffic_source,
    COUNT(*) AS users_acquired

FROM ranked_events
WHERE rn = 1

GROUP BY traffic_source
ORDER BY users_acquired DESC;

SELECT * FROM first_touch_attribution;

-- =====================================
-- 8. LAST TOUCH ATTRIBUTION
-- =====================================

CREATE TABLE last_touch_attribution AS
WITH ranked_events AS (

SELECT
    user_pseudo_id,
    traffic_source,
    event_date,

    ROW_NUMBER() OVER(
        PARTITION BY user_pseudo_id
        ORDER BY event_date DESC
    ) AS rn

FROM events

)

SELECT
    traffic_source,
    COUNT(*) AS converted_users

FROM ranked_events
WHERE rn = 1

GROUP BY traffic_source
ORDER BY converted_users DESC;

SELECT * FROM last_touch_attribution;

-- =====================================
-- 9. BUSINESS INSIGHTS QUERY
-- =====================================

SELECT
    traffic_source,
    conversion_rate,

    CASE
        WHEN conversion_rate > 15
        THEN 'High Performing Channel'

        WHEN conversion_rate BETWEEN 8 AND 15
        THEN 'Moderate Channel'

        ELSE 'Needs Optimization'
    END AS business_recommendation

FROM channel_performance;