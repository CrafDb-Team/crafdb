--liquibase formatted sql

--changeset emokoena:CreateOderItemsForCustomerOrder
CREATE PROCEDURE CreateOderItemsForCustomerOrder(
   customer_id int,
   beer_id int,  
   quantity int,
   order_id int
)
LANGUAGE plpgsql    
AS 
$$
BEGIN
    /*
    OrderID integer NOT NULL,
    KegID integer NOT NULL,
    OrderItemStateID integer NOT NULL,
    PriceAtSale numeric NOT NULL
    */
    INSERT INTO OrderItem oi
    SELECT 
        order_id,
        0,
        br.PricePerKeg
    FROM Keg kg
    INNER JOIN Beer br on br.BeerID = kg.BeerID
    FETCH FIRST quantity ROWS ONLY;
END;
$$;
-- rollback DROP PROCEDURE IF EXISTS CreateOderItemsForCustomerOrder(INTEGER,INTEGER,INTEGER,INTEGER);
