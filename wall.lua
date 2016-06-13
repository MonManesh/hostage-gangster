-----------------------------------------------------------------------------------------
--
-- wall.lua
--
-----------------------------------------------------------------------------------------
module(..., package.seeall)
local physics = require "physics"	
local gang = require "gangester"
local  host = require "hostage"

	function new (self ,obj)
       obj = obj or {}   -- create table if user does not provide one
       setmetatable(obj, self)
       self.__index = self
       obj.wallStatus = 0   -- status which shows characters existense on wall 
                      -- 0 no character is on the wall 
                       --  1 for only gangester 
                       --  2 for only hostage 
                       -- 3 for gangester and hostage are both on the wall 

       obj.view = display.newImageRect('wall.jpg',constants.wallWidth,constants.wallHeight) 
       obj.view.anchorX = 0
       obj.view.anchorY = 1
       obj.name = '' 
       physics.addBody(obj.view, "static", {density=.1, bounce=0.1, friction=.2})
        obj.group = display.newGroup() 
        obj.group :insert(obj.view)
        x = math.random(  1, 20 )
        print ("the random number in wall timer was "..x)
        obj.genTimer = timer.performWithDelay( constants.randomCharacterGeneratorTime + (200*x) ,function() obj:randomTrans() end, 22 )
        

       return obj
end
function getWallName( self )
return self.name
  
end
function setWallName ( self ,name)
  self.name = name 
end

function getWallHeight( self) -- this will be used for characters transition 
      return self.view.height
    
end  
function getWallWidth( self)
      return self.view.width
end

function setX(self, xPosition )

	wall.x = xPosition
	self.view.x = xPosition
end

function setY(self, yPosition )
	self.view.y = yPosition
end
function getX( self)

	return self.view.x
end
function getY( self )
	return self.view.y
end
function setWallFront (self )
              
              self.view:toFront()
        end
function setWallStatus( self , status )
  self.wallStatus = status
end
function getWallStatus( self )
   return self.wallStatus
end

function addGangster(self)
  print ("create gangester!!!!!!!!!!!!")  
  local randomX1 = math.random (self:getX(),self:getX() + self:getWallWidth() - constants.gangesterWidth)  
  local gangster1  = gangester : new(self) 
  gangster1:setX (randomX1)
  gangster1:setY(self:getY() - self:getWallHeight())
  self :setWallFront()
  
  self.group:insert(gangster1.view)
  

    gangster1:characterTransitionUp ( self )
    self:setWallStatus (1)
    print ("**WALL STATUS*** the status of "..self:getWallName().."is :"..self:getWallStatus())

    end

 
function addHostage(self)
    print ("create hostage!!!!!!!!!!!!")  
   local randomX1 = math.random (self:getX(),self:getX() + self:getWallWidth() - constants.hostageWidth) 
  local hostage2  = hostage : new (self) 
  hostage2:setX (randomX1)
  hostage2:setY(self:getY() - self:getWallHeight())
  self :setWallFront()
  
  
  hostage2:characterTransitionUp (self)
  self.group:insert(hostage2.view)

  self:setWallStatus (2)
   print ("**WALL STATUS*** the status of "..self:getWallName().."is :"..self:getWallStatus())
  
  
end

local function addHostageAndGanGester( self )
  print ("hostage ang gang created")

  local randomX1 = math.random (self:getX(),(self:getX() + self:getWallWidth()- (constants.hostageWidth + constants.gangesterWidth ) ))
  --  print ("x="..wall:getX())
  --  print ("m="..(wall:getX() + wall:getWallWidth()- (constants.hostageWidth + constants.gangesterWidth ) ))
  local gangster2  = gangester : new (self)
   
  gangster2:setX (randomX1)
  gangster2:setY(self:getY() - self:getWallHeight()) 

  local hostage1  = hostage : new (self) 
  hostage1:setX (randomX1+constants.gangesterWidth - constants.distanceBetweenHostageAndGangester)
  hostage1:setY(self:getY() - self:getWallHeight())

  self :setWallFront()

  gangster2:characterTransitionUp (self)
  hostage1:characterTransitionUp (self)
  self:setWallStatus (3)  
  print ("**WALL STATUS*** the status of "..self:getWallName().."is :"..self:getWallStatus())
  self.group:insert(gangster2.view)
  self.group:insert(hostage1.view)
  


end 

 function randomTrans( self )
transitions =  {1,2,3}
table.insert( transitions, 1 , function() addGangster(self) end )
table.insert( transitions, 2 , function() addHostage(self) end )
table.insert( transitions, 3 , function() addHostageAndGanGester(self) end )
randomT = math.random (1,3) 



if (randomT == 1 )  then
  transitions[1]()
    elseif (randomT == 2) then
  transitions[2]()
  elseif (randomT == 3) then
  transitions[3]()
  
end

end
function cancelTransitionTimer( event )
  for i=1,#walls do
    timer.cancel(walls[i].genTimer)
 print(" ############################generation canceled#########################")
  end
 
   
 end

Runtime:addEventListener("gameEnded", cancelTransitionTimer )

 



