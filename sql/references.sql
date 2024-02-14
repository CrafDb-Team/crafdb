-- liquibase formatted sql

-- changeset batandwa:order-items-order-item-state-id-fk-creation
ALTER TABLE OrderItem
ADD CONSTRAINT OrderItem_OrderItemStateID_FK FOREIGN KEY(OrderItemStateID)
    REFERENCES OrderItemState(OrderItemStateID)
-- rollback ALTER TABLE OrderItem DROP CONSTRAINT OrderItem_OrderItemStateID_FK;

-- changeset rtrickett:keg-batch-fk-
ALTER TABLE Keg 
ADD CONSTRAINT Keg_BatchID_FK FOREIGN KEY (BatchID) REFERENCES Batch (BatchID);
-- rollback ALTER TABLE Keg DROP CONSTRAINT Keg_BatchID_FK

-- changeset rtrickett:keg-batch-fk--
ALTER TABLE Batch 
ADD CONSTRAINT Batch_BeerID_FK FOREIGN KEY (BeerID) REFERENCES Beer (BeerID);
-- rollback ALTER TABLE Batch DROP CONSTRAINT Batch_BeerID_FK

-- changeset rtrickett:keg-batch-fk
ALTER TABLE Batch 
ADD CONSTRAINT Batch_BatchStatusID_FK FOREIGN KEY (BatchStatusID) REFERENCES BatchStatus (BatchStatusID);
-- rollback ALTER TABLE Batch DROP CONSTRAINT Batch_BatchStatusID_FK

--changeset ljordaan:alter-table-beer-table
ALTER TABLE Beer
ADD CONSTRAINT Beer_BeerTypeID_FK FOREIGN KEY (BeerTypeID)
  REFERENCES BeerType(BeerTypeID);
-- rollback ALTER TABLE Beer DROP CONSTRAINT Beer_BeerTypeID_FK

--changeset batandwa:order-items-rename-order-id-column
ALTER TABLE OrderItem
  RENAME COLUMN OrderID TO CustomerOrderID
-- rollback ALTER TABLE OrderItem RENAME COLUMN CustomerOrderID TO OrderID;

--changeset batandwa:order-item-customer-order-id-fk
ALTER TABLE OrderItem
ADD CONSTRAINT OrderItem_CustomerOrderID_FK FOREIGN KEY (CustomerOrderID)
  REFERENCES CustomerOrder (CustomerOrderID);
-- rollback ALTER TABLE OrderItem DROP CONSTRAINT OrderItem_CustomerOrderID_FK;

--changeset batandwa:customer-order-customer-id-fk
ALTER TABLE CustomerOrder
ADD CONSTRAINT CustomerOrder_CustomerID_FK FOREIGN KEY (CustomerID)
  REFERENCES Customer (CustomerID);
-- rollback ALTER TABLE OrderItem DROP CONSTRAINT CustomerOrder_CustomerID_FK;
