USE Lab_01;
GO

-- Add Primary Key and Foreign Key
ALTER TABLE dbo.tblSeller ADD 
	CONSTRAINT PK_SellerID PRIMARY KEY(SellerID),
	CONSTRAINT CK_SellerGender CHECK ((SellerGender = 'Male') OR (SellerGender = 'Female')),
	CONSTRAINT CK_Valid_SellerVisaCardSeries CHECK ((SellerVisaCardSeries LIKE '4%') AND (LEN(SellerVisaCardSeries) = 16)),
    CONSTRAINT UC_SellerVisaCardSeries UNIQUE(SellerVisaCardSeries);

ALTER TABLE dbo.tblBuyer ADD
	CONSTRAINT PK_BuyerID PRIMARY KEY(BuyerID),
	CONSTRAINT CK_BuyerGender CHECK ((BuyerID = 'Male') OR (BuyerID = 'Female')),
	CONSTRAINT CK_Valid_BuyerVisaCardSeries CHECK ((BuyerVisaCardSeries LIKE '4%') AND (LEN(BuyerVisaCardSeries) = 16)),
    CONSTRAINT UC_BuyerVisaCardSeries UNIQUE(BuyerVisaCardSeries);

ALTER TABLE dbo.tblCompany ADD CONSTRAINT PK_CompanyID PRIMARY KEY(CompanyID);

ALTER TABLE dbo.tblProduct ADD
    CONSTRAINT PK_ProductID PRIMARY KEY(ProductID),
    CONSTRAINT FK_Product_Company FOREIGN KEY(CompanyID) REFERENCES dbo.tblCompany(CompanyID);

ALTER TABLE dbo.tblBill ADD
	CONSTRAINT PK_Bill PRIMARY KEY(BillSellerID, BillBuyerID, BillProductID),
	CONSTRAINT FK_Bill_Seller FOREIGN KEY(BillSellerID) REFERENCES dbo.tblSeller(SellerID),
	CONSTRAINT FK_Bill_Buyer FOREIGN KEY(BillBuyerID) REFERENCES dbo.tblBuyer(BuyerID),
	CONSTRAINT FK_Bill_Product FOREIGN KEY(BillProductID) REFERENCES dbo.tblProduct(ProductID);
GO

CREATE RULE RULE_GreaterThanZero AS @value > 0;
GO

EXEC sp_bindrule 'RULE_GreaterThanZero', 'dbo.tblBill.BillQuantity';
EXEC sp_bindrule 'RULE_GreaterThanZero', 'dbo.tblBill.BillPrice';
GO
