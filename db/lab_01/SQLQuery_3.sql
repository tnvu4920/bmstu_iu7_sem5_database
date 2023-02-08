BULK INSERT dbo.tblSeller FROM '/Seller.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = '\t', ROWTERMINATOR = '\n');
GO

BULK INSERT dbo.tblBuyer FROM '/Buyer.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = '\t', ROWTERMINATOR = '\n');
GO

BULK INSERT dbo.tblCompany FROM '/Company.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = ';', ROWTERMINATOR = '\n');
GO

BULK INSERT dbo.tblProduct FROM '/Product.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = '\t', ROWTERMINATOR = '\n');
GO

BULK INSERT dbo.tblBill FROM '/Bill.txt'
WITH (DATAFILETYPE = 'char', FIELDTERMINATOR = '\t', ROWTERMINATOR = '\n');
GO