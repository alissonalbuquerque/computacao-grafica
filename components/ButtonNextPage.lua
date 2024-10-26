
-- @local Button : Table
local Button = require('components.Button')

-- @local Dimension : Table
local Dimension = require('utils.display.Dimension')

-- @local GotoScene : Table
local GotoScene = require('utils.composer.GotoScene')

-- @local composer : Table
local composer = require('composer')

--@local ButtonNextPage : Table
local ButtonNextPage = {

    --[[
        @param _options : Table
            _options['scene_group'] is required
            _options['path_next_page'] is required
            _options['audio_player'] is optional
            _options['effect'] is optional with default = GotoScene.EFFECT_SLIDE_LEFT
            _options['time'] is optional with default = nil
            _options['params'] is options with default = nil

        @return object<WidgetButton>
    --]]

    create = function(_options)

        local _attribute_options =
            {   
                scene_group     = _options['scene_group'],
                audio_player    = _options['audio_player'] or nil,
                path_next_page  = _options['path_next_page'],
                effect          = _options['effect']     or GotoScene.EFFECT_SLIDE_LEFT,
                time            = _options['time']       or nil,
                params          = _options['params']     or {},
            }

        local options =
            {
                id = 'btn-next-page',
                overFile = "assets/btn_next.png",
                defaultFile = "assets/btn_next.png",

                x = Dimension.BTN_NEXT_X,
                y = Dimension.BTN_NEXT_Y,
                
                onRelease = function(event)

                    if(_attribute_options['audio_player'] ~= nil) then
                        _attribute_options['audio_player']:stop()
                    end

                    composer.gotoScene(_attribute_options['path_next_page'], {
                        effect  = _attribute_options['effect'],
                        time    = _attribute_options['time'],
                        params  = _attribute_options['params']
                    });

                end,
            }

        local button_next_page = Button.create(options)

        _attribute_options['scene_group']:insert(button_next_page)

        return button_next_page
    end
    
}

return ButtonNextPage
