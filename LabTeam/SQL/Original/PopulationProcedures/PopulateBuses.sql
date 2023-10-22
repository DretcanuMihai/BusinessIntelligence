use BusRidesManager
go

create or alter procedure PopulateBuses @Number int
as
begin
	declare @NrRouteA int;
	select @NrRouteA=min(id) from Routes;
	declare @NrRouteB int;
	select @NrRouteB=max(id) from Routes;

	declare @NrPersonA int;
	select @NrPersonA=min(id) from Persons;
	declare @NrPersonB int;
	select @NrPersonB=max(id) from Persons;

	DECLARE @cnt INT = 0;
	WHILE @cnt < @Number
	BEGIN
		declare @RouteId int=FLOOR(RAND()*(@NrRouteB-@NrRouteA+1)+@NrRouteA);
		declare @DriverId int=FLOOR(RAND()*(@NrPersonB-@NrPersonA+1)+@NrPersonA);
		insert into Buses(ManufacturingYear,RouteId,DriverId) values(FLOOR(RAND()*(2020-1970+1)+1970),@RouteId ,@DriverId);
		SET @cnt = @cnt + 1;
	END;
	select 'Buses Populated';
end