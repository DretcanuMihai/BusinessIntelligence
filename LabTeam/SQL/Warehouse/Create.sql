use master
go

drop database if exists BusRidesWarehouse
go

create database BusRidesWarehouse
go

use BusRidesWarehouse
go

create table DimStation(
	Id int primary key identity,
	EntityId int NOT NULL,
	Name varchar(50) NOT NULL,
	TicketAvailability varchar(50) NOT NULL,
	StreetId int NOT NULL,
	StreetName varchar(50) NOT NULL,
	StreetNumber int NOT NULL,
	NumberOfRoutes int NOT NULL,
	StartDate datetime NOT NULL,
	EndDate datetime
);

create table DimPerson(
	Id int primary key,
	FullName varchar(101) NOT NULL,
	Gender varchar(50) NOT NULL,
	DateOfBirth date NOT NULL,
	ResidenceStreetId int NOT NULL,
	ResidenceStreetName varchar(50) NOT NULL,
	ResidenceStreetNumber int NOT NULL
);

create table DimBus(
	Id int primary key,
	ManufacturingYear int NOT NULL,
	RouteId int NOT NULL,
	RouteName varchar(50) NOT NULL,
	NumberOfStations int NOT NULL,
	DriverId int NOT NULL,
	DriverFullName varchar(101) NOT NULL,
	DriverGender varchar(50) NOT NULL,
	DriverDateOfBirth date NOT NULL
);

create table DimPaymentMethod(
	Id int primary key,
	Description varchar(50) NOT NULL, ---Card, NFC, Ticket, SMS, Abonament---
	PaymentTime varchar(50) NOT NULL --- "Before Embark", "After Embark", "Free"
);

create table DimDate
(
    [Id] int primary key, 
    [Date] DATETIME,
    [FullDate] CHAR(10),-- Date in MM-dd-yyyy format
    [DayOfMonth] VARCHAR(2), -- Field will hold day number of Month
    [DaySuffix] VARCHAR(4), -- Apply suffix as 1st, 2nd ,3rd etc
    [DayName] VARCHAR(9), -- Contains name of the day, Sunday, Monday 
    [DayOfWeek] CHAR(1),-- First Day Sunday=1 and Saturday=7
    [DayOfWeekInMonth] VARCHAR(2), --1st Monday or 2nd Monday in Month
    [DayOfWeekInYear] VARCHAR(2),
    [DayOfQuarter] VARCHAR(3), 
    [DayOfYear] VARCHAR(3),
    [WeekOfMonth] VARCHAR(1),-- Week Number of Month 
    [WeekOfQuarter] VARCHAR(2), --Week Number of the Quarter
    [WeekOfYear] VARCHAR(2),--Week Number of the Year
    [Month] VARCHAR(2), --Number of the Month 1 to 12
    [MonthName] VARCHAR(9),--January, February etc
    [MonthOfQuarter] VARCHAR(2),-- Month Number belongs to Quarter
    [Quarter] CHAR(1),
    [QuarterName] VARCHAR(9),--First,Second..
    [Year] CHAR(4),-- Year value of Date stored in Row
    [YearName] CHAR(7), --CY 2012,CY 2013
    [MonthYear] CHAR(10), --Jan-2013,Feb-2013
    [MMYYYY] CHAR(6),
    [FirstDayOfMonth] DATE,
    [LastDayOfMonth] DATE,
    [FirstDayOfQuarter] DATE,
    [LastDayOfQuarter] DATE,
    [FirstDayOfYear] DATE,
    [LastDayOfYear] DATE,
    [IsWeekday] BIT -- 0=Week End ,1=Week Day
);

create table FactRides(
	Id int primary key,
	DateId int foreign key references DimDate(Id) NOT NULL,
	StartTime time NOT NULL,
	EndTime time NOT NULL,
	Duration int NOT NULL,
	PersonId int foreign key references DimPerson(Id) NOT NULL ,
	BusId int foreign key references DimBus(Id) NOT NULL,
	StartStationId int foreign key references DimStation(Id) NOT NULL,
	EndStationId int foreign key references DimStation(Id) NOT NULL,
	NumberOfStations int NOT NULL,
	PaymentValue int NOT NULL,
	PaymentMethodId int foreign key references DimPaymentMethod(Id) NOT NULL
);

go
create or alter procedure EmptyTables
as
begin
	delete from FactRides;
	delete from DimStation;
	delete from DimPerson;
	delete from DimBus;
	delete from DimPaymentMethod;
end