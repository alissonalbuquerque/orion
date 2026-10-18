-- @class Class
local Class = setmetatable(
    {
        DATA_TYPES       = {'nil', 'boolean', 'number', 'string', 'table'},

        CALLABLE_TYPES   = {'function'},

        MAGIC_FIELDS     = {'__class', '__namespace', '__implements'},

        MAGIC_METHODS    = {'__construct'},

        META_METHODS     = {'__tostring'},

        RESERVED_METHODS = {'__construct', '__tostring'},

        STRUCTS = {
            FIELDS       = 'fields',
            MAGICFIELDS  = 'magicfields',
            METHODS      = 'methods',
            METAMETHODS  = 'metamethods',
            MAGICMETHODS = 'magicmethods'
        },

        STRATEGY = {
            INCLUDE_ALL  = 'include_all',
            INCLUDE_ONLY = 'include_only',
            EXCLUDE_ONLY = 'exclude_only'
        },

        ABSTRACT_CLASS = 'orion.min.AbstractClass'
    },
    {
        __index = {

            -- @param table     _template
            -- @param table|nil _super
            -- @return AbstractClassLoader|ClassLoader
            create = function(self, _template, _super)
                local template = self:merge_template(_template, _super)

                if self:is_abstract_class(template) then
                    return self:abstract_load(template)
                end

                local struct_keys = self:struct_keys(template)

                self:interface_verifier(template)

                return self:class_load(template, struct_keys)
            end,

            -- @param table _template
            -- @param table _struct_keys
            -- @return ClassLoader
            class_load = function(self, _template, _struct_keys)

                local loader = {

                    new = function(...)
                        local args = {...}

                        local schema = self:class_schema(_template, _struct_keys)

                        schema:__construct(table.unpack(args))

                        return schema
                    end,

                    template = _template
                }

                return loader
            end,

            -- @param table _template
            -- @return AbstractClassLoader
            abstract_load = function(self, _template)

                local loader = {

                    new = function(...)
                        error(("Cannot instantiate abstract class '%s'."):format(_template.__class), 1)
                    end,

                    template = _template
                }

                return loader
            end,

            -- @param table     _templatesub
            -- @param table|nil _templatesuper
            -- @return table
            merge_template = function(self, _templatesub, _templatesuper)

                local template = {}

                local sub = _templatesub
                local super = _templatesuper or {}
                local implements = self:merge_interfaces(sub.__implements, super.__implements)

                for _key, _value in pairs(super) do
                    template[_key] = _value
                end

                for _key, _value in pairs(sub) do
                    template[_key] = _value
                end

                template['__implements'] = implements

                return template
            end,

            -- @param table|nil _interfaces_sub
            -- @param table|nil _interfaces_super
            -- @return table
            merge_interfaces = function(self, _interfaces_sub, _interfaces_super)

                local interfaces = {}

                local sub = _interfaces_sub or {}
                local super = _interfaces_super or {}

                for _, _interface in ipairs(super) do
                    local interface = ("%s.%s"):format(_interface.__namespace, _interface.__interface)

                    if interface ~= self.ABSTRACT_CLASS then
                        table.insert(interfaces, _interface)
                    end
                end

                for _, _interface in ipairs(sub) do
                    table.insert(interfaces, _interface)
                end

                return interfaces
            end,

            -- @param table _template
            -- @param table _struct_keys
            -- @return ClassSchema
            class_schema = function(self, _template, _struct_keys)

                local structs = self:schema_struct(_template, _struct_keys)

                local fields       = structs[self.STRUCTS.FIELDS]
                local magicfields  = structs[self.STRUCTS.MAGICFIELDS]
                local methods      = structs[self.STRUCTS.METHODS ]
                local metamethods  = structs[self.STRUCTS.METAMETHODS]
                local magicmethods = structs[self.STRUCTS.MAGICMETHODS]

                local _table = self:merge_structs(fields, magicfields)
                local _metatable = self:merge_structs(methods, magicmethods)

                local schema = self:build_schema(_table, _metatable, metamethods)

                return schema
            end,

            -- @param table _table
            -- @param table _metatable
            -- @param table _metamethods
            -- @return ClassSchema
            build_schema = function(self, _table, _metatable, _metamethods)

                local metatable = {
                    __index = _metatable
                }

                for _key, _value in pairs(_metamethods) do
                    metatable[_key] = _value
                end
                
                local schema = setmetatable(_table, metatable)

                return schema
            end,

            -- @param table _template
            -- @return nil
            -- @throws error If the class does not implement all methods declared by its interfaces.
            interface_verifier = function(self, _template)
                
                local interfaces = _template.__implements or {}

                local callable_keys = self:filter_keys(_template, self.CALLABLE_TYPES, self.STRATEGY.INCLUDE_ALL, nil)

                local callable_set  = {}

                for _, key in ipairs(callable_keys) do
                    callable_set[key] = true
                end

                for _, interface in ipairs(interfaces) do

                    for _, method in ipairs(interface.__methods) do

                        if not callable_set[method] then
                            error(("Class '%s' must implement method '%s' declared in interface '%s'."):format(_template.__class, method, interface.__interface))
                        end

                    end

                end
            end,

            -- @param table _template
            -- @return boolean
            is_abstract_class = function(self, _template)

                local is_abstract = false

                local interfaces  = _template.__implements or {}

                for _, _interface in ipairs(interfaces) do

                    local interface = ("%s.%s"):format(_interface.__namespace, _interface.__interface)

                    if interface == self.ABSTRACT_CLASS then
                        is_abstract = true
                        break
                    end
                    
                end

                return is_abstract
            end,

            -- @param  table _template
            -- @param  table _struct_keys
            -- @return table
            schema_struct = function(self, _template, _struct_keys)
                local schema = {}

                    schema[self.STRUCTS.FIELDS]       = self:pick_struct(_template, _struct_keys[self.STRUCTS.FIELDS])
                    schema[self.STRUCTS.MAGICFIELDS]  = self:pick_struct(_template, _struct_keys[self.STRUCTS.MAGICFIELDS])
                    schema[self.STRUCTS.METHODS]      = self:pick_struct(_template, _struct_keys[self.STRUCTS.METHODS ])
                    schema[self.STRUCTS.METAMETHODS]  = self:pick_struct(_template, _struct_keys[self.STRUCTS.METAMETHODS])
                    schema[self.STRUCTS.MAGICMETHODS] = self:pick_struct(_template, _struct_keys[self.STRUCTS.MAGICMETHODS])

                return schema
            end,
            
            -- @param  table ...
            -- @return table
            merge_structs = function(self, ...)
                local struct_merged = {}

                local structs = {...}

                for _, struct in ipairs(structs) do
                    for _key, _value in pairs(struct) do
                        struct_merged[_key] = _value
                    end
                end

                return struct_merged
            end,

            -- @param  table _keys
            -- @param  table _template
            -- @return table
            pick_struct = function(self, _template, _keys)
                local struct = {}

                for _, _key in ipairs(_keys) do
                    struct[_key] = _template[_key]
                end

                return struct
            end,

            -- @param  table _template
            -- @return table
            struct_keys = function(self, _template)
                local keys = {}

                    keys[self.STRUCTS.FIELDS]       = self:filter_keys(_template, self.DATA_TYPES, self.STRATEGY.EXCLUDE_ONLY, self.MAGIC_FIELDS)
                    keys[self.STRUCTS.MAGICFIELDS]  = self:filter_keys(_template, self.DATA_TYPES, self.STRATEGY.INCLUDE_ONLY, self.MAGIC_FIELDS)
                    keys[self.STRUCTS.METHODS]      = self:filter_keys(_template, self.CALLABLE_TYPES, self.STRATEGY.EXCLUDE_ONLY, self.RESERVED_METHODS)
                    keys[self.STRUCTS.METAMETHODS]  = self:filter_keys(_template, self.CALLABLE_TYPES, self.STRATEGY.INCLUDE_ONLY, self.META_METHODS)
                    keys[self.STRUCTS.MAGICMETHODS] = self:filter_keys(_template, self.CALLABLE_TYPES, self.STRATEGY.INCLUDE_ONLY, self.MAGIC_METHODS)

                return keys
            end,

            -- @param  table  _template
            -- @param  table  _types
            -- @param  string _strategy
            -- @param  table|nil _signatures
            -- @return table
            filter_keys = function(self, _template, _types, _strategy, _signatures)
                local type_keys     = {}
                local strategy_keys = {}

                for _, _type in ipairs(_types) do
                    for _key, _value in pairs(_template) do
                        if type(_value) == _type then table.insert(type_keys, _key) end
                    end
                end

                if _strategy == self.STRATEGY.INCLUDE_ALL then
                    return type_keys
                end

                if _strategy == self.STRATEGY.INCLUDE_ONLY then

                    for _, _key in ipairs(type_keys) do
                        for _, _signature in ipairs(_signatures) do
                            if _key == _signature then table.insert(strategy_keys, _key) end
                        end
                    end

                end

                if _strategy == self.STRATEGY.EXCLUDE_ONLY then

                    for _, _key in ipairs(type_keys) do
                        local _is_excluded = false

                        for _, _signature in ipairs(_signatures) do
                            if _key == _signature then
                                _is_excluded = true
                                break
                            end
                        end
                    
                        if _is_excluded == false then
                            table.insert(strategy_keys, _key)
                        end
                    end

                end

                return strategy_keys
            end,

            -- @param  table _template
            -- @return string
            tostring = function(self, _template)
                local _metatable = getmetatable(_template)

                setmetatable(_template, nil)

                local output = ("%s.%s (%s)"):format(
                    _template.__namespace,
                    _template.__class,
                    tostring(_template):match("0x%x+")
                )

                setmetatable(_template, _metatable)

                return output
            end
        }
    }
)

return Class
