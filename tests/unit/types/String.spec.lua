package.path = table.concat({
    package.path,
    './src/?.lua',
    '../../../src/?.lua',
    '../../../../src/?.lua',
}, ';')

local String = require('orion.types.String')

local str = String.new('Java')
local str = String.new('😂​')

-- print(str:hash_code())
print(str:get_value())

--estudar apis de string e utf8
