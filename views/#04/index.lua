-----------------------------------------------------------------------------------------
--
-- Page #04
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

local btn_back      = nil

local btn_next      = nil

-----------------------------------------------------------------------------------------

local image_initial_path = 'views/#04/interations/image_initial.png'
local image_final_path   = 'views/#04/interations/image_final.png'

local image_initial_scale = 1.0
local image_initial, image_initial_x, image_initial_y = nil, Dimension.centerX, 700

local create_image = function(scene_group, x, y, scale, filename)
    local image = display.newImage(scene_group, filename)
        image.x = x
        image.y = y
        image:scale(scale, scale)
        image.isVisible = true
    return image
end

local zoom_in = function(event)
    
end
-----------------------------------------------------------------------------------------

-- @param event : Object<event>
-- @return void
function scene:create(event)

    local sceneGroup = self.view

    local params = event.params or {}

    local page_image = display.newImage(sceneGroup, 'views/#04/index.png')
          page_image.x = Dimension.centerX
          page_image.y = Dimension.centerY

        btn_audio_on  = AudioOn.create({ scene_group = sceneGroup })
        btn_audio_off = AudioOff.create({ scene_group = sceneGroup })

        audio_player = AudioPlayer.new({path_audio_file = 'views/#04/audio/audio.mp3'})

        btn_back = ButtonBackPage.create({ scene_group = sceneGroup, path_back_page = 'views.#03.index', audio_player = audio_player, params = params })
        btn_next = ButtonNextPage.create({ scene_group = sceneGroup, path_next_page = 'views.#05.index', audio_player = audio_player, params = params })

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

    image_initial = create_image(scene_group, image_initial_x, image_initial_y, image_initial_scale, image_initial_path)
    
    -----------------------------------------------------------------------------------------
end

-- @param event : Object<event>
-- @return void
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        
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
