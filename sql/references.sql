-- liquibase formatted sql

-- changeset batandwa:order-items-orders-fk-creation
ALTER TABLE "OrderItem"
ADD CONSTRAINT "OrderItem_OrderItemStateID_FK" FOREIGN KEY("OrderItemStateID") REFERENCES "OrderItemState"("OrderItemStateID")
-- rollback ALTER TABLE "OrderItem" DROP CONSTRAINT "OrderItem_OrderItemStateID_FK";

-- changeset rtrickett:keg-batch-fk-creation
ALTER TABLE "Keg" 
ADD CONSTRAINT "Keg_BatchID_FK" FOREIGN KEY ("BatchID") REFERENCES "Batch" ("BatchID");
-- rollback ALTER TABLE "Keg" DROP CONSTRAINT "Keg_BatchID_FK"

-- changeset rtrickett:batch-beer-fk-creation
ALTER TABLE "Batch" 
ADD CONSTRAINT "Batch_BeerID_FK" FOREIGN KEY ("BeerID") REFERENCES "Beer" ("BeerID");
-- rollback ALTER TABLE "Batch" DROP CONSTRAINT "Batch_BeerID_FK"

-- changeset rtrickett:batch-batchstate-fk-creation
ALTER TABLE "Batch" 
ADD CONSTRAINT "Batch_BatchStatusID_FK" FOREIGN KEY ("BatchStatusID") REFERENCES "BatchStatus" ("BatchStatusID");
-- rollback ALTER TABLE "Batch" DROP CONSTRAINT "Batch_BatchStatusID_FK"

--changeset ljordaan:beer-beertype-fk-creation
ALTER TABLE "Beer"
ADD CONSTRAINT "Beer_BeerTypeID_FK" FOREIGN KEY ("BeerTypeID") REFERENCES "BeerType"("BeerTypeID");
-- rollback ALTER TABLE "Beer" DROP CONSTRAINT "Beer_BeerTypeID_FK"

--changeset batandwa:order-item-order-id-fk
ALTER TABLE "OrderItem"
ADD CONSTRAINT "OrderItem_OrderID_FK" FOREIGN KEY ("OrderID")
  REFERENCES "Order" ("OrderID");
-- rollback ALTER TABLE OrderItem DROP CONSTRAINT OrderItem_OrderID_FK;

--changeset batandwa:order-customer-id-fk
ALTER TABLE "Order"
ADD CONSTRAINT "Order_CustomerID_FK" FOREIGN KEY ("CustomerID")
  REFERENCES "Customer" ("CustomerID");
-- rollback ALTER TABLE OrderItem DROP CONSTRAINT Order_CustomerID_FK;
