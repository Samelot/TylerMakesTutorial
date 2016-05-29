require("class")
require("bulb_map")

-- init function
-- when initialized from bulbasaur_game_scene, automatically has access to self var

BulbGame = class(function(c, width, height)
    c.width = width
    c.height = height
    c.map = nil
    c.player = nil
end)

-- explicit create function, creates and displays

function BulbGame:create(group)
    local rows = 15
    local size = self.height/rows
    local columns = Math.floor(self.width/size)

    self.map = BulbMap(self.width, self.height, rows, columns)
    self.map:create(group)
end

function BulbGame:removeSelf(group)
    if(self.map) then
        self.map:removeSelf()
    end
end

