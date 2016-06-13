--------------------------------------------
-- constants 
--------------------------------------------
module(..., package.seeall)
--------------------------------------------
------
-- wall attributes 
------
--------------------------------------------

wallWidth = 420 
wallHeight = 200
wall1x = 100
wall1y = 1200
DistanseBetweenWalls = 70
wall2x = wall1x + wallWidth + DistanseBetweenWalls
wall2y = wall1y
--------------------------------------------
gangesterWidth = 200
gangesterHeight = 100
hostageWidth = 200
hostageHeight = 100
distanceBetweenHostageAndGangester = 35

--------------------------------------------
------
--- transition time 
------
--------------------------------------------

gangesterWasNotShootedDelay = 1300
HostageTransitionDownTime = 600
hostageTransitionDelay = 600
gangesterTransitionDelay = hostageTransitionDelay + HostageTransitionDownTime + 300
randomCharacterGeneratorTime = 3000  

gangTransitionDownDur = 200 
gangTransitionUpDur = 400 
hostTransitionDownDur= 400
hostTransitionUpDur = 400 
gangesterIsKillingUDur = 600