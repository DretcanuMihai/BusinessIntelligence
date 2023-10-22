use BusRidesManager
go

create or alter procedure PopulatePersons @Number int
as
begin
	DECLARE @FN table (id int identity, name varchar(20))
	insert into @FN values
	('Geo'),
	('Danny'),
	('Sasha'),
	('Karmen'),
	('Donnie'),
	('Joe'),
	('Levy'),
	('Letus');
	declare @NrFN INT;
	select @NrFN=count(*) from @FN;

	DECLARE @LN table (id int identity, name varchar(20))
	insert into @LN values
	('Padurariu'),
	('Marinariu'),
	('Dina'),
	('Deiu'),
	('Teiu'),
	('Aciobanilor'),
	('Danescu'),
	('Coriandrescu'),
	('Ramsay'),
	('Popovici'),
	('Cretu'),
	('Voinicu');
	declare @NrLN INT;
	select @NrLN=count(*) from @LN;

	declare @nrDays int=40*365;

	declare @NrStreetsA int;
	select @NrStreetsA=min(id) from Streets;
	declare @NrStreetsB int;
	select @NrStreetsB=max(id) from Streets;

	DECLARE @cnt INT = 0;
	WHILE @cnt < @Number
	BEGIN
		declare @FirstName as varchar(50);
		select @FirstName=Name from @FN where id=FLOOR(RAND()*@NrFN+1);
		declare @LastName as varchar(50);
		select @LastName=Name from @LN where id=FLOOR(RAND()*@NrLN+1);
		declare @dateValue date;
		select @dateValue=t.mdate from
			(SELECT DATEADD(DAY,value,'1970-01-01') as mdate, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS number
			FROM GENERATE_SERIES(0,@nrDays,1)
			)as t where t.number=floor(rand()*(@nrDays+1)+1);
		insert into Persons(FirstName,LastName,Gender,DateOfBirth,ResidenceStreetId) values(@FirstName,@LastName,FLOOR(RAND()*2),@dateValue,FLOOR(RAND()*(@NrStreetsB-@NrStreetsA+1)+@NrStreetsA));
		SET @cnt = @cnt + 1;
	END;
	select 'Persons Populated';
end