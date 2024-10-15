--[[

    Table to generate Number Objects

--]]

local Object = require('utils.onigiri.base.prototype.Object')

-- @table String
local Number = Object.create({

    attributes = {'wrapped_number', 'type'},

    -- @return void
    constructor = function(self, _attributes)

        local wrapped_number = _attributes.wrapped_number or _attributes[1]

        self.attributes.wrapped_number = wrapped_number
        self.attributes.type = Object.type('wrapper.Number')
    end,

    -- @return wrapper.Number
    new = function(self, _constructor)
        return Object.create(self).new(_constructor)
    end,

    -- @return wrapper.Number
    abs = function(self)

        local constructor = {
            math.abs(self:content())
        }

        return self:new(constructor)
    end,

    -- @return wrapper.Number
    ceil = function(self)

        local constructor = {
            math.ceil(self:content())
        }

        return self:new(constructor)
    end,

    -- @return wrapper.Number
    floor = function(self)

        local constructor = {
            math.floor(self:content())
        }

        return self:new(constructor)
    end,

    -- @return wrapper.Number
    round = function(self, digits)

        local digits = digits or 2
        local fmt = string.format("%%.%df", digits)

        local cosntructor = {
            tonumber(string.format(fmt, self:content()))
        }

        return self:new(cosntructor)
    end,

    -- @return number
    content = function(self)
        return self.attributes.wrapped_number
    end,

    -- @return number
    val = function(self)
        return self:content()
    end,

    -- @return string
    gettype = function(self)
        return self.attributes.type
    end,

    -- @return string
    __tostring = function(self)
        return tostring(self:content())
    end
})

return Number
