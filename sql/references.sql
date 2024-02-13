-- liquibase formatted sql

-- changeset batandwa:order-items-orders-fk-creation
ALTER TABLE OrderItem
ADD CONSTRAINT OrderItem_OrderItemStateID_FK FOREIGN KEY(OrderItemStateID)
    REFERENCES OrderItemState(OrderItemStateID)

-- rollback ALTER TABLE OrderItem DROP CONSTRAINT OrderItem_OrderItemStateID_FK;
=======
-- changeset rtrickett:keg-batch-fk
ALTER TABLE Keg 
ADD CONSTRAINT Keg_BatchID_FK FOREIGN KEY (BatchID) REFERENCES Batch (BatchID);
-- rollback ALTER TABLE Keg DROP CONSTRAINT Keg_BatchID_FK

-- changeset rtrickett:keg-batch-fk
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
