local __config__ = {}

    __config__.__namespace = 'orion.lang'
    __config__.__modules   = {'AbstractClass', 'Case', 'Enum', 'Exception', 'Object', 'RuntimeException', 'TryCatch', 'Types', 'Unit', 'Values'}
    __config__.__package   = require('orion.core.Package')
    __config__.__class     = require('orion.core.Class')
    
return __config__
