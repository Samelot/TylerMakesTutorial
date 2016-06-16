-- bulb_store_tool

require("class")

BulbStoreTool = class(function(c, x, y, width, height, item, ui)
    c.x = x
    c.y = y
    c.width = width
    c.height = height
    c.item = item
    c.ui = ui
    c.name = c.item.tileName
    c.itemView = nil
    c.nameView = nil
end)

function BulbStoreTool:create(group)
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
    
    group:insert(self.itemView)
    group:insert(self.nameView)
end

function BulbStoreTool:touch(event)
    local destination = {}
    if (event.phase == "began") then
        destination.x = event.x
        destination.y = event.y
       
        self.ui:selectTool(self.name)
    end
end
