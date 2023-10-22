use master
go

drop database if exists BusRidesManager
go

create database BusRidesManager
go

use BusRidesManager
go

create table Streets(
	Id int primary key identity,

	Name varchar(50) NOT NULL,
	Number int NOT NULL
);

create table Stations(
	Id int primary key identity,

	Name varchar(50) NOT NULL,
	CanBuyTickets int NOT NULL, ---is 1 if you can buy tickets from there, 0 otherwise

	StreetId int foreign key references Streets(Id) NOT NULL
);

create table Routes(
	Id int primary key identity,

	Name varchar(50) NOT NULL
);

create table RouteStations(
	RouteId int foreign key references Routes(Id) NOT NULL,
	StationId int foreign key references Stations(Id) NOT NULL,
	constraint pk_RouteStation primary key(RouteId,StationId),

	StationOrderNumberInRoute int NOT NULL
);

create table Persons(
	Id int primary key identity,

	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Gender int NOT NULL, --- 0 means male, 1 female
	DateOfBirth date NOT NULL,

	ResidenceStreetId int foreign key references Streets(Id) NOT NULL
);

create table Buses(
	Id int primary key identity,

	ManufacturingYear int NOT NULL,

	RouteId int foreign key references Routes(Id) NOT NULL,
	DriverId int foreign key references Persons(Id) NOT NULL
);

create table Rides(
	Id int primary key identity,

	Date date NOT NULL,
	StartTime time NOT NULL,
	EndTime time NOT NULL,

	PersonId int foreign key references Persons(Id) NOT NULL,
	BusId int foreign key references Buses(Id) NOT NULL,
	StartStationId int foreign key references Stations(Id) NOT NULL,
	EndStationId int foreign key references Stations(Id) NOT NULL
);

create table PaymentMethods(
	Id int primary key identity,

	Description varchar(50) NOT NULL, ---Card, NFC, Ticket, SMS, Membership, Free---
	PreEmbark int NOT NULL ---2 means it's a free ride, 1 means must be paid before embarking, 0 after embarking ---
);

create table Payments(
	Id int primary key,
	constraint fk_Rides foreign key(Id) references Rides(Id),

	Value int NOT NULL, --- Memberships have 0 value ---

	MethodId int foreign key references PaymentMethods(Id) NOT NULL
);