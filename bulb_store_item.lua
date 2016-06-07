-- bulb_store_item

require("class")

BulbStoreItem = class(function(c, x, y, width, height, itemType, name, inventory, ui)
    c.x = x
    c.y = y
    c.width = width
    c.height = height
    c.itemType = itemType
    c.ui = ui
    c.name = name
    c.inventory = inventory
    c.itemView = nil
    c.nameView = nil
    c.inventoryView = nil
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

    local nameViewOptions = {
        text = self.name,
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
    nameView:setFillColor(1-1/self.itemType, 1-1/self.itemType, 1)
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
    inventoryView:setFillColor(1, 1-1/self.itemType, 1-1/self.itemType)
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
       
        self.ui:plantingFunction(self.itemType)
    end
end
