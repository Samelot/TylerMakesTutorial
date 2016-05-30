-- BASE GAME

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
end)

-- explicit create function, creates and displays

function BulbGame:create(group)
    local rows = 15
    local size = self.height/rows
    local mapWidth = self.width/5*4
    local columns = math.floor(mapWidth/size)

    self.map = BulbMap(self.width, self.height, rows, columns)
    self.map:create(group)

    self.ui = BulbUI(mapWidth, 0, self.width/5, self.height, 10)
    self.ui:create(group)
end

function BulbGame:removeSelf(group)
    if(self.map) then
        self.map:removeSelf()
    end
end

