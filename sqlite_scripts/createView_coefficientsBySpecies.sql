--DROP VIEW "main"."coefficients_bySpecies";
--CREATE VIEW 'coefficients_bySpecies' AS
select
	comName,
	locId,
	count(subId) as 'uniqueSightings',
	round(avg(howMany),2) as 'averageVolume',
	strftime('%Y',obsDt) as 'year',
	--(SELECT COUNT(DISTINCT(strftime('%Y',obsDt))) FROM historicObservations as hz WHERE hz.comName=HsOb.comName and hz.locId=HsOb.locId) as 'YEARfrequency',
	(SELECT COUNT(DISTINCT(strftime('%W',obsDt))) FROM historicObservations as hz WHERE hz.comName=HsOb.comName and hz.locId=HsOb.locId) as 'WEEKfrequency'

from historicObservations as HsOb

group by comName,locId,strftime('%Y',obsDt)
;