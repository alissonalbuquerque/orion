local __config__ = require('orion.types.config')
local Object     = require('orion.lang.Object')
local Types      = require('orion.lang.Types')
local TypeError  = require('orion.exceptions.TypeError')

-- @class
local String = {

    -- @only_read string
    __class = 'String',

    -- @only_read string
    __namespace = __config__.__namespace,

    -- @param string value
    __construct = function(self, value)
        self:__validate(value)
        self.value = value
    end,

    -- @param string
    -- @return Unit
    __validate = function(self, value)
        local received = Types:type(value)
        local expected = Types.STRING

        if Types:not_equals(expected, received) then
            TypeError.new(("%s"):format(expected, received)):throw()
        end
        
        return Unit
    end,

    -- @param Object other
    -- @return boolean
    equals = function(self, other)
        return Types:equals(Types:class(self), Types:class(other)) and (self.value == other.value) -- alter
    end,

    -- @return integer
    hash_code = function(self)
        local hash = 0
        local value = self.value

        for i = 1, string.len(value) do
            hash = hash * 31 + string.byte(value, i)
            hash = hash & 0xFFFFFFFF
        end

        hash = hash >= 0x80000000 and hash - 0x100000000 or hash

        return hash -- verificar os padrões aceitos a partir do string e utf8
    end,

    -- @return string
    get_value = function(self)
        return self.value
    end,

    -- @return self
    upper = function(self)
        return self
    end,

    -- @return self
    lower = function(self)
        return self
    end,

    -- @return self
    format = function(self, ...)
        self.value = string.format(self.value, ...)
        return self
    end,

    -- @return boolean
    is_empty = function(self)
        return self:len() == 0
    end,

    -- @return integer
    len = function(self)
        return utf8.len(self.value)
    end,

    -- @override
    -- @return string
    __tostring = function(self)
        return tostring(self.value)
    end
}

return __config__.__class:create(String, __config__.__object.template)
