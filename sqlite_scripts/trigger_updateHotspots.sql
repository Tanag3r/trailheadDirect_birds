create trigger if not exists hotspotUpdate
after INSERT on Hotspots_cooking
BEGIN

update Hotspots
set 
	latestObsDt = (select Hotspots_cooking.latestObsDt
		from Hotspots_cooking
		where Hotspots.StopName=Hotspots_cooking.StopName
		and Hotspots.locId=Hotspots_cooking.locId
		and Hotspots_cooking.latestObsDt > Hotspots.latestObsDt),
	numSpeciesAllTime = (select Hotspots_cooking.numSpeciesAllTime
		from Hotspots_cooking
		where Hotspots.StopName=Hotspots_cooking.StopName
		and Hotspots.locId=Hotspots_cooking.locId
		and Hotspots_cooking.latestObsDt > Hotspots.latestObsDt),
	latestUpdate = (select Hotspots_cooking.latestUpdate
		from Hotspots_cooking
		where Hotspots.StopName=Hotspots_cooking.StopName
		and Hotspots.locId=Hotspots_cooking.locId
		and Hotspots_cooking.latestObsDt > Hotspots.latestObsDt)
where
	exists(
		select * from Hotspots_cooking
		WHERE
			Hotspots.StopName=Hotspots_cooking.StopName
			and Hotspots.locId=Hotspots_cooking.locId
			)
;
DELETE FROM Hotspots_cooking;
END;