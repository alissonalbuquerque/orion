local __config__ = require('orion.types.config')
local Boolean    = require('orion.types.Boolean')
local Float      = require('orion.types.Float')
local Integer    = require('orion.types.Integer')
local Number     = require('orion.types.Number')
-- local String     = require('orion.types.String')

-- @class
local Conversion = {

    -- @only_read string
    __class = 'Conversion',

    -- @only_read string
    __namespace = __config__.__namespace,

    -- @param String object
    -- @return Boolean
    toBoolean = function(self, object)
        return Boolean.new(object:get_value())
    end,

    -- @param String|Integer|Number object
    -- @return Float
    toFloat = function(self, object)
        return Float.new(object:get_value())
    end,

    -- @param String|Float|Number object
    -- @return Integer
    toInteger = function(self, object)
        return Integer.new(object:get_value())
    end,

    -- @param String|Float|Integer object
    -- @return Number
    toNumber = function(self, object)
        return Number.new(object:get_value())
    end

    -- @param Boolean|Integer|Float|Number object
    -- @return String
    -- toString = function(self, object)
    --     return String.new(tostring(object:get_value()))
    -- end
}

return __config__.__class:create(Conversion, __config__.__object.template)
