require("class")

BulbTile = class(function(c, i, j, x, y, size)
    c.i = i
    c.j = j
    c.x = x
    c.y = y
    c.size = size
    c.open = true
    c.tileView = nil
end)

local tile = BulbTile()
