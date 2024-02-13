--changeset ljordaan:alter-table-beer-table
ALTER TABLE Beer
ADD CONSTRAINT Beer_BeerTypeID_FK FOREIGN KEY ("BeerTypeID") 
  REFERENCES BeerType("BeerTypeID");
-- rollback ALTER TABLE Beer DROP CONSTRAINT Beer_BeerTypeID_FK;