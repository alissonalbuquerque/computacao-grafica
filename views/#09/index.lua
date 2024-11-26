-----------------------------------------------------------------------------------------
--
-- Page #09
--
-----------------------------------------------------------------------------------------

-- @local composer : Table
local composer = require('composer')

-- @local Dimension : Table
local Dimension = require('utils.display.Dimension')

-- @local ButtonBackPage : Table
local ButtonBackPage = require('components.ButtonBackPage')

-- @local ButtonNextPage : Table
local ButtonResetApp = require('components.ButtonResetApp')

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

    local page_image = display.newImage(sceneGroup, 'views/#09/index.png')
    page_image.x = Dimension.centerX
    page_image.y = Dimension.centerY

    btn_audio_off = AudioOff.create({ scene_group = sceneGroup })
    btn_audio_on = AudioOn.create({ scene_group = sceneGroup })

    -- local audio_player = AudioPlayer.new({path_audio_file = 'resources/audio/page01/audio.mp3'})

    local btn_back  = ButtonBackPage.create({ scene_group = sceneGroup, path_back_page = 'views.#08.index', audio_player = audio_player })
    local btn_reset = ButtonResetApp.create({ scene_group = sceneGroup, path_next_page = 'views.#01.index'})

    btn_audio_on:addEventListener("touch", function (event) 

        local _btn_audio_on = event.target
        local _btn_audio_off = btn_audio_off

        -- local _audio_player = audio_player

        _btn_audio_on.isVisible = false;
        _btn_audio_on.isEnabled = false;

        _btn_audio_off.isVisible = true;
        _btn_audio_off.isEnabled = true;

        -- _audio_player:volumeOff()
    end)

    btn_audio_off:addEventListener("touch", function (event) 

        local _btn_audio_on = btn_audio_on
        local _btn_audio_off = event.target

        -- local _audio_player = audio_player

        _btn_audio_on.isVisible = true
        _btn_audio_on.isEnabled = true

        _btn_audio_off.isVisible = false
        _btn_audio_off.isEnabled = false

        -- _audio_player:volumeOn()
    end)

end

-- @param event : Object<event>
-- @return void
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Inicialize objetos e faça transições antes de mostrar a cena
    elseif (phase == "did") then
        -- Lógica para quando a cena é mostrada
    end
end

-- @param event : Object<event>
-- @return void
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Faça preparativos antes de ocultar a cena
    elseif (phase == "did") then
        -- Limpeza após a cena ser ocultada
    end
end

-- @param event : Object<event>
-- @return void
function scene:destroy(event)
    local sceneGroup = self.view
    -- Limpe recursos quando a cena for destruída
end

-- Adicione os ouvintes de cena
scene:addEventListener('create', scene)
scene:addEventListener('show', scene)
scene:addEventListener('hide', scene)
scene:addEventListener('destroy', scene)

return scene
