WITH first_user AS (
    SELECT "CustomerID", MIN("InvoiceDateTime") AS first_date
    FROM public.ecommerce_data
    WHERE "CustomerID" IS NOT NULL
    GROUP BY "CustomerID"
),
filter_info AS (
    SELECT "e"."CustomerID", "f"."first_date", "f"."CustomerID", "e"."InvoiceDateTime"
    FROM public.ecommerce_data e
    JOIN first_user f ON "e"."CustomerID" = "f"."CustomerID"
)
SELECT *,
       DATE_PART('week', InvoiceDateTime - first_date) AS weeks
FROM filter_info
LIMIT 10;
