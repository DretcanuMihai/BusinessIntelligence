use BusRidesWarehouse
go

select * from DimStation;
select * from DimPerson;
select * from DimBus;
select * from DimPaymentMethod;
select * from DimDate;
select * from FactRides;

---select * from DimStation where EntityId=1;
---select * from FactRides where StartStationId=8;
---select * from FactRides where StartStationId=41 and Id=40001;