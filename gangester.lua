-----------------------------------------------------------------------------------------
--
-- gangester.lua
--
-----------------------------------------------------------------------------------------

module(..., package.seeall)



function new (self,wall, obj)
       obj = obj or {}   -- create table if user does not provide one
       setmetatable(obj, self)
       self.__index = self
       obj.view = display.newImageRect('g.png',constants.gangesterWidth,constants.gangesterHeight)
       obj.died = false
       obj.addingTimer = timer.performWithDelay( constants.gangesterWasNotShootedDelay,function() Runtime:dispatchEvent( { name = "gangesterWasNotShooted" ,  gangester =  obj , thisWall = wall}) end, 1  ) 
        

       obj.view.anchorX = 0
       obj.view.anchorY = 1 
      -- physics.addBody(obj.view, "static", {density=.1, bounce=0.1, friction=.2})  
      -- group:insert(obj.view)

      -- obj.createDate = os.time()
      
       local shootListener = function (event )
          --   print( obj.createDate )
          
            print("!!!!!! gang shooted !!!!!") 
           

            if (obj.died == false) then 

             Runtime:dispatchEvent( { name = "gangesterShooted" ,  gangester = obj , thisWall = wall})
             
             obj:gangsterShooted()
      
                   obj.died = true
            end
             
       end

        obj.view:addEventListener("tap" , shootListener )

      
      
       return obj
end

function kill( self )
      self.died = true
end
function isDead( self )
      if (self.died == true) then return true
      elseif (self.died==false) then return false end
             
      -- body
end
function setX(self, xPosition )

	self.view.x = xPosition
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
function getGangsterHeight( self) 
      return self.view.height
end  
function getWGangsterWidth( self)
      return self.view.width
end



-----------------------------------------------------------------------------------------------------------

--                   characters transitioon  

------------------------------------------------------------------------------------------------------------
function gangsterShooted( self )

      --self:kill() 
      timer.cancel(self.addingTimer ) 
       local listener2 = function ()  self.view:removeSelf() self = nil end
       --listener2()
    local gangsterDieingTransition =  transition.fadeOut( self.view, {time=400, delay=0 , onComplete = listener2 } )
end
function characterTransitionDown( self,wall )


       local  wallHeight = wall:getWallHeight() -2
      -- print("wallHeight="..wallHeight)
       --print("selfy"..self:getY())
       local listener1 = function ( )
                         wall:setWallFront()
                         end
       local listener2 = function () 
                  if (self.died== false) then 
                        self.view:removeSelf() self = nil
                  end
       end
       local gangsterTransition = transition.to (self.view,{time=constants.gangTransitionDownDur,transition=easing.inOutSine, delay=constants.gangesterTransitionDelay , y = self:getY() + wallHeight ,onStart = listener1  , onComplete = listener2 }) 
      
end
function gangesterIsKillingU( self , wall )
         local listener1 = function ( )
                         wall:setWallFront()
                         end
       local listener2 = function () 
                  if (self.died== false) then 
                        self.view:removeSelf() self = nil
                  end
       end
      local gangesterIsKillingU = transition.to (self.view,{time=constants.gangesterIsKillingUDur,transition=easing.inOutSine, delay=constants.gangesterTransitionDelay , y = self:getY() - 140  ,onStart = listener1  }) 
end

function characterTransitionUp( self , wall)
       local  wallHeight = wall:getWallHeight()
       local listener1 = function ( )
                         wall:setWallFront()
                         end
      
       gangsterTransition = transition.from(self.view,{time=constants.gangTransitionUpDur,transition=easing.inOutSine, delay=100, y = self:getY() + self:getGangsterHeight()    , onComplete = listener1 }) 

end  
