--DROP VIEW "main"."coefficients_bySpecies";
--CREATE VIEW 'coefficients_bySpecies' AS
select
	comName,
	HsOb.locId as 'locId',
	closestStop.StopName as 'closestStop',
	count(subId) as 'uniqueSightings',
	round(avg(howMany),2) as 'averageVolume',
	strftime('%Y',obsDt) as 'year',
	--(SELECT COUNT(DISTINCT(strftime('%Y',obsDt))) FROM historicObservations as hz WHERE hz.comName=HsOb.comName and hz.locId=HsOb.locId) as 'YEARfrequency',
	(SELECT COUNT(DISTINCT(strftime('%W',obsDt))) FROM historicObservations as hz WHERE hz.comName=HsOb.comName and hz.locId=HsOb.locId) as 'WEEKfrequency'

from historicObservations as HsOb
left join closestStop on HsOb.locId = closestStop.locId
group by comName,HsOb.locId,strftime('%Y',obsDt)
;