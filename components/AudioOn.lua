
-- @local Button : Table
local Button = require('components.Button')

-- @local Dimension : Table
local Dimension = require('utils.display.Dimension')

-- @local GotoScene : Table
local GotoScene = require('utils.composer.GotoScene')

-- @local composer : Table
local composer = require('composer')

--@local AudioOn : Table
local AudioOn = {

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
                id = 'btn-audio-on',
                overFile = "assets/btn_on_audio.png",
                defaultFile = "assets/btn_on_audio.png",

                x = Dimension.BTN_AUDIO_X,
                y = Dimension.BTN_AUDIO_Y,
            }

        local button_audio_on = Button.create(options)

        _attribute_options['scene_group']:insert(button_audio_on)

        return button_audio_on
    end
    
}

return AudioOn
