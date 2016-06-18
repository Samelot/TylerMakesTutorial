-- bulb_home

require("class")
require("bulb_map")
require("bulb_ui")
require("bulb_player")

-- init function
-- when initialized from bulbasaur_game_scene, automatically has access to self var

BulbHome = class(function(c, width, height, composer)
    c.width = width
    c.height = height
    c.player = nil
    c.ui = nil
    c.state = "nothing"
    c.selectedPlant = nil
    c.selectTool = nil
    c.composer = composer
end)

-- explicit create function, creates and displays
function BulbHome:create(group)
    local rows = 15
    local size = self.height/rows
    local mapWidth = self.width/5*4
    local columns = math.floor(mapWidth/size)

    self.player = BulbPlayer()

    local garden = {tileName="garden", color=BulbColor(0.8, 0.6, 1)}
    -- param self:setPlanting, sends entire function through to bulb_ui
    self.ui = BulbUI(garden, self.player, mapWidth, 0, self.width/5, self.height, 10)
    -- pass BulbHome obj to our ui on event listener
    self.ui:addEventListener("selectPlant", self)
    self.ui:addEventListener("selectTool", self)
    self.ui:create(group)

    Runtime:addEventListener("enterFrame", self)
end

function BulbHome:enterFrame()
    self:update()
end

function BulbHome:update()
end

-- from dispatchEvent in bulb_ui
function BulbHome:selectPlant(data)
    self.state = "planting"
    self.selectedPlant = data.item
end

-- from dispatchEvent in bulb_ui
function BulbHome:selectTool(data)
    if(data.type == "garden") then
        self.composer.gotoScene("bulb_game_scene")
    else 
        self.state = "tooling"
        self.selectedTool = data.type
    end
end

function BulbHome:setPlanting(plantType)
    print("trying to plant: " .. plantType)
end

function BulbHome:removeSelf(group)
    if(self.map) then
        self.map:removeSelf()
    end
end

