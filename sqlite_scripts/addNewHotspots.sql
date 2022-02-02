--Append new trailhead hotspots from cooking to prod
create trigger if not exists pushNewHotspots
after update on Hotspots_cooking
BEGIN
INSERT INTO Hotspots SELECT * FROM Hotspots_cooking
ON CONFLICT(StopName,locId) DO NOTHING
;
END;