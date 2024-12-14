-----------------------------------------------------------------------------------------
--
-- Page Page4
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

local image_initial_path = 'views/Page4/interations/image_initial.png'
local image_final_path   = 'views/Page4/interations/image_final.png'
local image_zoom_in      = 'views/Page4/interations/lupa_max.png'
local image_zoom_out     = 'views/Page4/interations/lupa_min.png'

local image_scale = 1.0
local image_initial_scale = 1.0

local image_initial, image_initial_x, image_initial_y = nil, Dimension.centerX, 700

local image_final, image_final_x, image_final_y = nil, Dimension.centerX, 700

local btn_zoom_in, btn_zoom_in_x, btn_zoom_in_y = nil, 650, 600

local btn_zoom_out, btn_zoom_out_x, btn_zoom_out_y = nil, 650, 800

local create_image = function(scene_group, x, y, scale, filename)
    local image = display.newImage(scene_group, filename)
        image.x = x
        image.y = y
        image:scale(scale, scale)
        image.isVisible = true
    return image
end

local zoom_in = function(event)

    

    image_initial_scale = image_initial_scale + 0.1

    if image_initial_scale >= 1.5 then
        image_initial_scale = 1.5
    end

    if(image_initial_scale >= 1.4) then
        image_initial.isVisible = false
        image_final.isVisible = true
    else
        image_initial.xScale = image_initial_scale
        image_initial.yScale = image_initial_scale
    end

end

local zoom_out = function(event)

    image_initial_scale = image_initial_scale - 0.1

    if image_initial_scale <= 1.0 then
        image_initial_scale = 1.0
    end

    if image_initial_scale < 1.4 then
        image_final.isVisible = false
        image_initial.isVisible = true

        image_initial.xScale = image_initial_scale
        image_initial.yScale = image_initial_scale
    end
end
-----------------------------------------------------------------------------------------

-- @param event : Object<event>
-- @return void
function scene:create(event)

    local sceneGroup = self.view

    local params = event.params or {}

    local page_image = display.newImage(sceneGroup, 'views/Page4/index.png')
          page_image.x = Dimension.centerX
          page_image.y = Dimension.centerY

        btn_audio_on  = AudioOn.create({ scene_group = sceneGroup })
        btn_audio_off = AudioOff.create({ scene_group = sceneGroup })

        audio_player = AudioPlayer.new({path_audio_file = 'views/Page4/audio/audio.mp3'})

        btn_back = ButtonBackPage.create({ scene_group = sceneGroup, path_back_page = 'views.Page3.index', audio_player = audio_player, params = params })
        btn_next = ButtonNextPage.create({ scene_group = sceneGroup, path_next_page = 'views.Page5.index', audio_player = audio_player, params = params })

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

    image_final  = create_image(scene_group, image_final_x, image_final_y, image_scale, image_final_path)

    btn_zoom_in  = create_image(scene_group, btn_zoom_in_x, btn_zoom_in_y, image_scale, image_zoom_in)

    btn_zoom_out = create_image(scene_group, btn_zoom_out_x, btn_zoom_out_y, image_scale, image_zoom_out)
    
    -----------------------------------------------------------------------------------------
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

        image_final.isVisible = false

        audio_player:volumeOff()
        audio_player:stop()

    elseif (phase == "did") then

        btn_zoom_in:addEventListener('tap', zoom_in)
        btn_zoom_out:addEventListener('tap', zoom_out)

        audio_player:play()
    end
end

-- @param event : Object<event>
-- @return void
function scene:hide(event)
    local scene_group = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then

        image_initial:removeSelf()
        image_initial = nil
        
        image_initial_scale = 1.0

        image_initial = create_image(scene_group, image_initial_x, image_initial_y, image_initial_scale, image_initial_path)
        
        btn_zoom_in:removeEventListener('tap', zoom_in)
        btn_zoom_out:removeEventListener('tap', zoom_out)

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
