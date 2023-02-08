--Create database
CREATE DATABASE Lab_01;	
GO

--Using database
Use Lab_01;	
GO

-- Create tables with their properties
CREATE TABLE tblSeller
(
	SellerID INT NOT NULL,
	SellerFirstName VARCHAR(20) NOT NULL,
	SellerLastName VARCHAR(20) NOT NULL,
	SellerGender VARCHAR(10) NOT NULL,
	SellerVisaCardSeries VARCHAR(20) NOT NULL
); 

CREATE TABLE tblBuyer
(
	BuyerID INT NOT NULL,
	BuyerFirstName VARCHAR(20) NOT NULL,
	BuyerLastName VARCHAR(20) NOT NULL,
	BuyerGender VARCHAR(10) NOT NULL,
	BuyerVisaCardSeries VARCHAR(20) NOT NULL
);

CREATE TABLE tblCompany
(
	CompanyID INT NOT NULL,
	CompanyName VARCHAR(50) NOT NULL,
	CompanyLocation VARCHAR(50) NOT NULL
);

CREATE TABLE tblProduct
(
	ProductID INT NOT NULL,
    CompanyID INT NOT NULL,
	ProductName VARCHAR(20) NOT NULL,
	ProductMaterial VARCHAR(20) NOT NULL,
	ProductMadeIn VARCHAR(20) NOT NULL
);

CREATE TABLE tblBill
(
	BillSellerID INT NOT NULL,
	BillBuyerID INT NOT NULL,
	BillProductID INT NOT NULL,
	BillQuantity INT NOT NULL,
	BillPrice INT NOT NULL
);

GO
