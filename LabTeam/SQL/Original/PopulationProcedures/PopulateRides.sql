use BusRidesManager
go

create or alter procedure PopulateRides @Number int
as
begin
	declare @nrDays int=2*365;

	declare @nrMinutes int=60*16;

	declare @NrPersonA int;
	select @NrPersonA=min(id) from Persons;
	declare @NrPersonB int;
	select @NrPersonB=max(id) from Persons;

	declare @NrBusA int;
	select @NrBusA=min(id) from Buses;
	declare @NrBusB int;
	select @NrBusB=max(id) from Buses;

	DECLARE @cnt INT = 0;
	WHILE @cnt < @Number
	BEGIN
		declare @DateValue date;
		select @DateValue=t.mdate from
			(SELECT DATEADD(DAY,value,'2020-01-01') as mdate, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS number
			FROM GENERATE_SERIES(0,@nrDays,1)
			)as t where t.number=floor(rand()*(@nrDays+1)+1);
		declare @StartTime time;
		select @StartTime=t.mdate from
			(SELECT DATEADD(MINUTE,value,'06:00:00') as mdate, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS number
			FROM GENERATE_SERIES(0,@nrMinutes,1)
			)as t where t.number=floor(rand()*(@nrMinutes+1)+1);
		declare @Duration int=FLOOR(RAND()*(30-3+1)+3);
		declare @EndTime time=DATEADD(MINUTE,@Duration,@StartTime);
		declare @PersonId int=FLOOR(RAND()*(@NrPersonB-@NrPersonA+1)+@NrPersonA);
		declare @BusId int=FLOOR(RAND()*(@NrBusB-@NrBusA+1)+@NrBusA);

		declare @RouteId int;
		select @RouteId=RouteId from Buses where Id=@BusId;
		declare @NrStations int;
		select @NrStations=count(*) from RouteStations where RouteId=@RouteId;
		declare @StationsStayed int=FLOOR(RAND()*(@NrStations-1)+1);
		declare @StartStationOrderNumberInRoute int=FLOOR(RAND()*@NrStations+1);
		declare @EndStationOrderNumberInRoute int=(@StartStationOrderNumberInRoute+@StationsStayed)%@NrStations;
		if @EndStationOrderNumberInRoute=0
			set @EndStationOrderNumberInRoute=@NrStations;
		declare @StartStationId int;
		select @StartStationId=StationId from RouteStations where RouteId=@RouteId and StationOrderNumberInRoute=@StartStationOrderNumberInRoute;
		declare @EndStationId int;
		select @EndStationId=StationId from RouteStations where RouteId=@RouteId and StationOrderNumberInRoute=@EndStationOrderNumberInRoute;

		insert into Rides(Date,StartTime,EndTime,PersonId,BusId,StartStationId,EndStationId) values(@DateValue,@StartTime,@EndTime,@PersonId,@BusId,@StartStationId,@EndStationId);
		SET @cnt = @cnt + 1;
	END;
	select 'Rides Populated';
end