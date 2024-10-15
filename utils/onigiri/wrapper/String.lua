--[[

    Table to generate String Objects

--]]

local Object = require('utils.onigiri.base.prototype.Object')


-- @table String
local String = Object.create({

    attributes = {'wrapped_string', 'type'},

    -- @return void
    constructor = function(self, _attributes)

        local wrapped_string = _attributes.wrapped_string or _attributes[1]

        self.attributes.wrapped_string = wrapped_string
        self.attributes.type = Object.type('wrapper.String')
    end,

    -- @return wrapper.String
    new = function(self, _constructor)
        return Object.create(self).new(_constructor)
    end,

    -- @return wrapper.String
    upper = function(self)

        local constructor = {
            string.upper(self:content())
        }
        
        return self:new(constructor)
    end,

    -- @return wrapper.String
    lower = function(self)

        local constructor = {
            string.lower(self:content())
        }

        return self:new(constructor)
    end,

    -- @return wrapper.String
    format = function(self, ...)

        local constructor = {
            string.format(self:content(), table.unpack(...))
        }

        return self:new(constructor)
    end,

    -- @return number
    len = function(self)
        return string.len(self:content())
    end,

    -- @return string
    content = function(self)
        return self.attributes.wrapped_string
    end,

    -- @return string
    gettype = function(self)
        return self.attributes.type
    end,

    -- @return string
    __tostring = function(self)
        return self:content()
    end
})

return String
