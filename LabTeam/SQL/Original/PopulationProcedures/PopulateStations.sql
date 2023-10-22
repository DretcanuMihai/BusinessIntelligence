use BusRidesManager
go

create or alter procedure PopulateStations @Number int
as
begin
	DECLARE @Nouns table (id int identity, name varchar(20))
	insert into @Nouns values
	('Toporul'),
	('Zambetul'),
	('Fericitul'),
	('Pietrisul'),
	('Cainele'),
	('Clubul'),
	('Copacul'),
	('Arborele'),
	('Hotul'),
	('Omul'),
	('Ardeleanul'),
	('Romanasul'),
	('Fecioru'),
	('Targul'),
	('Calugarul'),
	('Dansatorul');
	declare @NrNouns INT;
	select @NrNouns=count(*) from @Nouns;
	DECLARE @Adjectives table (id int identity, name varchar(20))
	insert into @Adjectives values
	('Vesel'),
	('Trist'),
	('Obosit'),
	('Zambitor'),
	('Bocitor'),
	('Speriat'),
	('Racit'),
	('Violent'),
	('Slab'),
	('Mare'),
	('Mic'),
	('Voinic');
	declare @NrAdjectives INT;
	select @NrAdjectives=count(*) from @Adjectives;

	declare @NrStreetsA int;
	select @NrStreetsA=min(id) from Streets;
	declare @NrStreetsB int;
	select @NrStreetsB=max(id) from Streets;

	DECLARE @cnt INT = 0;
	WHILE @cnt < @Number
	BEGIN
		declare @Name as varchar(50);
		select @Name=n.name+' '+adj.name from @Nouns n, @Adjectives adj where n.id=FLOOR(RAND()*@NrNouns+1) and adj.id=FLOOR(RAND()*@NrAdjectives+1);
		insert into Stations(Name,CanBuyTickets,StreetId) values(@Name,FLOOR(RAND()*2),FLOOR(RAND()*(@NrStreetsB-@NrStreetsA+1)+@NrStreetsA));
		SET @cnt = @cnt + 1;
	END;
	select 'Stations Populated';
end