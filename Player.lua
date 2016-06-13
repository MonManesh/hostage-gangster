module(..., package.seeall)

local json = require( "json")
local name = ""
local lastScore = 0 
local bestScore = 0
local level = 1
local pals = {} -- will be used for saving pal id's 
function new (self , obj)
       obj = obj or {}   -- create table if user does not provide one
       setmetatable( obj, self )
       self.__index = self

       return obj
end
function newRecord(currentScore, preScore)
	if (preScore ~= nil)then
		if ( preScore < currentScore )then
			return currentScore
		else
			return preScore
		end
	else
		return currentScore
	end
end
function loadPlayerInfo()
	local path = system.pathForFile( "scorefile.txt", system.DocumentsDirectory)
	local file = io.open( path, "r" )
	if file then
 	-- read all contents of file into a string
 		local contents = file:read( "*a" )
  		myTable = json.decode(contents);
 		io.close( file )
 		_G.currentUser.name = myTable.name

		_G.currentUser.bestScore = myTable.record
		
		return true
    end
    return false
end

