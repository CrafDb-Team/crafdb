-- liquibase formatted sql

-- changeset rtrickett:beer-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewBeerInfo" AS
SELECT "BeerID", "BeerName", "BeerDesc", "BeerType", "PricePerKeg"
FROM "Beer" JOIN "BeerType" ON "Beer"."BeerTypeID" = "BeerType"."BeerTypeID";
-- rollback DROP VIEW "viewBeerInfo"

-- changeset rtrickett:batch-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewBatchInfo" AS
SELECT "BatchID", "BeerName", "BeerType", "BatchStatus"
FROM "Batch" 
    JOIN "BatchStatus" ON "Batch"."BatchStatusID" = "BatchStatus"."BatchStatusID"
    JOIN "viewBeerInfo" ON "Batch"."BeerID" = "viewBeerInfo"."BeerID";
-- rollback DROP VIEW "viewBatchInfo"

-- changeset rtrickett:order-item-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewOrderItemInfo" AS 
SELECT "OrderItemID", "OrderID", "KegID", "OrderState", "PriceAtSale"
FROM "OrderItem" JOIN "OrderItemState" ON "OrderItem"."OrderItemStateID" = "OrderItemState"."OrderItemStateID";
-- rollback DROP VIEW "viewOrderItemInfo"

-- changeset rtrickett:keg-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewKegInfo" AS
SELECT "KegID", "Keg"."BatchID", "BeerName", "BeerType", "ExpiryDate"
FROM "Keg" JOIN "viewBatchInfo" ON "Keg"."BatchID" = "viewBatchInfo"."BatchID";
-- rollback DROP VIEW "viewKegInfo"

-- changeset rtrickett:order-summaries-view runOnChange:true
CREATE OR REPLACE VIEW "viewOrderSummaries" AS
SELECT "viewOrderItemInfo"."OrderID", "CustomerName", "BeerName", "BeerType", "OrderState", COUNT(*) AS "Quantity"
FROM "viewOrderItemInfo" 
    JOIN "viewKegInfo" ON "viewOrderItemInfo"."KegID" = "viewKegInfo"."KegID"
    JOIN (
        SELECT "Order"."OrderID", "Name" AS "CustomerName"
        FROM "Order" JOIN "Customer" ON "Order"."CustomerID" = "Customer"."CustomerID"
    ) AS selectTable ON "viewOrderItemInfo"."OrderID" = selectTable."OrderID"
GROUP BY "viewOrderItemInfo"."OrderID", "CustomerName", "BeerName", "BeerType", "OrderState"
ORDER BY "viewOrderItemInfo"."OrderID", "CustomerName", "BeerName", "BeerType", "OrderState";
-- rollback DROP VIEW "viewOrderSummaries"

-- changeset rtrickett:stock-on-hand-view runOnChange:true
CREATE OR REPLACE VIEW "viewStockOnHand" AS
SELECT "BeerName", "BeerType", "ExpiryDate", COUNT(*) AS "Quantity"
FROM "viewKegInfo" LEFT JOIN "OrderItem" ON "viewKegInfo"."KegID" = "OrderItem"."KegID"
WHERE "ExpiryDate" > CURRENT_DATE AND (
    "OrderItemStateID" NOT IN (1, 2, 3, 4)
    OR "OrderItem"."KegID" IS NULL
)
GROUP BY "BeerName", "BeerType", "ExpiryDate"
ORDER BY "BeerName", "BeerType", "ExpiryDate";
-- rollback DROP VIEW "viewStockOnHand"