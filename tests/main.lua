package.path = table.concat({
    package.path,
    './src/?.lua',
    '../src/?.lua'
}, ';')
