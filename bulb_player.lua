require("class")

BulbPlayer = class(function(c)
    c.itemBag = {}
    for k, v in pairs(bulbGameSettings.types) do
        c.itemBag[k] = { name=k, inventory=math.random(30) }
    end
    c.events = {}
end)

function BulbPlayer:deductItem(type, num)
    self.itemBag[type].inventory = self.itemBag[type].inventory - num
    itemUsedEvent = {
        name = "itemUsed",
        type = type,
        newValue = self.itemBag[type].inventory
    }
    self:dispatchEvent(itemUsedEvent)
end

function BulbPlayer:addEventListener(type, object)
    --print("type:", type);
    --object.selectPlant(self, 3)
    --object:selectPlant(3)

    if(not self.events[type]) then
        self.events[type] = {}
    end
    -- obj passed from bulb_game, obj assigned to events[]
    self.events[type][#self.events[type] + 1] = object
end

function BulbPlayer:dispatchEvent(data)
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

