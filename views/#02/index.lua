-----------------------------------------------------------------------------------------
--
-- Page #02
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

local atom_hidrogen_left , atom_hidrogen_left_x , atom_hidrogen_left_y  = nil, 250, 550

local atom_hidrogen_right, atom_hidrogen_right_x, atom_hidrogen_right_y = nil, 150, 550

local function start_movement_hidrogen_left(event)
    atom_hidrogen_left_x = event.x
    atom_hidrogen_left_y = event.y
end

local function start_movement_hidrogen_right(event)
    atom_hidrogen_right_x = event.x
    atom_hidrogen_right_y = event.y
end

local function move_movement_hidrogen_right(event)

    if atom_hidrogen_right_x and atom_hidrogen_right_y then
        
        local movement_x = event.x - atom_hidrogen_right_x
        local movement_y = event.y - atom_hidrogen_right_y

        atom_hidrogen_right.x = atom_hidrogen_right.x + movement_x
        atom_hidrogen_right.y = atom_hidrogen_right.y + movement_x

        atom_hidrogen_right_x = event.x
        atom_hidrogen_right_y = event.y
    end

end

local function stop_movement_hidrogen_right(event)
    atom_hidrogen_right_x, atom_hidrogen_right_y = nil, nil
end

-----------------------------------------------------------------------------------------

-- @param event : Object<event>
-- @return void
function scene:create(event)

    local sceneGroup = self.view

    local page_image = display.newImage(sceneGroup, 'views/#02/index.png')
    page_image.x = Dimension.centerX
    page_image.y = Dimension.centerY

    local btn_audio_off = AudioOff.create({ scene_group = sceneGroup })
    local btn_audio_on = AudioOn.create({ scene_group = sceneGroup })

    -- local audio_player = AudioPlayer.new({path_audio_file = 'assets/level_molecular/audio.mp4'}):play()

    local btn_back = ButtonBackPage.create({ scene_group = sceneGroup, path_back_page = 'views.#01.index', audio_player = audio_player })
    local btn_next = ButtonNextPage.create({ scene_group = sceneGroup, path_next_page = 'views.#03.index', audio_player = audio_player })

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

    -- INTERATIONS IN VIEW

    local scene_group = sceneGroup

    atom_hidrogen_right = display.newImage(scene_group, 'views/#02/interations/atom_hidrogen_right.png')
    atom_hidrogen_right.x = atom_hidrogen_right_x
    atom_hidrogen_right.y = atom_hidrogen_right_y

    -- local atom_hidrogen_left = display.newImage(scene_group, 'views/#02/interations/atom_hidrogen_left.png')
    -- atom_hidrogen_left.x = atom_hidrogen_left_x
    -- atom_hidrogen_left.y = atom_hidrogen_left_y

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

        atom_hidrogen_right:addEventListener('touch', start_movement_hidrogen_right)
        Runtime:addEventListener('touch', move_movement_hidrogen_right)
        Runtime:addEventListener('touch', stop_movement_hidrogen_right)
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
        atom_hidrogen_right:removeEventListener('touch', start_movement_hidrogen_right)
        Runtime:removeEventListener('touch', move_movement_hidrogen_right)
        Runtime:removeEventListener('touch', stop_movement_hidrogen_right)
    end
end

-- @param event : Object<event>
-- @return void
function scene:destroy(event)
    local sceneGroup = self.view
    -- Limpe recursos quando a cena for destruída
end

-- Adicione os Eventos
scene:addEventListener('create', scene)
scene:addEventListener('show', scene)
scene:addEventListener('hide', scene)
scene:addEventListener('destroy', scene)

return scene
