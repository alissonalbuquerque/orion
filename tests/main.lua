package.path = table.concat({
    package.path,
    './src/?.lua',
    './src/?/init.lua',

    '../src/?.lua',
    '../src/?/init.lua'
}, ';')


local PkgLang = require('orion.lang')
local Package = require('orion.core.Package')

local ValueError = require('orion.exceptions.ValueError')
local TryCatch, Exception, RuntimeException = Package.import(PkgLang, 'TryCatch', 'Exception', 'RuntimeException')

TryCatch.new({
    path = "tests/file.txt",
    file = nil,
    content = nil
})
:try(function(res)
    res.file = io.open(res.path, "r")
    res.content = res.file:read("*a")

    -- error('Teste de Error')
    -- res:throw(Exception, "Exception !!!")
    -- ValueError.new('20', 'Expected string or boolean'):throw()
end)
:catch(ValueError, function(res) 

end)
:catch(RuntimeException, function(res)
    
end)
:catch(Exception, function(res)

end)
:finally(function(res)
    res.file:close()
end)
:execute()
