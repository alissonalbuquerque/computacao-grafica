
-- @local Button : Table
local Button = require('components.Button')

-- @local Dimension : Table
local Dimension = require('utils.display.Dimension')

-- @local GotoScene : Table
local GotoScene = require('utils.composer.GotoScene')

-- @local composer : Table
local composer = require('composer')

--@local ButtonNextPage : Table
local ButtonBackPage = {

    --[[
        @param _options : Table
            _options['scene_group'] is required
            _options['path_back_page'] is required
            _options['audio_player'] is optional
            _options['effect'] is optional with default = GotoScene.EFFECT_SLIDE_RIGHT
            _options['time'] is optional with default = nil
            _options['params'] is options with default = nil

        @return object<WidgetButton>
    --]]

    create = function(_options)

        local _attribute_options =
            {   
                scene_group     = _options['scene_group'],
                path_back_page  = _options['path_back_page'],
                audio_player    = _options['audio_player'] or nil,
                effect          = _options['effect']     or GotoScene.EFFECT_SLIDE_RIGHT,
                time            = _options['time']       or nil,
                params          = _options['params']     or {},
            }

        local options =
            {
                id = 'btn-back-page',
                overFile = "assets/btn_back_default.png",
                defaultFile = "assets/btn_back_default.png",

                x = Dimension.sliceWidth(7), -- proportion 1/7 from width
                y = Dimension.decrementHeight(Dimension.sliceHeight(10)), -- decrement proportion 1/10 from height
                
                onRelease = function()

                    if(_attribute_options['audio_player'] ~= nil) then
                        _attribute_options['audio_player']:stop()
                    end

                    composer.gotoScene(_attribute_options['path_back_page'], {
                        effect  = _attribute_options['effect'],
                        time    = _attribute_options['time'],
                        params  = _attribute_options['params']
                    });

                end,
            }

        local button_back_page = Button.create(options)

        _attribute_options['scene_group']:insert(button_back_page)

        return button_back_page
    end
    
}

return ButtonBackPage
