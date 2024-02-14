-- liquibase formatted sql

-- changeset batandwa:create-customer-orders-table
CREATE TABLE CustomerOrder (
  CustomerOrderID serial PRIMARY KEY,
  CustomerID integer NOT NULL,
  CreatedOn timestamp NOT NULL
);

-- rollback DROP TABLE CustomerOrder;
