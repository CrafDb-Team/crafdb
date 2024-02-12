-- liquibase formatted sql

-- changeset batandwa:order-items-table-creation
CREATE TABLE OrderItem (
  OrderItemID serial PRIMARY KEY,
  OrderID integer,
  KegID integer,
  OrderItemStateID integer,
  PriceAtSale numeric NOT NULL
);

CREATE TABLE OrderItemState (
  OrderItemStateID serial PRIMARY KEY,
  OrderState varchar(32)
);

ALTER TABLE OrderItem
ADD CONSTRAINT OrderItem_OrderItemStateID_FK FOREIGN KEY(OrderItemStateID)
    REFERENCES OrderItemState(OrderItemStateID)

-- rollback DROP TABLE OrderItem;
-- rollback DROP TABLE OrderItemState;
-- rollback ALTER TABLE OrderItem DROP CONSTRAINT OrderItem_OrderItemStateID_FK;
