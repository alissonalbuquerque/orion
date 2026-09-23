package.path = table.concat({
    package.path,
    './src/?.lua',
    '../../../src/?.lua',
    '../../../../src/?.lua',
}, ';')

local Float = require('orion.types.Float')

local flt = Float.new('10')

print(
    flt:get_value(),
    flt:hash_code()
)
