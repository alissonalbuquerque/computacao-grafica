-----------------------------------------------------------------------------------------
--
-- Page Page5
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

local scale_default = 0.3
local filename = 'views/Page5/interations/heart.png'
local heart, heart_x, heart_y = nil, Dimension.centerX, 650

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

    if scale_default == 0.4 then
        scale_default = scale_default - 0.1
        target.xScale, target.yScale = scale_default, scale_default
    else
        scale_default = scale_default + 0.1
        target.xScale, target.yScale = scale_default, scale_default
    end

end

-----------------------------------------------------------------------------------------

-- @param event : Object<event>
-- @return void
function scene:create(event)

    local sceneGroup = self.view

    local params = event.params or {}

    local page_image = display.newImage(sceneGroup, 'views/Page5/index.png')
    page_image.x = Dimension.centerX
    page_image.y = Dimension.centerY

    btn_audio_off = AudioOff.create({ scene_group = sceneGroup })
    btn_audio_on  = AudioOn.create({ scene_group = sceneGroup })

    audio_player = AudioPlayer.new({path_audio_file = 'views/Page5/audio/audio.mp3'})

    local btn_back = ButtonBackPage.create({ scene_group = sceneGroup, path_back_page = 'views.Page4.index', audio_player = audio_player })
    local btn_next = ButtonNextPage.create({ scene_group = sceneGroup, path_next_page = 'views.Page6.index', audio_player = audio_player })

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
    heart = create_image(scene_group, heart_x, heart_y, scale_default, filename)
        
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

        heart:addEventListener('tap', tap_object)

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
        
        heart:removeEventListener('tap', tap_object)

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
