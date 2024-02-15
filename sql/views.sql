-- liquibase formatted sql

-- changeset rtrickett:beer-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewBeerInfo" AS
SELECT "BeerID", "BeerName", "BeerDesc", "BeerType", "PricePerKeg"
FROM "Beer" JOIN "BeerType" ON "Beer"."BeerTypeID" = "BeerType"."BeerTypeID";
-- rollback DROP VIEW "viewBeerInfo"

-- changeset rtrickett:batch-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewBatchInfo" AS
SELECT "BatchID", "BeerName", "BatchStatus"
FROM "Batch" 
    JOIN "BatchStatus" ON "Batch"."BatchStatusID" = "BatchStatus"."BatchStatusID"
    JOIN "Beer" ON "Batch"."BeerID" = "Beer"."BeerID";
-- rollback DROP VIEW "viewBatchInfo"

-- changeset rtrickett:order-item-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewOrderItemInfo" AS 
SELECT "OrderItemID", "OrderID", "KegID", "OrderState", "PriceAtSale"
FROM "OrderItem" JOIN "OrderItemState" ON "OrderItem"."OrderItemStateID" = "OrderItemState"."OrderItemStateID";
-- rollback DROP VIEW "viewOrderItemInfo"

-- changeset rtrickett:keg-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewKegInfo" AS
SELECT "KegID", "Keg"."BatchID", "BeerName", "ExpiryDate"
FROM "Keg" JOIN "viewBatchInfo" ON "Keg"."BatchID" = "viewBatchInfo"."BatchID";
-- rollback DROP VIEW "viewKegInfo"

-- changeset rtrickett:order-summaries-view runOnChange:true
CREATE OR REPLACE VIEW "viewOrderSummaries" AS
SELECT "viewOrderItemInfo"."OrderID", "CustomerName", "BeerName", "OrderState", COUNT(*) AS "Quantity"
FROM "viewOrderItemInfo" 
    JOIN "viewKegInfo" ON "viewOrderItemInfo"."KegID" = "viewKegInfo"."KegID"
    JOIN (
        SELECT "Order"."OrderID", "Name" AS "CustomerName"
        FROM "Order" JOIN "Customer" ON "Order"."CustomerID" = "Customer"."CustomerID"
    ) AS selectTable ON "viewOrderItemInfo"."OrderID" = selectTable."OrderID"
GROUP BY "viewOrderItemInfo"."OrderID", "CustomerName", "BeerName", "OrderState";
-- rollback DROP VIEW "viewOrderSummaries"

-- changeset rtrickett:stock-on-hand-view runOnChange:true
CREATE OR REPLACE VIEW "viewStockOnHand" AS
SELECT "BeerName", "ExpiryDate", COUNT(*) AS "Quantity"
FROM "viewKegInfo" LEFT JOIN "viewOrderItemInfo" ON "viewKegInfo"."KegID" = "viewOrderItemInfo"."KegID"
WHERE "ExpiryDate" > CURRENT_DATE AND ("OrderState" = 'Returned with Defect' OR "viewOrderItemInfo"."KegID" IS NULL)
GROUP BY "BeerName", "ExpiryDate";
-- rollback DROP VIEW "viewStockOnHand"