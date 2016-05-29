require("class")
require("bulb_tile")

BulbMap = class(function(c, width, height, rows, columns)
    c.width = width
    c.height = height
    c.rows = rows
    c.columns = columns
    c.tileSize = c.height/rows
    c.layers = {}
end)

function BulbMap:create(group)
end

function BulbMap:removeSelf()
end
