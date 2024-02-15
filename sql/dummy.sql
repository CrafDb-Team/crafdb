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

-- changeset lbradford:table-customer-insertion
INSERT INTO 'Customer' ('CustomerID', 'Name', 'Email', 'ContactNumber') VALUES 
(1, 'Buzzbean', 'dvasyukhnov0@devhub.com', '+352 596 515 9541'),
(2, 'Feednation', 'stiley1@squarespace.com', '+58 869 343 1241'),
(3, 'Thoughtstorm', 'mskudder2@shutterfly.com', '+1 940 597 9707'),
(4, 'Gabspot', 'ddiiorio3@unicef.org', '+86 319 479 6848'),
(5, 'Zoonoodle', 'jeveritt4@jiathis.com', '+86 678 635 4212'),
(6, 'Vidoo', 'bwedderburn5@goo.gl', '+7 484 577 1646'),
(7, 'Photospace', 'obarajaz6@marriott.com', '+51 415 553 9464'),
(8, 'Voonte', 'vdyett7@omniture.com', '+351 659 477 5898'),
(9, 'Livetube', 'tconnachan8@ucla.edu', '+356 937 829 9865'),
(10, 'Kaymbo', 'geades9@naver.com', '+86 575 798 1979');

-- rollback DELETE FROM TABLE "Customer";

-- changeset lbradford:table-order-insertion
INSERT INTO 'Order' ('OrderID', 'CustomerID', 'CreatedOn') VALUES 
(1, 1, '2023-08-25'),
(2, 1, '2023-08-16'),
(3, 1, '2023-09-21'),
(4, 3, '2023-07-05'),
(5, 4, '2024-01-20'),
(6, 5, '2023-02-20'),
(7, 7, '2023-07-12'),
(8, 8, '2023-11-10'),
(9, 8, '2023-11-02'),
(10, 10, '2023-04-29');
-- rollback DELETE FROM TABLE "Order";


-- changeset lbradford:table-keg-insertion
INSERT INTO 'Keg' ('BatchID', 'ExpiryDate') VALUES 
(1, '2023-07-06');
(2, '2024-01-13'),
(2, '2024-01-18'),
(3, '2023-03-29'),
(3, '2023-04-29'),
(4, '2023-09-08'),
(5, '2023-03-22'),
(6, '2023-03-31'),
(7, '2023-08-25'),
(8, '2023-11-19');
-- rollback DELETE FROM TABLE "Keg";
