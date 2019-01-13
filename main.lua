-----------------------------------------------------------------------------------------
--
-- main.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This calls the splash screen of the app to load itself.
-----------------------------------------------------------------------------------------

-- Hiding Status Bar
display.setStatusBar(display.HiddenStatusBar)
-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Go to the intro screen

--composer.gotoScene( "level1_screen" )

composer.gotoScene( "final_boss" )

--composer.gotoScene( "splash_screen" )

