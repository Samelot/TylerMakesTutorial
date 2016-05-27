require("class")

BulbGame = class(function(c, width, height)
    c.width = width
    c.height = height
    c.mode = false
    c.map = nil
    c.player = nil
    c.keyTimer = 0
    c.touchEvent = nil
    c.mode = "moving"
    c.rotationEndTimer =
end)
