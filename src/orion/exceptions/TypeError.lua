local __config__ = require('orion.exceptions.config')
local Exception  = require('orion.lang.Exception')

-- @class
local TypeError = {

    __class = 'TypeError',

    __namespace = __config__.__namespace,

    -- @param string expected
    -- @param string received
    __construct = function(self, expected, received)
        self.message = ("incompatible types: expected '%s', but received '%s'"):format(expected, received)
    end,

    -- @throws error by built-in Lua error function.
    throw = function(self)
        error(("%s: %s"):format(self:class_name(), self:get_message()))
    end
}

return __config__.__class:create(TypeError, Exception.template)
