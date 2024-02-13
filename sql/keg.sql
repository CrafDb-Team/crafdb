-- liquibase formatted sql

-- changeset rtrickett:create-keg-table
CREATE TABLE Keg (
  KegID serial PRIMARY KEY,
  BatchID integer,
  ExpiryDate date
);
-- rollback DROP TABLE Keg