-----------------------------------------------------------------------------------------
--
-- Page Page6
--
-----------------------------------------------------------------------------------------

-- @local composer : Table
local composer = require('composer')

-- @local Dimension : Table
local Dimension = require('utils.display.Dimension')

-- @local ButtonNextPage : Table
local ButtonNextPage = require('components.ButtonNextPage')

-- @local ButtonBackPage : Table
local ButtonBackPage = require('components.ButtonBackPage')

-- @local AudioOn : Table
local AudioOn = require('components.AudioOn')

-- @local AudioOff : Table
local AudioOff = require('components.AudioOff')

-- @local AudioPlayer : Table
local AudioPlayer = require('utils.audio.AudioPlayer')

-- @local scene : Object<scene>
local scene = composer.newScene()

-----------------------------------------------------------------------------------------

local audio_player  = nil

local btn_audio_on  = nil

local btn_audio_off = nil

-----------------------------------------------------------------------------------------

local scale_respiratory = 1.5
local filename = 'views/Page6/interations/respiratory_system.png'
local respiratory, respiratory_x, respiratory_y = nil, Dimension.centerX, 650

local scale = 0.3

local change_flush = false

local filename_circle_red = 'views/Page6/interations/circle_blue.png'
local filename_circle_blue = 'views/Page6/interations/circle_blue.png'

local circle, circle_x, circle_y = nil, 280, 600

local create_image = function(scene_group, x, y, scale, filename)
    local image = display.newImage(scene_group, filename)
        image.x = x
        image.y = y
        image:scale(scale, scale)
        image.isVisible = true
    return image
end

local tap_object = function (event)
    
    local target = event.target

    if change_flush == false then

        if circle.x <= 380 then

            for x = 1, 200 do
                circle.x = circle.x + 0.1
            end
            
        elseif circle.y <= 700 then
    
            for y = 1, 200 do
                circle.y = circle.y + 0.1
            end
    
        else
            change_flush = true
        end

    end

    if change_flush == true then

        if circle.y > 600 then

            for y = 1, 200 do
                circle.y = circle.y - 0.1
            end
            
        elseif circle.x > 280 then
    
            for y = 1, 200 do
                circle.x = circle.x - 0.1
            end
    
        else
            change_flush = false
        end

    end

end

-----------------------------------------------------------------------------------------

-- @param event : Object<event>
-- @return void
function scene:create(event)

    local sceneGroup = self.view

    local params = event.params or {}

    local page_image = display.newImage(sceneGroup, 'views/Page6/index.png')
    page_image.x = Dimension.centerX
    page_image.y = Dimension.centerY

    btn_audio_off = AudioOff.create({ scene_group = sceneGroup })
    btn_audio_on  = AudioOn.create({ scene_group = sceneGroup })

    audio_player = AudioPlayer.new({path_audio_file = 'views/Page6/audio/audio.mp3'})

    local btn_back = ButtonBackPage.create({ scene_group = sceneGroup, path_back_page = 'views.Page5.index', audio_player = audio_player })
    local btn_next = ButtonNextPage.create({ scene_group = sceneGroup, path_next_page = 'views.Page7.index', audio_player = audio_player })

    btn_audio_on:addEventListener("touch", function (event) 

        local _btn_audio_on = event.target
        local _btn_audio_off = btn_audio_off

        local _audio_player = audio_player

        _btn_audio_on.isVisible = false;
        _btn_audio_on.isEnabled = false;

        _btn_audio_off.isVisible = true;
        _btn_audio_off.isEnabled = true;

        _audio_player:volumeOff()
    end)

    btn_audio_off:addEventListener("touch", function (event) 

        local _btn_audio_on = btn_audio_on
        local _btn_audio_off = event.target

        local _audio_player = audio_player

        _btn_audio_on.isVisible = true
        _btn_audio_on.isEnabled = true

        _btn_audio_off.isVisible = false
        _btn_audio_off.isEnabled = false

        _audio_player:volumeOn()
    end)

    -- INTERATIONS IN VIEW --
    -----------------------------------------------------------------------------------------

    local scene_group = sceneGroup

    respiratory = create_image(scene_group, respiratory_x, respiratory_y, scale_respiratory, filename)

    circle = create_image(scene_group, circle_x, circle_y, scale, filename_circle_blue)
    
end

-- @param event : Object<event>
-- @return void
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        
        btn_audio_on.isVisible = false
        btn_audio_on.isEnabled = false

        btn_audio_off.isVisible = true
        btn_audio_off.isEnabled = true

        audio_player:volumeOff()
        audio_player:stop()

    elseif (phase == "did") then

        respiratory:addEventListener('tap', tap_object)

        audio_player:play()
    end
end

-- @param event : Object<event>
-- @return void
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        
    elseif (phase == "did") then

        respiratory:addEventListener('tap', tap_object)
    end
end

-- @param event : Object<event>
-- @return void
function scene:destroy(event)
    local sceneGroup = self.view
end

-- Adicione os ouvintes de cena
scene:addEventListener('create', scene)
scene:addEventListener('show', scene)
scene:addEventListener('hide', scene)
scene:addEventListener('destroy', scene)

return scene
