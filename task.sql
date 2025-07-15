
# GeMaxQuantity Stored Procedure

DROP PROCEDURE IF EXISTS GetMaxQuantity;

DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(quantityOrder) AS max_quantity FROM Orders;
END //

DELIMITER ;


# GetOrderDetail prepared statement

PREPARE GetOrderDetail FROM 
    'SELECT OrderID, Quantity, OrderCost 
     FROM Orders 
     WHERE CustomerID = ?';


# CancelOrder Stored Procedure

DROP PROCEDURE IF EXISTS CancelOrder;

DELIMITER //

CREATE PROCEDURE CancelOrder @OrderID INT AS
BEGIN
    DELETE FROM Orders WHERE OrderID = @OrderID;
END //

DELIMITER ;


# ManageBooking Stored Procedure

CREATE PROCEDURE ManageBooking
    @idBookings INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Bookings WHERE idBookings = @idBookings)
        BEGIN
            SELECT idBookings, dateBookings, table_num, idCustomer, idStaff
            FROM Bookings
            WHERE idBookings = @idBookings;
        END
        ELSE
        BEGIN
            RAISERROR ('Booking ID does not exist.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;


# UpdateBooking Stored Procedure

CREATE PROCEDURE UpdateBooking
    @idBookings INT,
    @dateBookings DATE,
    @table_num INT,
    @idCustomer INT,
    @idStaff INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Bookings WHERE idBookings = @idBookings)
        BEGIN
            UPDATE Bookings
            SET dateBookings = @dateBookings,
                table_num = @table_num,
                idCustomer = @idCustomer,
                idStaff = @idStaff
            WHERE idBookings = @idBookings;
            SELECT 'Booking updated successfully.' AS Result;
        END
        ELSE
        BEGIN
            RAISERROR ('Booking ID does not exist.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

# AddBooking Stored Procedure

CREATE PROCEDURE AddBooking
    @dateBookings DATE,
    @table_num INT,
    @idCustomer INT,
    @idStaff INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        INSERT INTO Bookings (dateBookings, table_num, idCustomer, idStaff)
        VALUES (@dateBookings, @table_num, @idCustomer, @idStaff);
        
        SELECT 'Booking added successfully. BookingID: ' + CAST(SCOPE_IDENTITY() AS VARCHAR) AS Result;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

# CancelBooking Stored Procedure

CREATE PROCEDURE CancelBooking
    @idBookings INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Bookings WHERE idBookings = @idBookings)
        BEGIN
            DELETE FROM Bookings WHERE idBookings = @idBookings;
            SELECT 'Booking cancelled successfully.' AS Result;
        END
        ELSE
        BEGIN
            RAISERROR ('Booking ID does not exist.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;