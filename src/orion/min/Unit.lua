local __config__ = require('orion.min.config')

local Object = require('orion.min.Object')

-- @class
local Unit = {

    -- @only_read string
    __class = 'Unit',

    -- @only_read string
    __namespace = __config__.__namespace,

    -- @override
    -- @return string
    __tostring = function(self)
        return 'orion.Unit'
    end
}

return __config__.__class:create(Unit, Object.template)
