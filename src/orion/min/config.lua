local __config__ = {}

    __config__.__namespace = 'orion.min'
    __config__.__modules   = {'AbstractClass', 'Exception', 'Object', 'RuntimeException', 'TryCatch', 'Types', 'Unit'}
    __config__.__package   = require('orion.min.Package')
    __config__.__class     = require('orion.min.Class')
    
return __config__
