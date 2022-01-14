# trailheadDirect_birds
Leveraging Cornell's eBirds data to provide rich bird and sighting info at TrailheadDirect.org stops.

Structure and function:
- Sous: data factories that fetch raw data and prepare it for cooking by Kitchen services
- Cooking: file library that is produced and maintained by back-of-house services in 'Cooking'
- Kitchen: analysis of ingredients produced by services in Sous. produces Cooked information/files/etc.
- Cooked: file library ready for consumption by front-of-house services. Fed and maintained by Kitchen services
- Service: Django delivery of ready-to-eat data for users of the TrailheadDirect.org service
