use PoliticalWorld
go

select * from Countries;
select * from Organizations;
select * from CountryOrganizationMembership;

----1
select * from Countries C
	where exists(select * from CountryOrganizationMembership COM
					inner join Organizations O
					on O.Code=COM.OrganizationCode and COM.CountryCode=C.Code
					where O.Name='NATO'
				)

----2
select * from Countries C
	where exists(select * from CountryOrganizationMembership COM
					inner join Organizations O
					on O.Code=COM.OrganizationCode and COM.CountryCode=C.Code
					where year(O.FoundedDate)<1980
				)

----3
select * from Countries C
	where exists(select * from CountryOrganizationMembership COM
					inner join Organizations O
					on O.Code=COM.OrganizationCode and COM.CountryCode=C.Code
					group by COM.CountryCode
					having count(*)=1
				)
----4
select C.Capital from Countries C
	where not exists(select * from Organizations O
						where O.Headquarter=C.Capital
					)

----5
select C.Continent, sum(C.Population) as ContinentPopulation from Countries C
	group by C.Continent

----6
select C.Continent, count(*) as NumberOfCountries from Countries C
	group by C.Continent