use BusRidesManager
go

create or alter procedure EmptyTables
as
begin
	delete from Payments;
	delete from PaymentMethods;
	delete from Rides;
	delete from Buses;
	delete from Persons;
	delete from RouteStations;
	delete from Routes;
	delete from Stations;
	delete from Streets;
	select 'Tables Emptied';
end