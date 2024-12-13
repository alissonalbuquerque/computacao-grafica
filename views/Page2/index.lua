-----------------------------------------------------------------------------------------
--
-- Page Page2
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

local atom_hidrogen_left , atom_hidrogen_left_x , atom_hidrogen_left_y  = nil, 250, 550

local atom_hidrogen_right, atom_hidrogen_right_x, atom_hidrogen_right_y = nil, 150, 550

local atom_oxygen, atom_oxygen_x, atom_oxygen_y = nil, 200, 650

local atom_oxygen_a, atom_oxygen_a_x, atom_oxygen_a_y = nil, 200, 650

local atom_oxygen_b, atom_oxygen_b_x, atom_oxygen_b_y = nil, 200, 650

local function move_object(event)

    if event.phase == "began" then
        
        display.getCurrentStage():setFocus(event.target)
        event.target.isFocus = true

        event.target.touchOffsetX = event.x - event.target.x
        event.target.touchOffsetY = event.y - event.target.y

    elseif event.phase == "moved" and event.target.isFocus then
        
        event.target.x = event.x - event.target.touchOffsetX
        event.target.y = event.y - event.target.touchOffsetY

    elseif event.phase == "ended" or event.phase == "cancelled" then
        
        if event.target.isFocus then
            display.getCurrentStage():setFocus(nil)
            event.target.isFocus = false
        end

    end

    return true

end

-----------------------------------------------------------------------------------------

-- @param event : Object<event>
-- @return void
function scene:create(event)

    local sceneGroup = self.view

    local page_image = display.newImage(sceneGroup, 'views/Page2/index.png')
    page_image.x = Dimension.centerX
    page_image.y = Dimension.centerY

    btn_audio_on  = AudioOn.create({ scene_group = sceneGroup })
    btn_audio_off = AudioOff.create({ scene_group = sceneGroup })

    audio_player = AudioPlayer.new({path_audio_file = 'views/Page2/audio/audio.mp3'})

    local btn_back = ButtonBackPage.create({ scene_group = sceneGroup, path_back_page = 'views.Page1.index', audio_player = audio_player })
    local btn_next = ButtonNextPage.create({ scene_group = sceneGroup, path_next_page = 'views.Page3.index', audio_player = audio_player })

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

    -- INTERATIONS IN VIEW

    local scene_group = sceneGroup

        atom_hidrogen_right = display.newImage(scene_group, 'views/Page2/interations/atom_hidrogen_right.png')
        atom_hidrogen_right.x = atom_hidrogen_right_x
        atom_hidrogen_right.y = atom_hidrogen_right_y

        atom_hidrogen_left = display.newImage(scene_group, 'views/Page2/interations/atom_hidrogen_left.png')
        atom_hidrogen_left.x = atom_hidrogen_left_x
        atom_hidrogen_left.y = atom_hidrogen_left_y

        atom_oxygen = display.newImage(scene_group, 'views/Page2/interations/atom_oxygen.png')
        atom_oxygen.x = atom_oxygen_x
        atom_oxygen.y = atom_oxygen_y

        atom_oxygen_a = display.newImage(scene_group, 'views/Page2/interations/atom_oxygen.png')
        atom_oxygen_a.x = atom_oxygen_x
        atom_oxygen_a.y = atom_oxygen_y

        atom_oxygen_b = display.newImage(scene_group, 'views/Page2/interations/atom_oxygen.png')
        atom_oxygen_b.x = atom_oxygen_x
        atom_oxygen_b.y = atom_oxygen_y
end

-- @param event : Object<event>
-- @return void
function scene:show(event)

    local sceneGroup = self.view

    local phase = event.phase

    if (phase == "will") then

        -- Inicialize objetos e faça transições antes de mostrar a cena

        local atom_hidrogen_left_x , atom_hidrogen_left_y  = 250, 550
        local atom_hidrogen_right_x, atom_hidrogen_right_y = 150, 550

        local atom_oxygen_x, atom_oxygen_y     = 200, 650

            atom_hidrogen_left.x, atom_hidrogen_left.y   = atom_hidrogen_left_x, atom_hidrogen_left_y
            atom_hidrogen_right.x, atom_hidrogen_right.y = atom_hidrogen_right_x, atom_hidrogen_right_y

            atom_oxygen.x, atom_oxygen.y     = atom_oxygen_x, atom_oxygen_y
            atom_oxygen_a.x, atom_oxygen_a.y = atom_oxygen_x, atom_oxygen_y
            atom_oxygen_b.x, atom_oxygen_b.y = atom_oxygen_x, atom_oxygen_y

        btn_audio_on.isVisible = false
        btn_audio_on.isEnabled = false

        btn_audio_off.isVisible = true
        btn_audio_off.isEnabled = true

        audio_player:volumeOff()

        audio_player:stop()
        
    elseif (phase == "did") then
        -- Lógica para quando a cena é mostrada
        audio_player:play()

        atom_hidrogen_right:addEventListener('touch', move_object)
        atom_hidrogen_left:addEventListener('touch', move_object)
        atom_oxygen:addEventListener('touch', move_object)
        atom_oxygen_a:addEventListener('touch', move_object)
        atom_oxygen_b:addEventListener('touch', move_object)
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
        atom_hidrogen_right:removeEventListener('touch', move_object)
        atom_hidrogen_left:removeEventListener('touch', move_object)
        atom_oxygen:removeEventListener('touch', move_object)
        atom_oxygen_a:removeEventListener('touch', move_object)
        atom_oxygen_b:removeEventListener('touch', move_object)
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
