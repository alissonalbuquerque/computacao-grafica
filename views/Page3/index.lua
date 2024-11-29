-----------------------------------------------------------------------------------------
--
-- Page Page3
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

local btn_back = nil

local btn_next = nil

-----------------------------------------------------------------------------------------

local celula, celula_x, celula_y = nil, Dimension.centerX, 600
local celula_scale = 2.0

local apendice_scale = 2.5
local apendice_membrana_plamatica_scale = 1.0

local nucleo_filename    = 'views/Page3/interations/nucleo.png'
local centriolo_filename = 'views/Page3/interations/centriolo.png'
local lisossomo_filename = 'views/Page3/interations/lisossomo.png'
local ribossomo_one_filename      = 'views/Page3/interations/ribossomo_one.png'
local membrana_plamatica_filename = 'views/Page3/interations/membrana_plamatica.png'
local mitocondria_one_filename    = 'views/Page3/interations/mitocondria_one.png'
local reticulo_endoplasmatico_one_filename    = 'views/Page3/interations/reticulo_endoplasmatico_one.png'
local reticulo_endoplasmatico_rugoso_filename = 'views/Page3/interations/reticulo_endoplasmatico_rugoso.png'

local nucleo, nucleo_x, nucleo_y = nil, 100, 500

local centriolo, centriolo_x, centriolo_y = nil, 250, 500

local lisossomo, lisossomo_x, lisossomo_y = nil, 400, 500

local ribossomo_one, ribossomo_one_x, ribossomo_one_y = nil, 550, 500

local mitocondria_one, mitocondria_one_x, mitocondria_one_y = nil, 700, 500

local reticulo_endoplasmatico_one, reticulo_endoplasmatico_one_x, reticulo_endoplasmatico_one_y = nil, 250, 700

local reticulo_endoplasmatico_rugoso, reticulo_endoplasmatico_rugoso_x, reticulo_endoplasmatico_rugoso_y = nil, 400, 700

local membrana_plamatica, membrana_plamatica_x, membrana_plamatica_y = nil, 600, 700

-----------------------------------------------------------------------------------------

local create_celula = function(scene_group, x, y, scale)
    local image = display.newImage(scene_group, 'views/Page3/interations/celula.png')
        image.x = x
        image.y = y
        image:scale(scale, scale)
    return image
end

local create_apendice = function(scene_group, x, y, scale, filename)
    local image = display.newImage(scene_group, filename)
        image.x = x
        image.y = y
        image:scale(scale, scale)
        image.isVisible = false
    return image
end

local set_apendices_visible = function()
    nucleo.isVisible = true
    centriolo.isVisible = true
    lisossomo.isVisible = true
    ribossomo_one.isVisible = true
    mitocondria_one.isVisible = true
    membrana_plamatica.isVisible = true
    reticulo_endoplasmatico_one.isVisible = true
    reticulo_endoplasmatico_rugoso.isVisible = true
end

local set_apendices_invisible = function()
    nucleo.isVisible = false
    centriolo.isVisible = false
    lisossomo.isVisible = false
    ribossomo_one.isVisible = false
    mitocondria_one.isVisible = false
    membrana_plamatica.isVisible = false
    reticulo_endoplasmatico_one.isVisible = false
    reticulo_endoplasmatico_rugoso.isVisible = false
end

local tap_object = function (event)
    
    local target = event.target

    celula_scale = celula_scale + 0.1

    local audio_player = AudioPlayer.new({path_audio_file = 'views/Page3/audio/pop.mp3'})

    if(celula_scale > 2.5) then

        audio_player:play()

        target:removeSelf()

        set_apendices_visible()
    else
        target.xScale = celula_scale
        target.yScale = celula_scale
    end 

end

-----------------------------------------------------------------------------------------

-- @param event : Object<event>
-- @return void
function scene:create(event)

    local sceneGroup = self.view

    local page_image = display.newImage(sceneGroup, 'views/Page3/index.png')
          page_image.x = Dimension.centerX
          page_image.y = Dimension.centerY

        btn_audio_on  = AudioOn.create({ scene_group = sceneGroup })
        btn_audio_off = AudioOff.create({ scene_group = sceneGroup })

        audio_player = AudioPlayer.new({path_audio_file = 'views/Page3/audio/audio.mp3'})

        btn_back = ButtonBackPage.create({ scene_group = sceneGroup, path_back_page = 'views.Page2.index', audio_player = audio_player })
        btn_next = ButtonNextPage.create({ scene_group = sceneGroup, path_next_page = 'views.Page4.index', audio_player = audio_player })

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

        celula_scale = 2.0
        celula = create_celula(scene_group, celula_x, celula_y, celula_scale)

        nucleo = create_apendice(scene_group, nucleo_x, nucleo_y, apendice_scale, nucleo_filename)

        centriolo = create_apendice(scene_group, centriolo_x, centriolo_y, apendice_scale, centriolo_filename)
        lisossomo = create_apendice(scene_group, lisossomo_x, lisossomo_y, apendice_scale, lisossomo_filename)

        ribossomo_one = create_apendice(scene_group, ribossomo_one_x, ribossomo_one_y, apendice_scale, ribossomo_one_filename)
        mitocondria_one = create_apendice(scene_group, mitocondria_one_x, mitocondria_one_y, apendice_scale, mitocondria_one_filename)

        membrana_plamatica = create_apendice(scene_group, membrana_plamatica_x, membrana_plamatica_y, apendice_membrana_plamatica_scale, membrana_plamatica_filename)
        reticulo_endoplasmatico_one = create_apendice(scene_group, reticulo_endoplasmatico_one_x, reticulo_endoplasmatico_one_y, apendice_scale, reticulo_endoplasmatico_one_filename)

        reticulo_endoplasmatico_rugoso = create_apendice(scene_group, reticulo_endoplasmatico_rugoso_x, reticulo_endoplasmatico_rugoso_y, apendice_scale, reticulo_endoplasmatico_rugoso_filename)
        
    -----------------------------------------------------------------------------------------

end

-- @param event : Object<event>
-- @return void
function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

        celula_x, celula_y = Dimension.centerX, 600

        celula_scale_x, celula_scale_y = 2.0, 2.0

        audio_player:volumeOff()

        audio_player:stop()

    elseif (phase == "did") then

        celula:addEventListener('tap', tap_object)

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

        celula = nil
        celula_scale = 2.0
        celula = create_celula(scene_group, celula_x, celula_y, celula_scale)

        set_apendices_invisible()

        celula:removeEventListener('tap', tap_object)

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
