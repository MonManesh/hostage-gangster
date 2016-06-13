local composer = require( "composer" )
local scene = composer.newScene()
local physics = require ("physics") 
local mydata = require( "mydata" )
local score = require( "score" )
physics.start(); physics.pause()
physics.setDrawMode( "hybrid")


function scene:create( event )
	local screenGroup = self.view
	local background = display.newImageRect( "background.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	screenGroup:insert(background)

	gameOverImage = display.newImageRect("gm.png",500,370)
	gameOverImage.anchorX = 0.5
	gameOverImage.anchorY = 0.5
	gameOverImage.x = display.contentCenterX 
	gameOverImage.y = display.contentCenterY 
	gameOverImage.alpha = 1
	local gameOverTransition = transition.to(gameOverImage, {time=2000,transition=easing.inElastic , delay=500 , y=display.contentCenterY +300})
	screenGroup:insert(gameOverImage)
	 --**--

	scoreText = display.newText(mydata.score,30,
	30, native.systemFont, 50)
	scoreText:setFillColor(1,1,1)
	scoreText.alpha = 0
	screenGroup:insert(scoreText)
	
	bestText = score.init({
	fontSize = 50,
	font = "Helvetica",
	x =  5,
	y =  85,
	maxDigits = 7,
	leadingZeros = false,
	filename = "scorefile.txt",
	})
	bestScore = score.get()
	bestText.text = bestScore
	bestText.alpha = 1
	bestText:setFillColor(1,1,1)
	screenGroup:insert(bestText)





	function loadScore()
	local prevScore = score.load()
	if prevScore ~= nil then
		if prevScore <= mydata.score then
			score.set(mydata.score)
			
			print ("*********************88your  score is"..mydata.score)
		else 
			score.set(prevScore)	
		end
	else 
		score.set(mydata.score)	
		score.save()
	end
end

function saveScore()
	score.save()
end 

end
function scene:show(event)
	loadScore()
	
end

function scene:hide(event)
	
end

function scene:destroy(event)

end
function restartGame(event)
     if event.phase == "ended" then
		saveScore()
		composer.gotoScene("menu")
     end
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
