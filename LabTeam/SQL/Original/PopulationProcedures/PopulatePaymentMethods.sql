use BusRidesManager
go

create or alter procedure PopulatePaymentMethods
as
begin
	insert into PaymentMethods(Description,PreEmbark) values
	('Card',0),
	('NFC',0),
	('Ticket',1),
	('SMS',1),
	('Membership',0),
	('Free',2);
	select 'PaymentMethods Populated';
end