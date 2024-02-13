-- liquibase formatted sql

-- changeset batandwa:order-items-orders-fk-creation
ALTER TABLE OrderItem
ADD CONSTRAINT OrderItem_OrderItemStateID_FK FOREIGN KEY(OrderItemStateID)
    REFERENCES OrderItemState(OrderItemStateID)

-- rollback ALTER TABLE OrderItem DROP CONSTRAINT OrderItem_OrderItemStateID_FK;
