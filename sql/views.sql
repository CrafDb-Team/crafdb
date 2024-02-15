-- liquibase formatted sql

-- changelog rtrickett:beer-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewBeerInfo" AS
SELECT "BeerID", "BeerName", "BeerDesc", "BeerType", "PricePerKeg"
FROM "Beer" JOIN "BeerType" ON "Beer.BeerTypeID" = "BeerType"."BeerTypeID";
-- rollback DROP VIEW "viewBeerInfo"

-- changelog rtrickett:batch-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewBatchInfo" AS
SELECT "BatchID", "BeerName", "BatchStatus"
FROM "Batch" 
    JOIN "BatchStatus" ON "Batch"."BatchStatusID" = "BatchStatus"."BatchStatusID"
    JOIN "Beer" ON "Batch"."BeerID" = "Beer"."BeerID";
-- rollback DROP VIEW "viewBatchInfo"

-- changelog rtrickett:order-item-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewOrderItemInfo" AS 
SELECT "ItemID", "OrderID", "KegID", "OrderState", "PriceAtSale"
FROM "OrderItem" JOIN "OrderItemState" ON "OrderItem"."OrderItemStateID" = "OrderItemState"."OrderItemStateID";
-- rollback DROP VIEW "viewOrderItemInfo"

-- changelog rtrickett:keg-info-view runOnChange:true
CREATE OR REPLACE VIEW "viewKegInfo" AS
SELECT "KegID", "BatchID", "BeerName", "ExpiryDate"
FROM "Keg" ON "viewBatchInfo" ON "Keg"."BatchID" = "viewBatchInfo"."BatchID";
-- rollback DROP VIEW "viewKegInfo"

-- changelog rtrickett:order-summaries-view runOnChange:true
CREATE OR REPLACE VIEW "viewOrderSummaries" AS
SELECT "OrderID", "Name", COUNT(*) AS "Quantity"
FROM "viewOrderItemInfo" 
    JOIN "viewKegInfo" ON "viewOrderItemInfo"."KegID" = "viewKegInfo"."KegID"
    JOIN (
        SELECT "OrderID", "Name" AS "CustomerName"
        FROM "Order" JOIN "Customer" ON "Order"."CustomerID" = "Customer"."CustomerID"
    ) AS selectTable ON "viewOrderItemInfo"."OrderID" = selectTable."OrderID"
GROUP BY "OrderID", "BeerName", "OrderStatus";
-- rollback DROP VIEW "viewOrderSummaries"

-- changeset rtrickett:stock-on-hand-view runOnChange:true
CREATE OR REPLACE VIEW "viewStockOnHand" AS
SELECT "BeerName", COUNT(*) AS "Quantity"
FROM "viewKegInfo" LEFT JOIN "viewOrderItemInfo" ON "viewKegInfo"."KegID" = "viewOrderItemInfo"."KegID"
WHERE "ExpiryDate" > CURRENT_DATE AND ("OrderState" = "Returned with Defect" OR "viewOrderItemInfo"."KegID" IS NULL);
-- rollback DROP VIEW "viewStockOnHand"