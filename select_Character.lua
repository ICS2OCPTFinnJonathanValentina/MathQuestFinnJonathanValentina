-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Valentina G Melendez
-- Date: 26 November, 2018
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "select_Character"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local boyButton
local girlButton
local boyCharacter
local girlCharacter

-- background music
--local bkgSound = audio.loadSound("Sounds/background_music.mp3")
--local bkgSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Instructions Page
local function boyCharacter( )       
    composer.gotoScene( "level1_screen", {effect = "slideDown", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition Function to Instructions Page
local function girlCharacter( )       
    composer.gotoScene( "level1_screen", {effect = "slideDown", time = 500})
end 
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- set the background colour
    bkg_image = display.newImageRect("Images/kingdomBkg.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- displays text on the screen at position x = 500 and y = 5 with
    -- a deafult font style and font size of 50 
    textObject = display.newText( "Pick ye chracter", 500, 150, nil, 50)

    -- sets the color of the text
    textObject:setTextColor(0, 0, 0)

    -- Associating display objects with this scene 
    sceneGroup:insert( textObject )

    -- set the background colour
    boyCharcter = display.newImage("Images/BoyCharacterValentina.png", 500, 500)
    boyCharcter.x = 300
    boyCharcter.y = 500
    boyCharcter.width = 100
    boyCharcter.height = 125

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )


    girlCharacter = display.newImage("Images/GirlCharacterValentina.png", 500, 500)
    girlCharacter.x = 300
    girlCharacter.y = 500
    girlCharacter.width = 100
    girlCharacter.height = 125

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Instructoins Button
    boyButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*2/6,
            y = display.contentHeight*6/8,
            -- Insert the images here
            defaultFile = "Images/boyButton.png",
            overFile = "Images/boyButton.png",

            width = 175,
            height = 175,

            -- When the button is released, call the instructions screen transition function
            onRelease = Level1ScreenTransition      
        } )
-----------------------------------------------------------------------------------------
    -- Creating Play Button
    girlButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/girlButton.png",
            overFile = "Images/girlButton.png",


            width = 175,
            height = 175,

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

     
    -- Associating button widgets with this scene
    sceneGroup:insert( boyButton )
    sceneGroup:insert( girlButton )
    

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then       
        -- background music
        --bkgSoundChannel = audio.play(bkgSound)

    end

    

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        --audio.stop(bkgSoundChannel)
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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
