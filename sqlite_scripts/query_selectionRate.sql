with habitatAbundance as (
select
	obsDt,
	(strftime('%Y',obsDt)||'-'||strftime('%W',obsDt)) as "year_week",
	round(avg(howMany),0) as "volume",
	habitatLabel 
from historicObservations as hsob
left join (select locId,habitatLabel from Hotspots) as "labels" on hsob.locId=labels.locId
where speciesCode = 'westan'
group by year_week,habitatLabel)
select year_week,volume from habitatAbundance
where habitatLabel = 2
;