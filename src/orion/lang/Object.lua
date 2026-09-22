local __config__ = require('orion.lang.config')

-- @class
local Object = {

    -- @only_read string
    __class = 'Object',

    -- @only_read string
    __namespace = __config__.__namespace,

    -- @return void
    __construct = function(self)

    end,

    -- @return string
    class_name = function(self)
        return ("%s.%s"):format(self.__namespace, self.__class)
    end,

    -- @override
    -- @return string
    __tostring = function(self)
        return __config__.__class:tostring(self)
    end
}

return __config__.__class:create(Object)