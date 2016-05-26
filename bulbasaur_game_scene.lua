local composer = require( "composer" )
local scene = composer.newScene()

local myRectangle = nil

local function onEnterFrame()
    --myRectangle.x = myRectangle.x + 10
end

function scene:create( event )
    local group = self.view

    myRectangle = display.newRect( 0, 0, 150, 50 )
    myRectangle.strokeWidth = 3
    myRectangle:setFillColor( 1 )
    myRectangle:setStrokeColor( 1, 0, 0 )
    myRectangle.anchorX = 0
    myRectangle.anchorY = 0

    group:insert(myRectangle)

    local function moveBlock( event )
        if (event.phase == "began") then
            myRectangle.x = myRectangle.x + 10
        end
        return true
    end

    Runtime:addEventListener( "enterFrame", onEnterFrame )
    group:addEventListener("touch", moveBlock)
end

function scene:show( event )
    local group = self.view
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
