use BusRidesManager
go

create or alter procedure PopulateRouteStations @Number int
as
begin
	declare @NrRouteA int;
	select @NrRouteA=min(id) from Routes;
	declare @NrRouteB int;
	select @NrRouteB=max(id) from Routes;

	declare @NrStationA int;
	select @NrStationA=min(id) from Stations;
	declare @NrStationB int;
	select @NrStationB=max(id) from Stations;

	DECLARE @cnt INT = 0;
	WHILE @cnt < @Number
	BEGIN
		begin try
			declare @RouteId int=FLOOR(RAND()*(@NrRouteB-@NrRouteA+1)+@NrRouteA);
			declare @StationId int=FLOOR(RAND()*(@NrStationB-@NrStationA+1)+@NrStationA);
			declare @StationOrderNumberInRoute int;
			select @StationOrderNumberInRoute=count(*)+1 from RouteStations where RouteId=@RouteId;
			insert into RouteStations(RouteId,StationId,StationOrderNumberInRoute) values(@RouteId ,@StationId,@StationOrderNumberInRoute);
			SET @cnt = @cnt + 1;
		end try
		begin catch
			---ERROR---
		end catch
	END;
	select 'RouteStations Populated';
end