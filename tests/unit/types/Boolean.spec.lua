package.path = table.concat({
    package.path,
    './src/?.lua',
    '../../../src/?.lua',
    '../../../../src/?.lua',
}, ';')

-- @Imports
local Boolean = require('orion.types.Boolean')
local Integer = require('orion.types.Integer')

-- @test Boolean.new()
-- @note Os valores aceitos no construtor devem ser true, false, 'true', 'false'
-- @note Qualquer valor fora do escopo associado acima deve retornar uma exception relacionada com erro em tempo de execução

-- @Passes
print('Passes')
print('----------------')
print("Input: true"   , "Output:", Boolean.new(true):get_boolean())
print("Input: false"  , "Output:", Boolean.new(false):get_boolean())
print("Input: 'true'" , "Output:", Boolean.new('true'):get_boolean())
print("Input: 'false'", "Output:", Boolean.new('false'):get_boolean())
print('----------------')
print('\n\n')

-- @Exceptions
print('Exceptions')
print('----------------')
print("Input: true"             , "Output:", pcall(function() Boolean.new(true) end))
print("Input: false"            , "Output:", pcall(function() Boolean.new(false) end))
print("Input: 1"                , "Output:", pcall(function() Boolean.new(1) end))
print("Input: 0"                , "Output:", pcall(function() Boolean.new(0) end))
print("Input: {}"               , "Output:", pcall(function() Boolean.new({}) end))
print("Input: nil"              , "Output:", pcall(function() Boolean.new(nil) end))
print("Input: 1.5"              , "Output:", pcall(function() Boolean.new(1.5) end))
print("Input: '42'"             , "Output:", pcall(function() Boolean.new("42") end))
print("Input: 'Lua'"            , "Output:", pcall(function() Boolean.new("Lua") end))
print("Input: 'True'"           , "Output:", pcall(function() Boolean.new("True") end))
print("Input: 'False'"          , "Output:", pcall(function() Boolean.new("False") end))
print("Input: function -> nil"  , "Output:", pcall(function() Boolean.new(function() end) end))
print("Input: function -> true" , "Output:", pcall(function() Boolean.new(function() return true end) end))
print("Input: function -> false", "Output:", pcall(function() Boolean.new(function() return false end) end))
print("Input: tread"            , "Output:", pcall(function() Boolean.new(coroutine.create(function() end)) end))
print("Input: userdata"         , "Output:", pcall(function() Boolean.new(io.stdout) end))
print('----------------')
print('\n\n')

-- @Variables
print('Variables')
print('----------------')
local int_1  = Integer.new(1)
local bool_1 = Boolean.new(true)
local bool_2 = Boolean.new(false)
local bool_3 = Boolean.new('true')
local bool_4 = Boolean.new('false')

print(int_1)
print(bool_1)
print(bool_2)
print(bool_3)
print(bool_4)
print('----------------')
print('\n\n')

-- @test Boolean.equals()
-- @note Qualquer igualdade deve validar o Tipo do Objeto e o valor associado, se o Objeto e valor igual, retornar true, se nao false
print('Boolean.equals()')
print('----------------')
print("Input: true == true" , "Output:", bool_1:equals(bool_1))
print("Input: true == false", "Output:", bool_1:equals(bool_2))
print("Input: true == true",  "Output:", bool_1:equals(bool_3))
print("Input: true == false", "Output:", bool_1:equals(bool_4))
print("Input: true == 1"    , "Output:", bool_1:equals(int_1) )
print('----------------')
print('\n\n')

-- @test Boolean.hash_code()
-- @note Valores boolean devem retornar 1231 para true e 1237 para false
print('Boolean.hash_code()')
print('----------------')
print("Input: true  -- 1231", "Output:", bool_1:hash_code())
print("Input: false -- 1237", "Output:", bool_2:hash_code())
print("Input: true  -- 1231", "Output:", bool_3:hash_code())
print("Input: false -- 1237", "Output:", bool_4:hash_code())
print('----------------')
print('\n\n')

-- @test Boolean.get_boolean()
-- @note deve retornar o primitivo do boolean nativo da linguagem lua
print('Boolean.get_boolean()')
print('----------------')
print("Input: Boolean(true)" ,  "Output:", bool_1:get_boolean())
print("Input: Boolean(false)", "Output:", bool_2:get_boolean())
print("Input: Boolean(true)" , "Output:", bool_3:get_boolean())
print("Input: Boolean(false)", "Output:", bool_4:get_boolean())
print('----------------')
print('\n\n')

-- @test Boolean.is_true()
-- @note deve retornar true se o valor for correspondente a true
print('Boolean.is_true()')
print('----------------')
print("Input: true" , "Output:", bool_1:is_true())
print("Input: false", "Output:", bool_2:is_true())
print('----------------')
print('\n\n')

-- @test Boolean.is_false()
-- @note deve retornar false se o valor for correspondente a false
print('Boolean.is_false()')
print('----------------')
print("Input: true" , "Output:", bool_1:is_false())
print("Input: false", "Output:", bool_2:is_false())
print('----------------')
print('\n\n')

-- @test Boolean.as_string()
-- @note deve retornar uma orion.types.String com o valor do objeto embutido como string
print('Boolean.as_string()')
print('----------------')
print("")
print("Input: true",  "Output:", bool_1:as_string(), "Type:", type(bool_1:as_string()))
print("Input: false", "Output:", bool_2:as_string(), "Type:", type(bool_2:as_string()))
print('----------------')
print('\n\n')

-- @test Boolean.tostring()
-- @note deve retornar uma string primitiva nativa da linguagem lua
print('Boolean.__tostring()')
print('----------------')
print("Input: Boolean(true)" , "Output:", tostring(bool_3))
print("Input: Boolean(false)", "Output:", tostring(bool_4))
print('----------------')
print('\n\n')
