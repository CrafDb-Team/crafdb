-- liquibase formatted sql

-- changeset ljordaan:table-orderitemstate-insertion
INSERT INTO "OrderItemState" ("OrderItemStateID", "OrderState")
VALUES 
    (1, 'Ordered'), 
    (2, 'Shipped'), 
    (3, 'Delivered'), 
    (4, 'Returned with Defect'), 
    (5, 'Returned without Defect'), 
    (6, 'Canceled');
-- rollback DELETE FROM TABLE "OrderItemState"; 