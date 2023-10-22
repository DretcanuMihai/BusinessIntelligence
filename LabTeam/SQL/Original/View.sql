use BusRidesManager
go

select * from Streets;
select * from Stations;
select * from Routes;
select * from RouteStations;
select * from Persons;
select * from Buses;
select * from Rides;
select * from PaymentMethods;
select * from Payments;

---update Stations set CanBuyTickets=0 where Id=1;
---select * from Rides where StartStationId=1;
---insert into Rides(Date,StartTime,EndTime,PersonId,BusId,StartStationId,EndStationId) values(GETDATE(), '20:55:00','21:19:00',1,22,1,32);
---insert into Payments(Id,Value,MethodId) values(40001,3,1);