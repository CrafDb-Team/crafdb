--liquibase formatted sql

--changeset emokoena:CreateOderItemsForCustomerOrder
CREATE PROCEDURE CreateOderItemsForCustomerOrder(
   beer_id integer,  
   order_id integer,
   quantity integer,
)
LANGUAGE plpgsql    
AS 
$$
BEGIN
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
    AND kg.BeerID = beer_id
    LIMIT quantity;

    COMMIT;
END;
$$;
-- rollback DROP PROCEDURE IF EXISTS CreateOderItemsForCustomerOrder(INTEGER,INTEGER,INTEGER);
