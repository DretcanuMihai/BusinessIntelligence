drop database PoliticalWorld
go

create database PoliticalWorld
go

use PoliticalWorld
go

create table Organizations(
	Code int primary key identity,
	Name varchar(50) NOT NULL,
	Headquarter varchar(50) NOT NULL,
	FoundedDate date NOT NULL
);

create table Countries(
	Code int primary key identity,
	Name varchar(50) NOT NULL,
	Capital varchar(50) NOT NULL,
	Area float,
	Population int,
	Continent varchar(50)
);

create table CountryOrganizationMembership(
	CountryCode int foreign key references Countries(Code),
	OrganizationCode int foreign key references Organizations(Code),
	CONSTRAINT pk_CountryOrganizationMembership primary key(CountryCode,OrganizationCode)
);