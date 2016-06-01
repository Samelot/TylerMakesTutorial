-- BASE MAP

require("class")
require("bulb_tile")

BulbMap = class(function(c, width, height, rows, columns)
    c.width = width
    c.height = height
    c.rows = rows
    c.columns = columns
    c.tileSize = c.height/rows
    c.layers = {}
    c.events = {}
    c.tileGroup = nil
end)

function BulbMap:create(group)
    --print("map:", self.columns, ",", self.rows)

    self.tileGroup = display.newGroup()
    self.layers[1] = {}
    
    for i=1, self.columns do
        self.layers[1][i] = {}
        for j=1, self.rows do
            -- Understand: how rows / BulbTile() constructs
            self.layers[1][i][j] = BulbTile(i, j, (i-1) * self.tileSize, (j-1) * self.tileSize, self.tileSize)
            self.layers[1][i][j]:create(self.tileGroup)
        end
    end

    self.tileGroup:addEventListener("touch", self)
end

function BulbMap:plant(i, j, type)
    self.layers[1][i][j]:removeSelf()
    self.layers[1][i][j] = nil
    self.layers[1][i][j] = BulbTile(i, j, (i-1) * self.tileSize, (j-1) * self.tileSize, self.tileSize)
    self.layers[1][i][j]:create(self.tileGroup, type)
end

function BulbMap:touch(event)
    -- Understand: math
    selectTileEvent = {
        name = "selectTile",
        x = math.floor(event.x / self.tileSize) + 1,
        y = math.floor(event.y / self.tileSize) + 1
    }
    
    self:dispatchEvent(selectTileEvent)
end

function BulbMap:addEventListener(type, object)
    if(not self.events[type]) then
        self.events[type] = {}
    end
    -- obj passed from bulb_map, obj assigned to events[]
    self.events[type][#self.events[type] + 1] = object
end

function BulbMap:dispatchEvent(data)
    if(self.events[data.name]) then
        for i=1, #self.events[data.name] do
            -- Understand: given that listener, call a function using data.name?? 
                      
            -- fetch obj by the event name
                -- self.events[data.name][i]
            
            -- function's name
                -- [data.name]
            
            -- passes object to function                
                -- (self.events[data.name][i], type)
                -- used to be... (self, data)
   
            self.events[data.name][i][data.name](self.events[data.name][i], data)
        end
    end
end


function BulbMap:removeSelf()
    if(self.layers[1]) then
        for i=1, #self.layers[1] do
            for j=1, #self.layers[1][i][j] do
                self.layers[1][i][j]:removeSelf()
                self.layers[1][i][j] = nil
            end
        end
    end
end

