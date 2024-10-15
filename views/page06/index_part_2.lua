-----------------------------------------------------------------------------------------
--
-- page2.lua
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

-- @local GotoScene : Table
local GotoScene = require('utils.composer.GotoScene')

-- @local AudioOn : Table
local AudioOn = require('components.AudioOn')

-- @local AudioOff : Table
local AudioOff = require('components.AudioOff')

-- @local AudioPlayer : Table
local AudioPlayer = require('utils.audio.AudioPlayer')

-- @local scene : Object<scene>
local scene = composer.newScene()

-----------------------------------------------------------------------------------------

-- @EVENTS
--------------------------------------------------------------------
local startX = 0
local startY = 0

local onTouch = function(event)

    local _attribute_options = {
        path_next_page = "views.page06.index_part_1",
        effect = GotoScene.EFFECT_FADE,
        non_effect = nil
    }

    composer.gotoScene(_attribute_options['path_next_page'], {
        effect  = _attribute_options['effect'],
    });

    return true
end
--------------------------------------------------------------------


-- @param event : Object<event>
-- @return void
function scene:create(event)
    local sceneGroup = self.view

    -- local page_image = display.newImage(sceneGroup, 'views/page06/page_part_2.png')
    -- page_image.x = Dimension.centerX
    -- page_image.y = Dimension.centerY

    local myText = display.newText(sceneGroup, "Implements Trasaction!", 100, 200, native.systemFont, 16 )
    myText:setFillColor( 1, 0, 0 )

    local btn_audio_off = AudioOff.create({ scene_group = sceneGroup })
    local btn_audio_on = AudioOn.create({ scene_group = sceneGroup })

    -- local audio_player = AudioPlayer.new({path_audio_file = 'resources/audio/page01/audio.mp3'}):play()
    local audio_player = nil

    local btn_back = ButtonBackPage.create({ scene_group = sceneGroup, path_back_page = 'views.page05.index'})
    local btn_next = ButtonNextPage.create({ scene_group = sceneGroup, path_next_page = 'views.page07.index'})

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
        Runtime:addEventListener("touch", onTouch)
    end
end

-- @param event : Object<event>
-- @return void
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        Runtime:removeEventListener("touch", onTouch)
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
