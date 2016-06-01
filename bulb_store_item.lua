-- bulb_store_item

require("class")

BulbStoreItem = class(function(c, x, y, width, height, itemType, ui)
    c.x = x
    c.y = y
    c.width = width
    c.height = height
    c.itemType = itemType
    c.itemView = nil
    c.ui = ui
    c.events = {}
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
       
        self.ui:plantingFunction(self.itemType)
    end
end
