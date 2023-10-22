use BusRidesManager
go

create or alter procedure PopulatePayments
as
begin
	declare @RidesMin int;
	select @RidesMin=min(id) from Rides;
	declare @Number int;
	select @Number=count(*) from Rides;

	declare @PayMin int=1;
	declare @PayMax int=5;

	declare @NrMethodsA int;
	select @NrMethodsA=min(id) from PaymentMethods;
	declare @NrMethodsB int;
	select @NrMethodsB=max(id) from PaymentMethods;

	DECLARE @cnt INT = 0;
	WHILE @cnt < @Number
	BEGIN
		declare @Method int=FLOOR(RAND()*(@NrMethodsB-@NrMethodsA+1)+@NrMethodsA);
		declare @Value int=0;
		if @Method<@NrMethodsB-1
			set @Value=FLOOR(RAND()*(@PayMax-@PayMin+1)+@PayMin);
		insert into Payments(Id,Value,MethodId) values(@RidesMin+@cnt,@Value,@Method);
		SET @cnt = @cnt + 1;
	END;
	select 'Payments Populated';
end