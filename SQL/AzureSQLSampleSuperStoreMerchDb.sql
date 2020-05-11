CREATE DATABASE SuperStoreMerchandise

--Product
CREATE TABLE tbl_sys_product (
	ID INT PRIMARY KEY NOT NULL IDENTITY(10001,1),
	Name NVARCHAR(200),
	Description NVARCHAR(MAX),
	Brand NVARCHAR(200),
	Department NVARCHAR(200),
	Category NVARCHAR(200),
	FacingsX NUMERIC(10,2),
	FacingsY NUMERIC(10,2),
	FacingsZ NUMERIC(10,2),
	ParentPlanogramID INT,
	ProductImageURL NVARCHAR(MAX)
)

--IDENTITY IS ON
INSERT INTO tbl_sys_product VALUES ('Miso Ramen','A delicious japanese ramen with a strong salty and umami flavour',
	'Sapporo Ichiban','Packaged Food','Ramen',15,12,16,51001,NULL)
INSERT INTO tbl_sys_product VALUES ('Shin Ramen','Spicy Korean Ramen',
	'Nongshim','Packaged Food','Ramen',16,12,16,51001,NULL)
INSERT INTO tbl_sys_product VALUES ('Maggi','A curry style ramen from India',
	'Nestle','Packaged Food','Ramen',12,10,4,51001,NULL)
INSERT INTO tbl_sys_product VALUES ('Top Ramen Curry','Classic Japanese Ramen with an Indian curry twist',
	'Nissin','Packaged Food','Ramen',10,10,4,51001,NULL)
INSERT INTO tbl_sys_product VALUES ('Cup Noodles','The instant noodle cult classic from Japan',
	'Nissin','Packaged Food','Ramen',5,8,5,51001,NULL)

INSERT INTO tbl_sys_product VALUES ('Grape Sake Cocktail','A refreshing falvoured sake drink',
	'Suntory','Wine & Alcohol','Cocktail (Alc)',4,8,4,51002,NULL)
INSERT INTO tbl_sys_product VALUES ('Tuck Soda Cocktail (Bottle)','A refreshing falvoured soju drink',
	'Hite Jinro','Wine & Alcohol','Cocktail (Alc)',4,12,4,51002,NULL)

select * from tbl_sys_product (nolock) for JSON PATH

--Planogram
CREATE TABLE tbl_sys_planogram (
	ID INT PRIMARY KEY NOT NULL IDENTITY(51001,1),
	Name NVARCHAR(200),
	MerchandisingGroupCode NVARCHAR(50),
	MerchandisingGroupName NVARCHAR(200),
	Equipment NVARCHAR(200),
	Height NUMERIC(10,2),
	Width NUMERIC(10,2),
	Depth NUMERIC(10,2),
	Status NVARCHAR(50),
	GoLiveDate DATETIME,
	ParentFloorplanID INT,
	PlanogramImageURL NVARCHAR(MAX)
)

INSERT INTO tbl_sys_planogram VALUES ('Hyper Ramen R1A F01','R1A','Ramen Packaged Food','F01',600,400,60,'Live','2020-05-07 00:00:00',91001,NULL)
INSERT INTO tbl_sys_planogram VALUES ('Wine & Alcohol C1A G01','C1A','Coctails (Alc)','G01',1200,600,40,'Pending','2020-05-11 00:00:00',91001,NULL)

select * from tbl_sys_planogram (nolock) for JSON PATH

--Floorplan
CREATE TABLE tbl_sys_floorplan (
	ID INT PRIMARY KEY NOT NULL IDENTITY(91001,1),
	Name NVARCHAR(200),
	StoreID INT,
	StoreName NVARCHAR(200),
	StoreFormat NVARCHAR(200),
	Height NUMERIC(10,2),
	Width NUMERIC(10,2),
	Depth NUMERIC(10,2),
	Status NVARCHAR(50),
	GoLiveDate DATETIME,
	FloorplanImageURL NVARCHAR(MAX)
)

INSERT INTO tbl_sys_floorplan VALUES ('Hyper Times Square NYC 1',1,'Times Square NYC','Hyper',14000,12000,10000,'Live','2019-01-15 00:00:00',NULL)

select * from tbl_sys_floorplan (nolock) FOR JSON PATH


select * 
from tbl_sys_product prod (nolock)
INNER JOIN tbl_sys_planogram pog (nolock)
ON prod.ParentPlanogramID = pog.ID
INNER JOIN tbl_sys_floorplan fp (nolock)
ON pog.ParentFloorplanID = fp.ID

--Manual Upload Table
CREATE TABLE tbl_usr_ProductsSKUItemStore (
ProductID INT, --FOREIGN KEY REFERENCES tbl_sys_product(ID)
StoreID INT,
GoLiveDate DATETIME,
EndDate DATETIME,
Capacity INT,
)

INSERT INTO tbl_usr_ProductsSKUItemStore VALUES (10001,1,'2020-05-07 00:00:00','2020-12-31 00:00:00',40)

select * from tbl_usr_ProductsSKUItemStore (nolock) FOR JSON PATH