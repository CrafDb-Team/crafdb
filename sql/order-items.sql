-- liquibase formatted sql

-- changeset batandwa:order-items-table-creation
CREATE TABLE OrderItem (
  OrderItemID serial PRIMARY KEY,
  OrderID integer NOT NULL,
  KegID integer NOT NULL,
  OrderItemStateID integer NOT NULL,
  PriceAtSale numeric NOT NULL
);

CREATE TABLE OrderItemState (
  OrderItemStateID serial PRIMARY KEY,
  OrderState varchar(32) NOT NULL
);

-- rollback DROP TABLE OrderItem;
-- rollback DROP TABLE OrderItemState;
