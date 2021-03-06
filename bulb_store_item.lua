-- bulb_store_item

require("class")

BulbStoreItem = class(function(c, x, y, width, height, item, inventory, ui)
    c.x = x
    c.y = y
    c.width = width
    c.height = height
    c.item = item
    c.ui = ui
    c.name = c.item.tileName
    c.inventory = inventory
    c.itemView = nil
    c.nameView = nil
    c.inventoryView = nil
    --c.events = {}
end)

function BulbStoreItem:create(group)
    local itemView = display.newRect(0, 0, self.width, self.height)
    itemView:setFillColor(self.item.color.r, self.item.color.g, self.item.color.b)
    -- anchor set top-left
    itemView.anchorX = 0
    itemView.anchorY = 0
    itemView.x = self.x
    itemView.y = self.y
    self.itemView = itemView

    local nameViewOptions = {
        text = self.item.tileName,
        x = 0,
        y = 0,
        width = self.width,
        height = self.height,
        font = native.systemFont,
        fontSize = 24,
        align = "left"
    }

    -- Add name text
    local nameView = display.newText(nameViewOptions)  
    -- Cool for prototyping: inverse color
    -- nameView:setFillColor(1-1/self.itemType, 1-1/self.itemType, 1)
    nameView:setFillColor(0, 0, 0)
    -- anchor set top-left
    nameView.anchorX = 0
    nameView.anchorY = 0
    nameView.x = self.x
    nameView.y = self.y
    self.nameView = nameView
    
    local inventoryViewOptions = {
        text = self.inventory,
        x = 0,
        y = 0,
        width = self.width,
        height = self.height,
        font = native.systemFont,
        fontSize = 24,
        align = "right"
    }
    
    -- Add inventory text
    local inventoryView = display.newText(inventoryViewOptions)
    inventoryView:setFillColor(0, 0, 0)
    -- anchor set top-left
    inventoryView.anchorX = 0
    inventoryView.anchorY = 0
    inventoryView.x = self.x
    inventoryView.y = self.y
    self.inventoryView = inventoryView
    self.itemView = itemView
    self.itemView:addEventListener("touch", self)
    group:insert(self.itemView)
    group:insert(self.nameView)
    group:insert(self.inventoryView)
end

function BulbStoreItem:updateInventory(newValue)
    self.inventoryView.text = newValue
    self.inventory = newValue
end

function BulbStoreItem:touch(event)
    local destination = {}
    if (event.phase == "began") then
        destination.x = event.x
        destination.y = event.y
       
        self.ui:plantingFunction(self.item)
    end
end

function BulbStoreItem:removeSelf()
    if(self.nameView) then
        self.nameView:removeSelf()
        self.nameView = nil
    end
    if(self.inventoryView) then
        self.inventoryView:removeSelf()
        self.inventoryView = nil
    end
    if(self.itemView) then
        self.itemView:removeSelf()
        self.itemView = nil
    end
end
