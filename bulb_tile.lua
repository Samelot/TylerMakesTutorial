require("class")

BulbTile = class(function(c, i, j, x, y, size)
    c.i = i
    c.j = j
    c.x = x
    c.y = y
    c.size = size
    c.tileView = nil
    c.harvestCounter = 0
    c.harvestCountView = nil
    c.type = nil
    c.state = "dirt"
end)

function BulbTile:create(group, type)
    self.type = type
    local plant = bulbGameSettings.types[type] 
    local tileView = display.newRect(0, 0, self.size, self.size)
    tileView:setFillColor(.8, .6, 0)   
    -- anchor set top-left
    tileView.anchorX = 0
    tileView.anchorY = 0
    tileView.x = self.x
    tileView.y = self.y
    self.tileView = tileView 
    group:insert(self.tileView)
    if(type) then
        self.state = "growing"
        tileView:setFillColor(plant.color.r, plant.color.g, plant.color.b)
        self.harvestCounter = 100
 
        -- ADD HARVEST TEXT COUNT
        local harvestCountViewOptions = {
            text = self.harvestCounter,
            x = 0,
            y = 0,
            width = self.width,
            height = self.height,
            font = native.systemFont,
            fontSize = 24,
            align = "left"
        }
    
        local harvestCountView = display.newText(harvestCountViewOptions)
        -- anchor set top-left
        harvestCountView.anchorX = 0
        harvestCountView.anchorY = 0
        harvestCountView.x = self.x
        harvestCountView.y = self.y
        self.harvestCountView = harvestCountView 
        group:insert(self.harvestCountView)
    end
end

function BulbTile:update()
    if(self.state == "growing") then
        if(self.harvestCounter >= 1) then
            self.harvestCounter = self.harvestCounter - 1
            self.harvestCountView.text = self.harvestCounter
        else
            self.state = "harvestable"
            self.harvestCountView = "HARVEST"
        end
    end
end

function BulbTile:removeSelf()
    if(self.tileView) then
        self.tileView:removeSelf() -- destroy rectangles, accessor of rect()
        self.tileView = nil
    end
    if(self.harvestCountView) then
        self.harvestCountView:removeSelf()
        self.harvestCountView = nil
    end
end
