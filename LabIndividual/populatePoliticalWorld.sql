use PoliticalWorld
go


insert into Countries (Name,Capital,Area,Population,Continent) values
('Romania','Bucharest',2000.0,20,'Europe'),
('US','Washington',300.0,30,'North America'),
('Mexic','Mexico City',77.0,300,'North America'),
('France','Paris',20.0,200,'Europe'),
('Japan','Tokyo',2.0,20,'Asia')

insert into Organizations (Name,Headquarter,FoundedDate) values
('NATO','Paris','19990210'),
('ONU','Berlin','19700312')

insert into CountryOrganizationMembership (CountryCode,OrganizationCode) values
(1,1),
(2,1),
(2,2)
