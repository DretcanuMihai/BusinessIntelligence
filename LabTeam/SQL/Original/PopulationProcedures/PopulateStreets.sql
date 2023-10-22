use BusRidesManager
go

create or alter procedure PopulateStreets @Number int
as
begin
	DECLARE @Names table (id int identity, name varchar(20))
	insert into @Names values
	('Topoarelor'),
	('Izvoarelor'),
	('George Toparceanu'),
	('Dimitrie Pompeiu'),
	('Balcanilor'),
	('Dan Balan'),
	('Muntilor'),
	('Viilor'),
	('Mihai Viteazu'),
	('Moldoveanul'),
	('Ardeleanul'),
	('Romanasul'),
	('Fecioru'),
	('Fierului'),
	('Minerilor'),
	('Paraurilor');
	declare @NrNames INT;
	select @NrNames=count(*) from @Names;

	declare @AddressesNumberLimit INT = 100;

	DECLARE @cnt INT = 0;
	WHILE @cnt < @Number
	BEGIN
		declare @Name as varchar(50);
		select @Name=Name from @Names where id=FLOOR(RAND()*@NrNames+1);
		insert into Streets(Name,Number) values(@Name,FLOOR(RAND()*@AddressesNumberLimit+1));
		SET @cnt = @cnt + 1;
	END;
	select 'Streets Populated';
end