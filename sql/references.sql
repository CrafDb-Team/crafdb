-- liquibase formatted sql

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
ADD CONSTRAINT Batch_BatchStatusID_FK OREIGN KEY (BatchStatusID) REFERENCES BatchStatus (BatchStatusID);
-- rollback ALTER TABLE Batch DROP CONSTRAINT Batch_BatchStatusID_FK