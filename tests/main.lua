package.path = table.concat({
    package.path,
    './src/?.lua',
    './src/?/init.lua',

    '../src/?.lua',
    '../src/?/init.lua'
}, ';')


local PkgLang  = require('orion.lang')
local PkgTypes = require('orion.types')
local Package  = require('orion.core.Package')


local ValueError = require('orion.exceptions.ValueError')
local Conversion = require('orion.singleton.Conversion')
local TryCatch, Exception, RuntimeException = Package.import(PkgLang, 'TryCatch', 'Exception', 'RuntimeException')
local Boolean, Float, Integer, Number, Conversion = Package.import(PkgTypes, 'Boolean', 'Float', 'Integer', 'Number')

-- TryCatch.new({
--     path = "tests/file.txt",
--     file = nil,
--     content = nil
-- })
-- :try(function(res)
--     res.file = io.open(res.path, "r")
--     res.content = res.file:read("*a")

--     -- error('Teste de Error')
--     -- res:throw(Exception, "Exception !!!")
--     -- ValueError.new('20', 'Expected string or boolean'):throw()
-- end)
-- :catch(ValueError, function(res) 

-- end)
-- :catch(RuntimeException, function(res)
    
-- end)
-- :catch(Exception, function(res)

-- end)
-- :finally(function(res)
--     res.file:close()
-- end)
-- :execute()
