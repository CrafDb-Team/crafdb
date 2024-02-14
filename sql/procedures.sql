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
    INSERT INTO OrderItem oi (OrderID, KegID, OrderItemStateID, PriceAtSale)
    SELECT 
        order_id,
        kg.KegID,
        0,
        br.PricePerKeg
    FROM Keg kg
    INNER JOIN Beer br on br.BeerID = kg.BeerID
    WHERE NOT EXISTS (
        SELECT 
            KegID, 
            OrderItemStateID 
        FROM OrderItem oi2 
        WHERE oi2.KegID = kg.KegID
        AND oi2.OrderItemStateID IN (0, 1, 2, 3)
    )
    LIMIT quantity;

    COMMIT;
END;
$$;
-- rollback DROP PROCEDURE IF EXISTS CreateOderItemsForCustomerOrder(INTEGER,INTEGER,INTEGER,INTEGER);
