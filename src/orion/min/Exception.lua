local __config__ = require('orion.min.config')

local Object = require('orion.min.Object')

-- @class
local Exception = {

    -- @only_read string
    __class = 'Exception',

    -- @only_read string
    __namespace = __config__.__namespace,

    -- @param string message
    __construct = function(self, message)
        self.message = message or nil
    end,

    -- @return string
    get_message = function(self)
        return self.message
    end,

    -- @throws error by built-in Lua error function.
    throw = function(self)
        error(("%s: %s"):format(self:class_name(), self:get_message()))
    end
}

return __config__.__class:create(Exception, Object.template)
