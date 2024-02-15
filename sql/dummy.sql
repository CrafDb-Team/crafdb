-- liquibase formatted sql

-- changeset lbradford:table-customer-insertion
INSERT INTO "Customer" ('CustomerID', 'Name', 'Email', 'ContactNumber') VALUES 
(1, 'Buzzbean', 'dvasyukhnov0@devhub.com', '+27 596 515 9541'),
(2, 'Feednation', 'stiley1@squarespace.com', '+27 869 343 1241'),
(3, 'Thoughtstorm', 'mskudder2@shutterfly.com', '+27 940 597 9707'),
(4, 'Gabspot', 'ddiiorio3@unicef.org', '+27 319 479 6848'),
(5, 'Zoonoodle', 'jeveritt4@jiathis.com', '+27 678 635 4212'),
(6, 'Vidoo', 'bwedderburn5@goo.gl', '+27 484 577 1646'),
(7, 'Photospace', 'obarajaz6@marriott.com', '+27 415 553 9464'),
(8, 'Voonte', 'vdyett7@omniture.com', '+27 659 477 5898'),
(9, 'Livetube', 'tconnachan8@ucla.edu', '+27 937 829 9865'),
(10, 'Kaymbo', 'geades9@naver.com', '+27 575 798 1979');
-- rollback DELETE FROM TABLE "Customer";

-- changeset lbradford:table-order-insertion
INSERT INTO "Order" ('OrderID', 'CustomerID', 'CreatedOn') VALUES 
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

-- changeset ljordaan:table-orderitemstate-insertion
INSERT INTO "OrderItemState" ('OrderState')
VALUES 
    ('Ordered'), 
    ('Shipped'), 
    ('Delivered'), 
    ('Returned with Defect'), 
    ('Returned without Defect'), 
    ('Canceled');
-- rollback DELETE FROM TABLE "OrderItemState";

-- changeset ljordaan:table-batchstatus-insertion
INSERT INTO "BatchStatus" ('BatchStatus') 
VALUES 
('Mixing'),
('Boiling'),
('Cooling'),
('Fermenting'),
('Ready'),
('Kegged');
-- rollback DELETE FROM TABLE "BatchStatus";

-- changeset ljordaan:table-beertype-insertion
INSERT INTO "BeerType" ('BeerType') 
VALUES 
    ('Lager'),
    ('Pale Ale'),
    ('Pilsner'),
-- rollback DELETE FROM TABLE "BeerType";

-- changeset ljordaan:table-beer-insertion
INSERT INTO "Beer" ('BeerName', 'BeerDescription', 'BeerTypeID', 'PricePerKeg') 
VALUES 
('Red Horse', 'Crisp and hoppy with citrus notes', 1, 520.45);
('Allan-Larger', 'Rich and bitter with hints of caramel', 1, 595.79);
('Red Horse', 'Smooth and creamy with a chocolatey finish', 2, 595.21);
('Allan-Larger', 'Light and refreshing with a fruity aroma', 2, 751.86);
('Red Horse', 'Bold and bitter with a piney taste', 3, 658.01);
('Allan-Larger', 'Spicy and complex with a hint of cloves', 3, 779.59);
-- rollback DELETE FROM TABLE "Beer";


-- changeset lbradford:table-batch-insertion
INSERT INTO "Batch" ('BeerID', 'BatchStatusID') VALUES 
(2, 5),
(3, 5),
(5, 6),
(4, 1),
(6, 1),
(1, 5),
(5, 6),
(4, 4);




-- changeset lbradford:table-keg-insertion
INSERT INTO "Keg" ('BatchID', 'ExpiryDate') VALUES 
(1, '2023-07-06');
(2, '2023-01-13'),
(2, '2023-01-18'),
(3, '2023-03-29'),
(3, '2024-04-29'),
(4, '2024-09-08'),
(5, '2024-03-22'),
(6, '2024-03-31'),
(7, '2024-08-25'),
(8, '2024-11-19'),
(8, '2024-11-25');
-- rollback DELETE FROM TABLE "Keg";

-- changeset lbradford:table-orderitem-insertion
INSERT INTO "OrderItem" ('OrderID', 'KegID', 'OrderItemStateID', 'PriceAtSale')
VALUES 
(1, 1, 1, 328.6),
(2, 2, 2, 362.65),
(2, 3, 2, 362.65),
(3, 4, 1, 433.42),
(4, 5, 2, 962.72),
(5, 6, 4, 796.57),
(6, 7, 6, 444.65),
(7, 8, 6, 853.99),
(8, 9, 2, 811.18),
(9, 10, 2, 212.9);
-- rollback DELETE FROM TABLE "OrderItem";
