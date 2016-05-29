require("bulb_game")

local composer = require("composer")
local scene = composer.newScene()

--local character = nil
--local destination = nil
--local moveSpeed = 100
--i = 30

local game 

--local function onEnterFrame()
--    if(i <= 0) then
--        if(character.x < destination.x) then
--            character.x = character.x + moveSpeed
--        end    
--        if(character.x > destination.x) then
--            character.x = character.x - moveSpeed
--        end
--        if(character.y < destination.y) then
--            character.y = character.y + moveSpeed
--        end    
--        if(character.y > destination.y) then
--            character.y = character.y - moveSpeed
--        end
--        print("character:", character.x, ":", character.y)
--        i = 0
--    else
--        i = i - 1
--    end
--end

function scene:create( event )
    local group = self.view
    local game = BulbGame(display.contentWidth, display.contentHeight)
    game:create(group)

--    local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
--    background:setFillColor(.16)
--    background.anchorX = 0
--    background.anchorY = 0
--
--    character = display.newRect(0, 0, 40, 40)
--    character:setFillColor(0.7, 1, 0.7 )
--    character:setStrokeColor(0, 0, 0)
--    character.anchorX = 0
--    character.anchorY = 0
--
--    destination = display.newRect(0, 0, 10, 10)
--    destination:setFillColor(1, 0, 0)
--    destination.anchorX = 0
--    destination.anchorY = 0
--
--    group:insert(background)
--    group:insert(character)
--    group:insert(destination)
--
--    local function moveBlock( event )
--        if (event.phase == "began") then
--            destination.x = event.x
--            destination.y = event.y
--        end
--        print("destination:", destination.x, ":", destination.y)
--        return true
--    end
--
--    Runtime:addEventListener( "enterFrame", onEnterFrame )
--    group:addEventListener("touch", moveBlock)
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
