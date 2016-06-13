-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local mydata = require( "mydata" )
local wall = require ("wall")
local gangesters = require ("gangester")
local hostages = require ("hostage")
-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()
mydata.score = 0
--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

function scene:create( event )
	physics.start()

	local sceneGroup = self.view
	physics.setDrawMode( "hybrid")

	
	local background = display.newRect( 0, 0, screenW, screenH )
	background.anchorX = 0
	background.anchorY = 0
	background:setFillColor( .5 )
	
	
	local grass = display.newImageRect( "grass.png", screenW, 82 )
	grass.anchorX = 0
	grass.anchorY = 1
	grass.x, grass.y = 0, display.contentHeight
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local grassShape = { -halfW,-34, halfW,-34, halfW,34, -halfW,34 }
	physics.addBody( grass, "static", { friction=0.3, shape=grassShape } )

-----------------------------------------------------------------------------------------------------------

-- 			specifying display objects including walls and characters in the scene 

------------------------------------------------------------------------------------------------------------
	_G.walls = {}
	wall1 = wall:new ()
	wall1:setX(constants.wall1x)
	wall1:setY(constants.wall1y)
	wall1:setWallFront()
	wall1:setWallName("wall1")

	wall2 = wall : new ()
	wall2:setX (constants.wall2x)
	wall2:setY(constants.wall2y)
	wall2:setWallFront()
	wall2:setWallName ("wall2")
	sceneGroup:insert( background )
	sceneGroup:insert( grass)
	sceneGroup:insert(wall1.group)
	sceneGroup:insert(wall2.group)
	walls[#walls + 1] = wall1
	walls[#walls + 1] = wall2


	scoreText = display.newText(mydata.score,display.contentCenterX,
	150, "pixelmix", 65,"left") 	
	scoreText:setFillColor(1,1,1)  
	scoreText.alpha = 1
	sceneGroup:insert(scoreText)
-- all display objects must be inserted into group
	

-- this event is dispatched from gangester
	Runtime:addEventListener("gangesterWasNotShooted", function (event)

	 														event.gangester:characterTransitionDown(event.thisWall);
	 														--gameOver();
	 														if (event.thisWall:getWallStatus()==1) 
	 															then
	 															timer.performWithDelay (constants.gangTransitionDownDur + constants.gangesterTransitionDelay ,
	 															 function ( ) event.thisWall:setWallStatus(0)
	 														end )
	 															 print("!!@@@@@ !!! gangester killed u  !!") 
	 														     print ("**WALL STATUS*** the status of "..event.thisWall:getWallName().." is :"..event.thisWall:getWallStatus())
	 														         

	 															 end
	 															 
	 						 
	 													end )
                                                                  

	Runtime:addEventListener("hostageWasNotShooted", function (event)
	 														event.hostage:characterTransitionDown(event.thisWall);
	 														 if (event.thisWall:getWallStatus()==2) then
	 														 	timer.performWithDelay (constants.hostageTransitionDelay + constants.hostTransitionDownDur, function () event.thisWall:setWallStatus(0); end)
	 														 
	 														 elseif (event.thisWall:getWallStatus()==3) then
	 														 	timer.performWithDelay (constants.hostageTransitionDelay + constants.hostTransitionDownDur, function () event.thisWall:setWallStatus(1); end)
	 														 	 end 
	 														  print("!!hostage  transition down !!") 
	 														  print ("**WALL STATUS*** the status of "..event.thisWall:getWallName().." is :"..event.thisWall:getWallStatus())
	 													end )

	Runtime:addEventListener("hostageShooted" , didShootHostage) -- dispatched from hostage 
	Runtime:addEventListener("gangesterShooted" ,  didShootGangerster ) -- dispatched from gangester
	
	
	
end


function didShootGangerster( event  )
	print("wall status is !!!!!!"..event.thisWall:getWallStatus())
	if( event.thisWall:getWallStatus()==1) then 
		print("increase score ") 
		mydata.score = mydata.score +1 
		scoreText.text = mydata.score
		print(mydata.score)
		elseif (event.thisWall:getWallStatus()==3)then 
			print("gameOver ") 
			gameOver();
			event.thisWall:setWallStatus(0)
	end 
end
function didShootHostage( event  )
	 print ("**WALL STATUS*** the status of "..event.thisWall:getWallName().." is :"..event.thisWall:getWallStatus())
	
	print("game over") 
	gameOver();

end


function scene:show( event )
 local sceneGroup = self.view
 local phase = event.phase
	
if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
elseif phase == "did" then

 





function gameOver(  )
	-- this function will change the game scene to restart
		Runtime:dispatchEvent( { name = "gameEnded" }) -- this will be listend in wall
		composer.gotoScene( "restart", "fade", 500 )
		
	
end

		
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	

	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then

		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

