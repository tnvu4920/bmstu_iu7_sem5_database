Use Lab_01;	-- using database
GO

/*
SELECT TOP 10 SellerFirstName, SellerLastName, SellerVisaCardSeries 
FROM dbo.tblSeller 
WHERE (SellerGender = N'Male') AND (SellerVisaCardSeries LIKE N'41%1');
GO

SELECT TOP 10 BuyerFirstName, BuyerLastName, BuyerVisaCardSeries 
FROM dbo.tblBuyer 
WHERE (BuyerGender = N'Female') AND (BuyerVisaCardSeries LIKE N'41%4');
GO


SELECT Top 10 * 
FROM dbo.tblBill INNER JOIN dbo.tblSeller  ON tblBill.BillSellerID = tblSeller.SellerID
                 INNER JOIN dbo.tblBuyer   ON tblBill.BillBuyerID = tblBuyer.BuyerID
				 INNER JOIN dbo.tblProduct ON tblBill.BillProductID = tblProduct.ProductID;
GO

SELECT SellerFirstName, SellerLastName, ProductName, BillQuantity, BillPrice
FROM dbo.tblBill INNER JOIN dbo.tblSeller  ON tblBill.BillSellerID = tblSeller.SellerID
				 INNER JOIN dbo.tblProduct ON tblBill.BillProductID = tblProduct.ProductID
				 ORDER BY BillPrice ASC;
GO
*/
SELECT TOP 10 * FROM dbo.tblBill;

DELETE FROM dbo.tblBill
	WHERE tblBill.BillProductID = 95
