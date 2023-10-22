use BusRidesManager
go

exec EmptyTables;

exec PopulateStreets @Number=100;              --1
exec PopulateStations @Number=40;              --2
exec PopulateRoutes @Number=20;                --3
exec PopulateRouteStations @Number=500;        --4
exec PopulatePersons @Number=4000;             --5
exec PopulateBuses @Number=100;                --6
exec PopulateRides @Number=40000;              --7
exec PopulatePaymentMethods;                   --8
exec PopulatePayments;                         --9