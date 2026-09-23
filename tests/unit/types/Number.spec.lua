package.path = table.concat({
    package.path,
    './src/?.lua',
    '../../../src/?.lua',
    '../../../../src/?.lua',
}, ';')

local Number = require('orion.types.Number')
