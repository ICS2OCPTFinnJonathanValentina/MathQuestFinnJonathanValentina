-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Allison
-- Date: May 16, 2017
-- Description: This is the level 1 screen of the game. the charater can be dragged to move
--If character goes off a certain araea they go back to the start. When a user interactes
--with piant a trivia question will come up. they will have a limided time to click on the answer
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "select_Character"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------


character = nil



-- The local variables for this scene
local questionText

local correctObject
local incorrectObject

local firstNumber
local secondNumber

local boyCharacter
local girlCharacter

local answer
local wrongAnswer1
local wrongAnswer2
local wrongAnswer3

local answerText 
local wrongAnswerText1
local wrongAnswerText2
local wrongAnswerText3

local answerPosition = 1
local bkg

local userAnswer
local textTouched = false


-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function GoToLevel1() 
 composer.gotoScene("level1_screen")
end

local function nextQuestion()
    -- go to next question
     composer.gotoScene("level2_screen")
end

-----------------------------------------------------------------------------------------
--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListener(touch)
    
    if (touch.phase == "ended") then
     boyCharacter = display.newImageRect("Images/BoyCharacterValentina.png", 500, 150)
     boyCharacter.width = 75
     boyCharacter.height = 100
     boyCharacter.myName = "BoyQuest"
     timer.performWithDelay(1000, GoToLevel1) 

    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListener2(touch)
    userAnswer = wrongText1.text
    
    if (touch.phase == "ended") then
     girlCharacter = display.newImageRect("Images/GirlCharacterValentina.png", 500, 150)
     girlCharacter.x = display.contentWidth * 0.5 / 6
     girlCharacter.y = display.contentHeight  * 0.5 / 2
     girlCharacter.width = 75
     girlCharacter.height = 100
     girlCharacter.myName = "GirlQuest"
     timer.performWithDelay(1000, BackToLevel1) 
    end 

end
-----------------------------------------------------------------------
--adding the event listeners 
local function AddTextListeners ( )
    boyCharacter:addEventListener( "touch", TouchListener)
    girlCharacter:addEventListener( "touch", TouchListener2)
end

--removing the event listeners
local function RemoveTextListeners()
    boyCharacter:removeEventListener( "touch", TouchListener)
    girlCharacter:removeEventListener( "touch", TouchListener2)
end

local function PositionCharacters()

    --creating random start position in a cretain area

 boyCharacter.x = 270
 boyCharacter.y = 350
            
 girlCharacter.x = 750
 girlCharacter.y = 350
            
    
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view  

    -----------------------------------------------------------------------------------------
    --covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.5)

    -----------------------------------------------------------------------------------------
    boyCharacter = display.newImageRect("Images/BoyCharacterValentina.png", 200, 365)
    boyCharacter.x = 270
    boyCharacter.y = 550


    girlCharacter = display.newImageRect("Images/GirlCharacterValentina.png", 200, 365)
    girlCharacter.x = 850
    girlCharacter.y = 350


    textObject = display.newText( "Press one of the Questers", 510, 650, nil, 50)

 
    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(boyCharacter)
    sceneGroup:insert(girlCharacter)
end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        PositionCharacters()
        AddTextListeners()
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        --parent:resumeGame()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveTextListeners()
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
