package.path = table.concat({
    package.path,
    './src/?.lua',
    '../../../src/?.lua',
    '../../../../src/?.lua',
}, ';')

local core = require('orion.core.init')
local lang = require('orion.lang.init')
local types = require('orion.types.init')
local singleton = require('orion.singleton.init')
local exceptions = require('orion.exceptions.init')

for key, value in pairs(core) do
    print('core ->', key, value)
end

for key, value in pairs(lang) do
    print('lang ->', key, value)
end

for key, value in pairs(types) do
    print('types ->', key, value)
end

for key, value in pairs(singleton) do
    print('singleton ->', key, value)
end

for key, value in pairs(exceptions) do
    print('exceptions ->', key, value)
end
