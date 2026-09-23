-- @module
local __config__ = require('orion.exceptions.config')

-- @class Package
local package = __config__.__package.new(__config__.__namespace, __config__.__modules)

return package:load_modules()
