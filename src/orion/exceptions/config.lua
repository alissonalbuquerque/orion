local __config__ = {}

    __config__.__namespace = 'orion.exceptions'
    __config__.__modules   = {'TryCatchException', 'TypeError', 'ValueError'}
    __config__.__package   = require('orion.core.Package')
    __config__.__class     = require('orion.core.Class')

return __config__
