-- @table Package
local Package = {

    -- @param _namespace string
    -- @param _modules string[]
    -- @return Package
    new = function(_namespace, _modules)

        local _table = {namespace = _namespace, modules = _modules}

        local _metatable = {
            __index = {

                -- @return string
                get_namespace = function(self) 
                    return self.namespace
                end,

                -- @return string[]
                get_modules = function(self)
                    return self.modules
                end,

                -- @return string[]
                get_paths = function(self)
                    local paths = {}

                    for _, _module in ipairs(self.modules) do
                        paths[_module] = ("%s.%s"):format(self.namespace, _module)
                    end
                    
                    return paths
                end,

                -- @return module[]
                load_modules = function(self)
                    local package = {}

                    for key, path in pairs(self:get_paths()) do
                        package[key] = require(path)
                    end

                    return package
                end
            }
        }

        return setmetatable(_table, _metatable)
    end,

    -- @param module[] _modules
    -- @param string[] ...
    -- @return args
    import = function(_modules, ...)
        local modules = {}
        local imports = {...}

        for _, _import in pairs(imports) do
            table.insert(modules, _modules[_import])
        end

        return table.unpack(modules)
    end
}

return Package