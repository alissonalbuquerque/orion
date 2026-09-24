local __config__ = {}

    __config__.__namespace = 'orion.types'
    __config__.__modules   = {'Conversion', 'Boolean', 'Float', 'Integer', 'Number'}
    __config__.__package   = require('orion.core.Package')
    __config__.__class     = require('orion.core.Class')

return __config__
