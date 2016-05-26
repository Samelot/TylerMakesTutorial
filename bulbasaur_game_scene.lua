local composer = require( "composer" )
local scene = composer.newScene()

-- local game

local function onEnterFrame()
    game:update()
end

function scene:create( event )
    local group = self.view
end

function scene:show( event )
    local group = self.view

    local myRectangle = display.newRect( 0, 0, 150, 50 )
    myRectangle.strokeWidth = 3
    myRectangle:setFillColor( 1 )
    myRectangle:setStrokeColor( 1, 0, 0 )
    myRectangle.anchorX = 0
    myRectangle.anchorY = 0

    Runtime:addEventListener( "enterFrame", onEnterFrame )
end

function scene:exit( event )
    local group = self.view
end

function scene:hide( event )
    local group = self.view
end

function scene:destroy( event )
    local group = self.view
end

-----

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", screne )
scene:addEventListener( "destroy", scene )

-----

return scene
