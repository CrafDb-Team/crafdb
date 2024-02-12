-- liquibase formatted sql

-- changeset batandwa:orders-table-creation
CREATE TABLE CustomerOrder (
  OrderID serial PRIMARY KEY,
  CustomerID integer NOT NULL,
  CreatedOn datetime NOT NULL
);

-- rollback DROP TABLE Order;
