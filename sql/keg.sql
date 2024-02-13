-- liquibase formatted sql

-- changeset rtrickett:create-keg-table
CREATE TABLE Keg (
  KegID serial PRIMARY KEY,
  BatchID integer NOT NULL,
  ExpiryDate date NOT NULL
);
-- rollback DROP TABLE Keg