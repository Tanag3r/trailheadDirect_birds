# trailheadDirect_birds
Leveraging Cornell's eBird service, USGS and NASA habitat data (MODIS) and nesting observations from the Seattle Audabon to deliver rich, dynamic insights about birds at King County Metro TrailheadDirect.org stops.

mytrash_opossum.jpg

Science-ish questions we will attempt to answer:
- For birds that switch habitats and strongly select single habitats, can trends in habitat selection ratios be explained by photosynthetic radiation (fPar), the Leaf Area Index and the annual relative abundance?
- Can neural networks help us understand the resiliency of common birds? For birds that can be found year-round in the study region, can neural networks like LSTM accurately model responses to food scarcity events?
- Is there a relationship between annual temperature changes coming out of winter, the change in foliage coverage during the same period, the increased amount of sunlight (longer days) and the 're-appearance' of birds that spend significant time in the regions covered by the study?
- Out of the four trends given above (temperature, foliage, sunlight and migration) is there a <i>stronger</i> relationship between any of the two?

Structure and function:
- Sous: data factories that fetch raw data and prepare it for cooking by Kitchen services
- Cooking: sql blocks and notebooks that deliver features
- TestKitchen: analysis notebooks and feature factories that are not ready for serving
- Analysis: cooked notebooks containing models and test results
- Service: Django delivery of ready-to-eat data for users of the TrailheadDirect.org service
