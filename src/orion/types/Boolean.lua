local __config__ = require('orion.types.config')
local Object     = require('orion.lang.Object')
local Types      = require('orion.lang.Types')
local Unit       = require('orion.singleton.Unit')
local TypeError  = require('orion.exceptions.TypeError')
local ValueError = require('orion.exceptions.ValueError')


-- @class
local Boolean = {

    -- @only_read string
    __class = 'Boolean',

    -- @only_read string
    __namespace = __config__.__namespace,

    -- @param string|boolean value
    __construct = function(self, value)
        self:__validate(value)

        local received  = Types:type(value)
        local bool_dict = {
            ['true'] = true,
            ['false'] = false
        }

        if Types.BOOLEAN == received then 
            self.value = value
        elseif Types.STRING == received then
            self.value = bool_dict[value]
        end
    end,

    -- @param string|boolean value
    -- @return Unit
    __validate = function(self, value)
        local received = Types:type(value)
        local expected = {str = Types.STRING, bool = Types.BOOLEAN}

        if received ~= expected.str and received ~= expected.bool then 
            TypeError.new(("%s or %s"):format(expected.str, expected.bool), received):throw()
        end

        if received == expected.str and value ~= 'true' and value ~= 'false' then
            ValueError.new(value, "Expected 'string' or 'boolean', 'true' or 'false' in value"):throw()
        end

        return Unit
    end,

    -- @param Object other
    -- @return boolean
    equals = function(self, other)
        return Types:class(self) == Types:class(other) and self.value == other.value
    end,

    -- @return integer
    hash_code = function(self)
        return self.value and 1231 or 1237
    end,

    -- @return boolean
    get_value = function(self)
        return self.value
    end,

    -- @return boolean
    is_true = function(self)
        return self.value == true
    end,
    
    -- @return boolean
    is_false = function(self)
        return self.value == false
    end,

    -- @return string
    as_string = function(self)
        return self.value and 'true' or 'false'
    end,

    -- @override
    -- @return string
    __tostring = function(self)
        return tostring(self.value)
    end
}

return __config__.__class:create(Boolean, Object.template)
