-- liquibase formatted sql

-- changeset rtrickett:create-batch-table
CREATE TABLE Batch (
  BatchID serial PRIMARY KEY,
  BeerID integer NOT NULL,
  BatchStatusID integer NOT NULL
);
-- rollback DROP TABLE Batch

-- changeset rtrickett:create-batch-status-table
CREATE TABLE BatchStatus (
  BatchStatusID serial PRIMARY KEY,
  BatchStatus varchar NOT NULL
);
-- rollback DROP TABLE BatchStatus
