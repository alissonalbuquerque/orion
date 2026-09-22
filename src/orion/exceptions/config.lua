local __config__ = {}

    __config__.__namespace = 'orion.exceptions'
    __config__.__modules   = {'TypeError', 'ValueError', 'TryCatchException'}
    __config__.__package   = require('orion.core.Package')
    __config__.__class     = require('orion.core.Class')

return __config__

