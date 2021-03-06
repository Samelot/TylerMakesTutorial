-- bulb_game

require("class")
require("bulb_map")
require("bulb_ui")
require("bulb_player")

-- init function
-- when initialized from bulbasaur_game_scene, automatically has access to self var

BulbGame = class(function(c, width, height, composer)
    c.width = width
    c.height = height
    c.map = nil
    c.player = nil
    c.ui = nil
    c.state = "nothing"
    c.selectedPlant = nil
    c.selectTool = nil
    c.composer = composer
end)

-- explicit create function, creates and displays
function BulbGame:create(group)
    local rows = 15
    local size = self.height/rows
    local mapWidth = self.width/5*4
    local columns = math.floor(mapWidth/size)

    self.player = BulbPlayer()

    self.map = BulbMap(self.width, self.height, rows, columns)
    self.map:create(group)
    self.map:addEventListener("selectTile", self)

    local home = {tileName="home", color=BulbColor(0.8, 0.6, 1)}
    -- param self:setPlanting, sends entire function through to bulb_ui
    self.ui = BulbUI(home, self.player, mapWidth, 0, self.width/5, self.height, 10)
    -- pass BulbGame obj to our ui on event listener
    self.ui:addEventListener("selectPlant", self)
    self.ui:addEventListener("selectTool", self)
    self.ui:create(group)

    Runtime:addEventListener("enterFrame", self)
end

function BulbGame:enterFrame()
    self:update()
end

function BulbGame:update()
    self.map:update()
end

-- from dispatchEvent in bulb_ui
function BulbGame:selectPlant(data)
    self.state = "planting"
    self.selectedPlant = data.item
end

-- from dispatchEvent in bulb_ui
function BulbGame:selectTool(data)
    if(data.type == "home") then
        self.composer.gotoScene("bulb_home_scene", "fade", 500)
    else
        self.state = "tooling"
        self.selectedTool = data.type
    end
end

-- from dispatchEvent in bulb_map 
function BulbGame:selectTile(event)
    if (self.state == "planting") then 
        if (self.player.itemBag[self.selectedPlant.tileName].inventory >= 1 and
            self.map:canPlant(event.x, event.y, self.selectedPlant.tileName)) then
            self.map:plant(event.x, event.y, self.selectedPlant.tileName)
            self.player:deductItem(self.selectedPlant.tileName, 1)
        end
    elseif (self.state == "tooling") then
        if (self.map:canHarvest(event.x, event.y)) then
            local typeHarvested = self.map:harvest(event.x, event.y)
            self.player:addItem(typeHarvested, 2)
        end
    end
end

function BulbGame:setPlanting(plantType)
    print("trying to plant: " .. plantType)
end

function BulbGame:removeSelf(group)
    if(self.map) then
        self.map:removeSelf()
    end
    if(self.ui) then
        self.ui:removeSelf()
    end
    if(self.player) then
        self.player:removeSelf()
    end
end

