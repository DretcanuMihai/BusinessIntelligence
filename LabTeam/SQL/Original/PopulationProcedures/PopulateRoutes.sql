use BusRidesManager
go

create or alter procedure PopulateRoutes @Number int
as
begin
	DECLARE @cnt INT = 0;
	WHILE @cnt < @Number
	BEGIN
		insert into Routes(Name) values(str(@cnt+1));
		SET @cnt = @cnt + 1;
	END;
	select 'Routes Populated';
end