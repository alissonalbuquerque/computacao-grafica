
-- @local widget : Table
local widget = require('widget')

-- @local Button : Table
local Button = {

    create = function(_options)
        return widget.newButton(_options);
    end
        
}

return Button