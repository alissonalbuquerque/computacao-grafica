
-- @local Button : Table
local Button = require('components.Button')

-- @local Dimension : Table
local Dimension = require('utils.display.Dimension')

-- @local GotoScene : Table
local GotoScene = require('utils.composer.GotoScene')

-- @local composer : Table
local composer = require('composer')

--@local AudioOff : Table
local AudioOff = {

    --[[
        @param _options : Table
            _options['scene_group'] is required
            _options['audio_player'] is required

        @return object<WidgetButton>
    --]]

    create = function(_options)

        local _attribute_options =
            {
                scene_group = _options['scene_group'],
            }

        local options =
            {
                id = 'btn-audio-off',
                overFile = "assets/audio_off.png",
                defaultFile = "assets/audio_off.png",

                x = Dimension.decrementWidth(Dimension.sliceWidth(7)), -- decrement width in proportion 1/7 from width
                y = Dimension.sliceHeight(15), -- decrement proportion 1/15 from height
            }

        local button_audio_on = Button.create(options)

        _attribute_options['scene_group']:insert(button_audio_on)

        return button_audio_on
    end
    
}

return AudioOff
