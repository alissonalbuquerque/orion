package.path = table.concat({
    package.path,
    './src/?.lua',
    '../../../src/?.lua',
    '../../../../src/?.lua',
}, ';')

local Integer = require('orion.types.Integer')
