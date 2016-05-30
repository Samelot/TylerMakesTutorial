----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- only make one! kind of like a singleton
require("bulb_game_settings")

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

bulbGameSettings = BulbGameSettings()

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "bulbasaur_game_scene" )
