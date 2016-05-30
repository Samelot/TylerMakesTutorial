require("class")
require("bulb_store_item")

BulbUI = class(function(c, x, y, width, height, itemNumber)
    c.x = x
    c.y = y
    c.width = width
    c.height = height
    c.itemNumber = itemNumber
    c.itemHeight = height/itemNumber
end)

function BulbUI:create(group)
    items = {}
    for i=1, self.itemNumber do
        local y = self.y + ((i-1) * self.itemHeight)
        local bulbStoreItem = BulbStoreItem(self.x, y, self.width, self.itemHeight, i) 
        bulbStoreItem:create(group)
    end
end

