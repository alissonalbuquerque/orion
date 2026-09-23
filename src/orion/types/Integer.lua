local __config__ = require('orion.types.config')
local Types      = require('orion.lang.Types')
local Values     = require('orion.lang.Values')
local Unit       = require('orion.singleton.Unit')
local TypeError  = require('orion.exceptions.TypeError')
local ValueError = require('orion.exceptions.ValueError')

-- @class
local Integer = {

    -- @only_read string
    __class = 'Integer',

    -- @only_read string
    __namespace = __config__.__namespace,

    -- @param string|float|integer value
    __construct = function(self, value)
        self:__validate(value)

        local castvalue = Values:to_number(value)

        self.value = castvalue >= 0 and math.floor(value) or math.ceil(value)
    end,

    -- @param string|float|integer value
    -- @return Unit
    __validate = function(self, value)
        local received = Types:type(value)
        local casttype = Types:type(Values:to_number(value))
        local expected = {str = Types.STRING, num = Types.NUMBER}

        if Types:not_equals(expected.str, received) and Types:not_equals(expected.num, received) then
            TypeError.new(("%s or %s"):format(expected.str, expected.num), received):throw()
        end

        if Types:not_equals(expected.num, casttype) then
            ValueError.new(value, "Expected 'string' or 'number' assing to 'number'"):throw()
        end
        
        return Unit
    end,

    -- @param Object other
    -- @return boolean
    equals = function(self, other)
        return Types:equals(Types:class(self), Types:class(other)) and (self.value == other.value)
    end,

    -- @return integer
    hash_code = function(self)
        return self.value
    end,

    -- @return integer
    get_value = function(self)
        return self.value
    end,

    -- @return float
    as_float = function(self)
        return self.value + 0.0
    end,

    -- @return string
    as_string = function(self)
        return tostring(self.value)
    end,

    -- @override
    -- @return string
    __tostring = function(self)
        return tostring(self.value)
    end
}

return __config__.__class:create(Integer, __config__.__object.template)
