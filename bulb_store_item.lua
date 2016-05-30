require("class")

BulbStoreItem = class(function(c, x, y, width, height, itemType)
    c.x = x
    c.y = y
    c.width = width
    c.height = height
    c.itemType = itemType
    c.itemView = nil
end)

function BulbStoreItem:create(group)
    local itemView = display.newRect(0, 0, self.width, self.height)
    
    itemView:setFillColor(1/self.itemType, 1/self.itemType, 1/self.itemType)
    -- anchor set top-left
    itemView.anchorX = 0
    itemView.anchorY = 0
    itemView.x = self.x
    itemView.y = self.y
    
    self.itemView = itemView
    self.itemView:addEventListener("touch", self)
    group:insert(self.itemView)
end

function BulbStoreItem:touch(event)
    local destination = {}
    if (event.phase == "began") then
        destination.x = event.x
        destination.y = event.y
        print("clicking:", self.itemType, bulbGameSettings.types[self.itemType].tileName, bulbGameSettings.types[self.itemType].cost)
    end
end

