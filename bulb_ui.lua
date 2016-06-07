-- bulb_ui
require("class")
require("bulb_store_item")

-- SAM plantingFunction
BulbUI = class(function(c, player, x, y, width, height, itemNumber)
    c.x = x
    c.y = y
    c.player = player
    c.width = width
    c.height = height
    c.itemNumber = itemNumber
    c.itemHeight = height/itemNumber
    c.items = nil
    c.events = {}
end)

function BulbUI:create(group)
    items = {}
    for i=1, self.itemNumber do
        local y = self.y + ((i-1) * self.itemHeight)
        local bulbStoreItem = BulbStoreItem(self.x, y, self.width, self.itemHeight, i, self.player.itemBag[i].name, self.player.itemBag[i].inventory, self) 
        bulbStoreItem:create(group)
        items[#items + 1] = bulbStoreItem
    end
    self.items = items
    self.player:addEventListener("itemUsed", self)
end

function BulbUI:itemUsed(event)
    --print("ui:item used:", event.type, event.newValue)
    self.items[event.type]:updateInventory(event.newValue)
end

-- these 2 functions below are confusing. Important to understand
function BulbUI:addEventListener(type, object)
    --print("type:", type);
    --object.selectPlant(self, 3)
    --object:selectPlant(3)

    if(not self.events[type]) then
        self.events[type] = {}
    end
    -- obj passed from bulb_game, obj assigned to events[]
    self.events[type][#self.events[type] + 1] = object
end

function BulbUI:dispatchEvent(data)
    
    -- self.events accesses local var in class
    -- c.events = {}

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

function BulbUI:plantingFunction(itemType)
    plantEvent = {
        name = "selectPlant",
        type = itemType
    }
    self:dispatchEvent(plantEvent)
end

