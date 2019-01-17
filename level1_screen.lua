-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Ms Raffin
-- Date: Nov. 22nd, 2014
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
--  Sound
----------------------------------------------------------------------------------------- 
-- GameOver Sound 
--local youLose = audio.loadSound("Sounds/battle003.mp3")
--local youLoseSoundChannel


-- background sound
local backgroundSound = audio.loadSound("Sounds/bkg2.mp3")
local backgroundSoundChannel

spikeSound = audio.loadSound("Sounds/spike.mp3")
spikeSoundChannel
-----------------------------------------------------------------------------------------
-- GlOBAL VARIABLES
-----------------------------------------------------------------------------------------

numLives = 3



-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local platform1
local platform2
local platform3
local platform4
local platform5

local spikes1
local spikes2
local spikes1platform
local spikes2platform
local spikes3platform

local heart1
local heart2
local heart3

local rArrow
local lArrow 
local uArrow

local motionx = 0
local SPEED = 7
local LINEAR_VELOCITY = -100
local GRAVITY = 7

local leftW 
local topW
local floor

local mathPuzzle1
local mathPuzzle2
local mathPuzzle3
local theMathPuzzle

local questionsAnswered = 0

local backButton

local character
local finalBoss
local theFinalBoss


-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------------------------- 
 
-- When right arrow is touched, move character right
local function right (touch)
    motionx = SPEED
    character.xScale = 1
end

-- When left arrow is touched, move character right
local function left (touch)
    motionx = -SPEED
    character.xScale = -1
end

-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    if (character ~= nil) then
        character:setLinearVelocity( 0, LINEAR_VELOCITY )
    end
end

-- Move character horizontally
local function movePlayer (event)
    character.x = character.x + motionx
end
 
-- Stop character movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
    end
end

local function YouLoseTransition()
    composer.gotoScene( "you_lose" )
end

local function YouWinTransition()
    composer.gotoScene( "you_win" )
end

local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    lArrow:addEventListener("touch", left)
    uArrow:addEventListener("touch", up)
end

local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    lArrow:removeEventListener("touch", left)
    uArrow:removeEventListener("touch", up)
end

local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop )
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("touch", stop )
end


local function ReplaceCharacter()
    print ("***Called ReplaceCharacter")

    if (characterName == "boy") then
        character = display.newImageRect("Images/BoyCharacterValentina.png", 90, 150)
        character.x = 100
        character.y = 100
    else
        character = display.newImageRect("Images/GirlCharacterValentina.png", 90, 150)
        character.x = 100
        character.y = 100

    end
        
    -- intialize horizontal movement of character
    motionx = 0
    -- add physics body
    physics.addBody( character, "dynamic", { density = 6, friction = 0.5, bounce = 0, rotation = 0 } )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

local function MakeMathPuzzlesVisible()
    mathPuzzle1.isVisible = true
    mathPuzzle2.isVisible = true
    mathPuzzle3.isVisible = true
end

local function MakeHeartsVisible()
    heart2.isVisible = true
    heart3.isVisible = true
end

local function  MakeFinalBossVisible()
    finalBoss.isVisible = true
end

local function  MakeTheGlowVisible()
    theGlow.isVisible = false
end

local function BackTransition()
    composer.gotoScene( "main_menu")
end

local function UpdateHearts()
    print ("***numLives = " .. numLives)
    if (numLives == 3) then
        heart1.isVisible = true
        heart2.isVisible = true
        heart3.isVisible = true
    elseif (numLives == 2) then
        heart1.isVisible = true
        heart2.isVisible = true
        heart3.isVisible = false
    elseif (numLives == 1) then
        heart1.isVisible = true
        heart2.isVisible = false
        heart3.isVisible = false
    elseif (numLives == 0) then
        heart1.isVisible = false
        heart2.isVisible = false
        heart3.isVisible = false
        character.isVisible = false
        timer.performWithDelay(100, YouLoseTransition)
        --youLoseSoundChannel = audio.play(YouLose)       
    end 
end

local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )

    if ( event.phase == "began" ) then

        --Pop sound
        popSoundChannel = audio.play(popSound)

        if  (event.target.myName == "spikes1") or 
            (event.target.myName == "spikes2") or
            (event.target.myName == "spikes3") then

            -- add sound effect here

            -- remove runtime listeners that move the character
            RemoveArrowEventListeners()
            RemoveRuntimeListeners()

            -- remove the character from the display
            display.remove(character)

            -- decrease number of lives
            numLives = numLives - 1

            UpdateHearts()

            if (numLives >= 0) then
                timer.performWithDelay(200, ReplaceCharacter)
            end
        end

        if  (event.target.myName == "mathPuzzle1") or
            (event.target.myName == "mathPuzzle2") or
            (event.target.myName == "mathPuzzle3") then

            -- get the ball that the user hit
            theMathPuzzle = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1 

            print("***questions answered = " .. questionsAnswered)

            -- show overlay with math question
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})

                    
            
        end

        if (event.target.myName == "theGlow") then
            --check to see if the user has answered 5 questions
            if (questionsAnswered == 3) then
                Grease_MonkeySoundChannel = audio.play(Grease_Monkey)

                print("***questions answered = " .. questionsAnswered)

                -- make the character invisible
                character.isVisible = false

                timer.performWithDelay(200, YouWinTransition)
            end
        end        

        if (event.target.myName == "theBoss") then

            -- get the puzzle that the user hit
            theFinalBoss = event.target



            -- show overlay with math question
            composer.showOverlay( "level1_boss", { isModal = true, effect = "fade", time = 100})

            -- make the character invisible
            character.isVisible = false

            if (questionsAnswered == 4) then
            
              print("***questions answered = " .. questionsAnswered)
            end
        end      

    end
end


local function AddCollisionListeners()
    -- if character collides with ball, onCollision will be called
    spikes1.collision = onCollision
    spikes1:addEventListener( "collision" )
    spikes2.collision = onCollision
    spikes2:addEventListener( "collision" )

    -- if character collides with ball, onCollision will be called    
    mathPuzzle1.collision = onCollision
    mathPuzzle1:addEventListener( "collision" )
    mathPuzzle2.collision = onCollision
    mathPuzzle2:addEventListener( "collision" )
    mathPuzzle3.collision = onCollision
    mathPuzzle3:addEventListener( "collision" )

    finalBoss.collision = onCollision
    finalBoss:addEventListener( "collision" )
end

local function RemoveCollisionListeners()
    spikes1:removeEventListener( "collision" )
    spikes2:removeEventListener( "collision" )

    mathPuzzle1:removeEventListener( "collision" )
    mathPuzzle2:removeEventListener( "collision" )
    mathPuzzle3:removeEventListener( "collision" )

    finalBoss:removeEventListener( "collision" )
end

local function AddPhysicsBodies()
    --add to the physics engine
    physics.addBody( platform1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform3, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform4, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform5, "static", { density=1.0, friction=0.3, bounce=0.2 } )



    physics.addBody( spikes1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( spikes2, "static", { density=1.0, friction=0.3, bounce=0.2 } )

    physics.addBody( spikes1platform, "static", { density=1.0, friction=0.3, bounce=0.2 } )

    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )

    physics.addBody(mathPuzzle1, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(mathPuzzle2, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(mathPuzzle3, "static",  {density=0, friction=0, bounce=0} )

    physics.addBody(finalBoss, "static",  {density=0, friction=0, bounce=0} )
end


local function RemovePhysicsBodies()
    physics.removeBody(platform1)
    physics.removeBody(platform2)
    physics.removeBody(platform3)
    physics.removeBody(platform4)
    physics.removeBody(platform5)

    physics.removeBody(spikes1)
    physics.removeBody(spikes2)

    physics.removeBody(spikes1platform)

    physics.removeBody(leftW)
    physics.removeBody(topW)
    physics.removeBody(floor)
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeLevel1()

    -- make character visible again
    character.isVisible = true
    
    if (questionsAnswered > 0) then
        if (theMathPuzzle ~= nil) and (theMathPuzzle.isBodyActive == true) then
            physics.removeBody(theMathPuzzle)
            theMathPuzzle.isVisible = false
        end
    end
      
    if (questionsAnswered > 0) then
        if (theFinalBoss ~= nil) and (theFinalBoss.isBodyActive == true) then
            physics.removeBody(theFinalBoss)
            theFinalBoss.isVisible = false
        end
    end

    UpdateHearts()
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level1ScreenFinnL@2x.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentWidth / 2 
    bkg_image.y = display.contentHeight / 2

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    
    
    -- Insert the platforms
    platform1 = display.newImageRect("Images/PlatformValentina@2x.png", 250, 50)
    platform1.x = 100
    platform1.y = 500
        
    sceneGroup:insert( platform1 )

  
    platform2 = display.newImageRect("Images/PlatformValentina@2x.png", 150, 50)
    platform2.x = 300
    platform2.y = 341
        
    sceneGroup:insert( platform2 )

    platform3 = display.newImageRect("Images/PlatformValentina@2x.png", 280, 50)
    platform3.x = 890
    platform3.y = 200
    platform3.MyName = "platformWin"
        
    sceneGroup:insert( platform3 )

    platform4 = display.newImageRect("Images/PlatformValentina@2x.png", 180, 50)
    platform4.x = display.contentWidth *3 / 5
    platform4.y = display.contentHeight * 3.5 / 5

    sceneGroup:insert( platform4 )

    platform5 = display.newImageRect("Images/PlatformValentina@2x.png", 100, 50)
    platform5.x = 600
    platform5.y = 241

    sceneGroup:insert( platform5 )

    spikes1 = display.newImageRect("Images/Level-1Spikes1.png", 250, 50)
    spikes1.x = display.contentWidth * 3 / 8
    spikes1.y = 550
    spikes1.myName = "spikes1"
        
    sceneGroup:insert( spikes1)

    spikes2 = display.newImageRect("Images/Level-1Spikes1.png", 250, 50)
    spikes2.x = 850
    spikes2.y = 550
    spikes2.myName = "spikes2"
        
    sceneGroup:insert( spikes2)

    spikes1platform = display.newImageRect("Images/PlatformValentina@2x.png", 250, 50)
    spikes1platform.x = display.contentWidth * 3 / 8
    spikes1platform.y = 600
        
    sceneGroup:insert( spikes1platform)


    -- Insert the Hearts
    heart1 = display.newImageRect("Images/heart.png", 80, 80)
    heart1.x = 50
    heart1.y = 50
    heart1.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart1 )

    heart2 = display.newImageRect("Images/heart.png", 80, 80)
    heart2.x = 130
    heart2.y = 50
    heart2.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart2 )

    heart3 = display.newImageRect("Images/heart.png", 80, 80)
    heart3.x = 210
    heart3.y = 50
    heart3.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart3 )

    --Insert the right arrow
    rArrow = display.newImageRect("Images/RightArrowUnpressed.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rArrow)

    --Insert the left arrow
    lArrow = display.newImageRect("Images/LeftArrowUnpressed.png", 100, 50)
    lArrow.x = display.contentWidth * 7.5 / 10
    lArrow.y = display.contentHeight * 9.5 / 10
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( lArrow)

    --Insert the left arrow
    uArrow = display.newImageRect("Images/UpArrowUnpressed.png", 50, 100)
    uArrow.x = display.contentWidth * 8.35 / 10
    uArrow.y = display.contentHeight * 8.5 / 10

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( uArrow)

    --WALLS--
    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( leftW )

    rightW = display.newLine( 0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rightW )

    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topW )

    floor = display.newImageRect("Images/Level-1Floor.png", 1024, 100)
    floor.x = display.contentCenterX
    floor.y = display.contentHeight * 1.06
    
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( floor )

    --mathPuzzle1
    mathPuzzle1 = display.newImageRect ("Images/mathMonster.png", 70, 70)
    mathPuzzle1.x = 600
    mathPuzzle1.y = 471
    mathPuzzle1.myName = "mathPuzzle1"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( mathPuzzle1 )

    --mathPuzzle2
    mathPuzzle2 = display.newImageRect ("Images/mathMonster.png", 70, 70)
    mathPuzzle2.x = 300
    mathPuzzle2.y = 270
    mathPuzzle2.myName = "mathPuzzle2"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( mathPuzzle2 )

    --mathPuzzle3
    mathPuzzle3 = display.newImageRect ("Images/mathMonster.png", 70, 70)
    mathPuzzle3.x = 600
    mathPuzzle3.y = 170
    mathPuzzle3.myName = "mathPuzzle3"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( mathPuzzle3 )

 --mathPuzzle3
    finalBoss = display.newImageRect ("Images/FinalBossFinnL@2x.png", 100, 100)
    finalBoss.x = 840
    finalBoss.y = 140
    finalBoss.myName = "theBoss"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( finalBoss )

 --theGlow
    theGlow = display.newImageRect ("Images/GlowBall.png", 100, 100)
    theGlow.x = 950
    theGlow.y = 100
    theGlow.myName = "theGlow"


    sceneGroup:insert( theGlow )


    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth * 2 / 24,
        y = display.contentHeight * 15 / 17,

        -- Setting Dimensions
         width = 100,
         height = 100,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressedFinnL.png",
        overFile = "Images/BackButtonPressedFinnL.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )
    
end --function scene:create( event )


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
        -- start physics
        physics.start()

        -- set gravity
        physics.setGravity( 0, GRAVITY ) 


       


    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.


        -- make all soccer balls visible
        MakeMathPuzzlesVisible()

        -- make all lives visible
        MakeHeartsVisible()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- create the character, add physics bodies and runtime listeners
        ReplaceCharacter()

        MakeFinalBossVisible()

        MakeTheGlowVisible()

        backgroundSoundChannel = audio.play(backgroundSound, { channel=1, loops=-1 } )

       -- Character()
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

        --stop the music
        audio.stop(backgroundSoundChannel)
        RemoveCollisionListeners()
        RemovePhysicsBodies()
        display.remove(character)
        
        physics.stop()
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()


     -----------------------------------------------------------------------------------------
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        
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