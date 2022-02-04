# trailheadDirect_birds
Leveraging Cornell's eBirds data to provide rich bird and sighting info at TrailheadDirect.org stops.

mytrash_opossum.jpg

Science-ish questions we will attempt to answer:
- On each week of the year, what habitat type (FAO land cover classification) does each species of bird prefer?
- Is there a relationship between annual temperature changes coming out of winter, the change in foliage coverage during the same period, the increased amount of sunlight (longer days) and the 're-appearance' of birds that spend significant time in the regions covered by the study?
- Out of the four trends given above (temperature, foliage, sunlight and migration) is there a <i>stronger</i> relationship between any of the two?

Structure and function:
- Sous: data factories that fetch raw data and prepare it for cooking by Kitchen services
- Cooking: file library that is produced and maintained by back-of-house services in 'Cooking'
- Kitchen: analysis of ingredients produced by services in Sous. produces Cooked information/files/etc.
- Cooked: file library ready for consumption by front-of-house services. Fed and maintained by Kitchen services
- Service: Django delivery of ready-to-eat data for users of the TrailheadDirect.org service
