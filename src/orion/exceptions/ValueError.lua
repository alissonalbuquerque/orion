local __config__ = require('orion.exceptions.config')
local Exception  = require('orion.lang.Exception')

-- @class
local ValueError = {

    __class = 'ValueError',

    __namespace = __config__.__namespace,

    -- @param any value
    -- @param string message
    __construct = function(self, value, message)
        self.message = ("invalid value '%s'%s"):format(
            value,
            message ~= nil and (": %s"):format(message) or ""
        )
    end,

    -- @throws error by built-in Lua error function.
    throw = function(self)
        error(("%s: %s"):format(self:class_name(), self:get_message()))
    end
}

return __config__.__class:create(ValueError, Exception.template)