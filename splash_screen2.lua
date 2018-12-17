-----------------------------------------------------------------------------------------
--
-- splash_screen2.lua
-- Created by: Finn
-- Date:12-14, 2018
-- Description: This is the splash screen of the game. It displays the 
-- company logo that gows and moves across the screen
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local name
local logo
local scrollSpeed = 3
local swordSound = audio.loadSound("Sounds/sword.mp3")
local swordSoundChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the beetleship across the screen
local function moveLogo()
     -- add the scroll speed to the x-value of the ship
     logo.x = logo.x + scrollSpeed
     -- change the transparency of the ship every time it moves so that it fades in
     logo.alpha = logo.alpha + 0.01
     logo:scale(1.005,1.005)
end  

local function NameFadeIn()
    -- add to the alpha
    name.alpha = name.alpha + 0.006

end

-- The function that will go to the main menu 
local function gotoMainMenu()
<<<<<<< HEAD
    composer.gotoScene( "splash_screen4" )
=======
    composer.gotoScene( "main_menu" )
>>>>>>> 11d3432f2770ad825ae29b478dbee0080c26e144
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Insert the beetleship image
    logo = display.newImageRect("Images/CompanyLogoFinn.png", 200, 200)

    -- set the initial x and y position of the beetleship
    logo.x = 100
    logo.y = display.contentHeight/2

    --diplsay company name
    name = display.newText("Dark Excalibur" ,  400, 100, nil,  75)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( name )
end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        swordSoundChannel = audio.play(swordSound )

        -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveLogo)

         -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", NameFadeIn)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 5000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(swordSoundChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
