local __config__ = require('orion.lang.config')

local Exception = require('orion.lang.Exception')

-- @class
local RuntimeException = {

    -- @only_read string
    __class = 'RuntimeException',

    -- @only_read string
    __namespace = __config__.__namespace,

    -- @param string message
    __construct = function(self, message)
        self.message = message or nil
    end,

    -- @throws error by built-in Lua error function.
    throw = function(self)
        error(("%s: %s"):format(self:class_name(), self:get_message()))
    end
}

return __config__.__class:create(RuntimeException, Exception.template)
