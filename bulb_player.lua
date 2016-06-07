require("class")

BulbPlayer = class(function(c)
    c.itemBag = {}
    c.itemBag[1] = { name="test1", inventory=5 }
    c.itemBag[2] = { name="test2", inventory=31 } 
    c.itemBag[3] = { name="test3", inventory=6 }
    c.itemBag[4] = { name="test4", inventory=7 }
    c.itemBag[5] = { name="test5", inventory=46 }
    c.itemBag[6] = { name="test6", inventory=25 }
    c.itemBag[7] = { name="test7", inventory=11 }
    c.itemBag[8] = { name="test8", inventory=18 }
    c.itemBag[9] = { name="test9", inventory=49 }
    c.itemBag[10] = { name="test10", inventory=42 }
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

