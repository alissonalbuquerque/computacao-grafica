-----------------------------------------------------------------------------------------
--
-- Page #03
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

local celula, celula_x, celula_y = nil, Dimension.centerX, 600

local nucleo, nucleo_x, nucleo_y          = nil, 100, 500

local centriolo, centriolo_x, centriolo_y = nil, 250, 500

local lisossomo, lisossomo_x, lisossomo_y = nil, 400, 500

local ribossomo_one, ribossomo_one_x, ribossomo_one_y = nil, 550, 500

local mitocondria_one, mitocondria_one_x, mitocondria_one_y = nil, 700, 500

local reticulo_endoplasmatico_one, reticulo_endoplasmatico_one_x, reticulo_endoplasmatico_one_y = nil, 250, 700

local reticulo_endoplasmatico_rugoso, reticulo_endoplasmatico_rugoso_x, reticulo_endoplasmatico_rugoso_y = nil, 400, 700

local membrana_plamatica, membrana_plamatica_x, membrana_plamatica_y = nil, 600, 700

local function accelerometer_object(event)

    -- Dados do acelerômetro
    local xGravity = event.xGravity  -- Movimento no eixo X (-1.0 a 1.0)
    local yGravity = event.yGravity  -- Movimento no eixo Y (-1.0 a 1.0)
    local zGravity = event.zGravity  -- Movimento no eixo Z (-1.0 a 1.0)

    -- Saída no console para teste
    print("x: " .. xGravity, "y: " .. yGravity, "z: " .. zGravity)

    -- Exemplo: mover um objeto com o acelerômetro
    -- if myObject then
    --     myObject.x = display.contentCenterX + (xGravity * 100)
    --     myObject.y = display.contentCenterY + (yGravity * 100)
    -- end

    -- return true

end

local function onAccelerometer(event)
    -- Movimentos simulados com teclas
    myObject.x = myObject.x + (event.xGravity * 10)
    myObject.y = myObject.y + (event.yGravity * 10)

    -- Limitar o objeto dentro da tela
    myObject.x = math.max(0, math.min(display.contentWidth, myObject.x))
    myObject.y = math.max(0, math.min(display.contentHeight, myObject.y))
end

-----------------------------------------------------------------------------------------

-- @param event : Object<event>
-- @return void
function scene:create(event)

    local sceneGroup = self.view

    local page_image = display.newImage(sceneGroup, 'views/#03/index.png')
    page_image.x = Dimension.centerX
    page_image.y = Dimension.centerY

    btn_audio_on  = AudioOn.create({ scene_group = sceneGroup })
    btn_audio_off = AudioOff.create({ scene_group = sceneGroup })

    audio_player = AudioPlayer.new({path_audio_file = 'views/#03/audio/audio.mp3'})

    local btn_back = ButtonBackPage.create({ scene_group = sceneGroup, path_back_page = 'views.#02.index', audio_player = audio_player })
    local btn_next = ButtonNextPage.create({ scene_group = sceneGroup, path_next_page = 'views.#04.index', audio_player = audio_player })

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

    myObject = display.newCircle(display.contentCenterX, display.contentCenterY, 30)
    myObject:setFillColor(0.5, 0.7, 1)

    local scene_group = sceneGroup

        -- celula = display.newImage(scene_group, 'views/#03/interations/celula.png')
        -- celula.x = celula_x
        -- celula.y = celula_y
        -- celula:scale(2.5, 2.5)

        -- nucleo   = display.newImage(scene_group, 'views/#03/interations/nucleo.png')
        -- nucleo.x = nucleo_x
        -- nucleo.y = nucleo_y
        -- nucleo:scale(2.5, 2.5)

        -- centriolo   = display.newImage(scene_group, 'views/#03/interations/centriolo.png')
        -- centriolo.x = centriolo_x
        -- centriolo.y = centriolo_y
        -- centriolo:scale(2.5, 2.5)

        -- lisossomo   = display.newImage(scene_group, 'views/#03/interations/lisossomo.png')
        -- lisossomo.x = lisossomo_x
        -- lisossomo.y = lisossomo_y
        -- lisossomo:scale(2.5, 2.5)

        -- membrana_plamatica   = display.newImage(scene_group, 'views/#03/interations/membrana_plamatica.png')
        -- membrana_plamatica.x = membrana_plamatica_x
        -- membrana_plamatica.y = membrana_plamatica_y
        -- membrana_plamatica:scale(1, 1)

        -- mitocondria_one   = display.newImage(scene_group, 'views/#03/interations/mitocondria_one.png')
        -- mitocondria_one.x = mitocondria_one_x
        -- mitocondria_one.y = mitocondria_one_y
        -- mitocondria_one:scale(2.5, 2.5)

        -- reticulo_endoplasmatico_one   = display.newImage(scene_group, 'views/#03/interations/reticulo_endoplasmatico_one.png')
        -- reticulo_endoplasmatico_one.x = reticulo_endoplasmatico_one_x
        -- reticulo_endoplasmatico_one.y = reticulo_endoplasmatico_one_y
        -- reticulo_endoplasmatico_one:scale(2.5, 2.5)

        -- ribossomo_one   = display.newImage(scene_group, 'views/#03/interations/ribossomo_one.png')
        -- ribossomo_one.x = ribossomo_one_x
        -- ribossomo_one.y = ribossomo_one_y
        -- ribossomo_one.y = ribossomo_one_y
        -- ribossomo_one:scale(2.5, 2.5)

        -- reticulo_endoplasmatico_rugoso   = display.newImage(scene_group, 'views/#03/interations/reticulo_endoplasmatico_rugoso.png')
        -- reticulo_endoplasmatico_rugoso.x = reticulo_endoplasmatico_rugoso_x
        -- reticulo_endoplasmatico_rugoso.y = reticulo_endoplasmatico_rugoso_y
        -- reticulo_endoplasmatico_rugoso:scale(2.5, 2.5)

    -----------------------------------------------------------------------------------------

end

-- @param event : Object<event>
-- @return void
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Inicialize objetos e faça transições antes de mostrar a cena
        audio_player:volumeOff()
        audio_player:stop()

        Runtime:addEventListener("accelerometer", onAccelerometer)

        -- celula:addEventListener('accelerometer', accelerometer_object)

    elseif (phase == "did") then
        -- Lógica para quando a cena é mostrada
        audio_player:play()

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
        -- celula:removeEventListener('accelerometer', accelerometer_object)
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
