-----------------------------------------------------------------------------------------
--
-- Page Page1
--
-----------------------------------------------------------------------------------------

-- @local composer : Table
local composer = require('composer')

-- @local audio : Table
local audio = require('audio')

-- @local Dimension : Table
local Dimension = require('utils.display.Dimension')

-- @local ButtonNextPage : Table
local ButtonNextPage = require('components.ButtonNextPage')

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

-- @param event : Object<event>
-- @return void
function scene:create(event)

    local sceneGroup = self.view

    local page_image = display.newImage(sceneGroup, 'views/Page1/index.png')
    page_image.x = Dimension.centerX
    page_image.y = Dimension.centerY

    btn_audio_on  = AudioOn.create({ scene_group = sceneGroup })
    btn_audio_off = AudioOff.create({ scene_group = sceneGroup })
    
    audio_player = AudioPlayer.new({path_audio_file = 'views/Page1/audio/audio.mp3'})

    local btn_next = ButtonNextPage.create({ scene_group = sceneGroup, path_next_page = 'views.Page2.index', audio_player = audio_player })

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

end

-- @param event : Object<event>
-- @return void
function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    local enable_audio = composer.getVariable('enable_audio')

    if (phase == "will") then

        btn_audio_on.isVisible = false
        btn_audio_on.isEnabled = false

        btn_audio_off.isVisible = true
        btn_audio_off.isEnabled = true

        audio_player:volumeOff()
        
        audio_player:stop()

    elseif (phase == "did") then

        audio_player:play()

    end

end

-- @param event : Object<event>
-- @return void
function scene:hide(event)

    local sceneGroup = self.view

    local phase = event.phase

    if (phase == "will") then

        print('teste')

    elseif (phase == "did") then

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
