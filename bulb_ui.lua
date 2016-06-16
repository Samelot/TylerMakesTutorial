-- bulb_ui
require("class")
require("bulb_store_item")
require("bulb_store_tool")
require("bulb_color")

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
    --c.tools = nil
    c.events = {}
end)

function BulbUI:create(group)
    items = {}
    --tools = {}

    --local shovel = {tileName = "shovel", color = BulbColor(.6, .4, .4)}
    --local bulbStoreTools = BulbStoreTool(self.x, self.y + self.itemHeight, self.width, self.itemHeight, shovel, self)
    --bulbStoreTools:create(group)

    local i = 0
    for k, v in pairs(self.player.itemBag) do
        local y = self.y + (i * self.itemHeight)
        local item = bulbGameSettings:getItemByName(k)
        local bulbStoreItem = BulbStoreItem(self.x, y, self.width, self.itemHeight, item, self.player.itemBag[item.tileName].inventory, self) 
        bulbStoreItem:create(group)
        items[k] = bulbStoreItem
        i = i + 1
    end
    self.items = items
    --self.tools = tools
    self.player:addEventListener("itemUsed", self)
end

function BulbUI:itemUsed(event)
    print("ui:item used:", event.type, event.newValue)
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
   
    print(self.events)
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

function BulbUI:plantingFunction(item)
    plantEvent = {
        name = "selectPlant",
        item = item
    }
    BulbUI:dispatchEvent(self, plantEvent)
end


