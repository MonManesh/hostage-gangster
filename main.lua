-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"
 require "constants"

--print( "gang width is " .. constants.gangesterWidth)

-- load menu screen
composer.gotoScene( "menu" )