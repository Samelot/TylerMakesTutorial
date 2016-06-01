-- bulb_game

require("class")
require("bulb_map")
require("bulb_ui")

-- init function
-- when initialized from bulbasaur_game_scene, automatically has access to self var

BulbGame = class(function(c, width, height)
    c.width = width
    c.height = height
    c.map = nil
    c.player = nil
    c.ui = nil
    c.state = "nothing"
    c.selectedPlantType = nil
end)

-- explicit create function, creates and displays

function BulbGame:create(group)
    local rows = 15
    local size = self.height/rows
    local mapWidth = self.width/5*4
    local columns = math.floor(mapWidth/size)

    self.map = BulbMap(self.width, self.height, rows, columns)
    self.map:create(group)
    self.map:addEventListener("selectTile", self)

    -- param self:setPlanting, sends entire function through to bulb_ui
    self.ui = BulbUI(mapWidth, 0, self.width/5, self.height, 10, self.setPlanting)
    -- pass BulbGame obj to our ui on event listener
    self.ui:addEventListener("selectPlant", self)
    self.ui:create(group)
end

-- from dispatchEvent in bulb_ui

function BulbGame:selectPlant(data)
    self.state = "planting"
    print("selecting:", data.type)
    self.selectedPlantType = data.type
end

function BulbGame:selectTile(event)
    print("touch", event.x, event.y)
    if(self.state == "planting") then
        self.map:plant(event.x, event.y, self.selectedPlantType)
    end
end

function BulbGame:setPlanting(plantType)
    print("trying to plant: " .. plantType)
end

function BulbGame:removeSelf(group)
    if(self.map) then
        self.map:removeSelf()
    end
end

