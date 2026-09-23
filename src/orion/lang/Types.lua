-- @static
local Types = setmetatable(
    {
        NIL      = 'nil',
        BOOLEAN  = 'boolean',
        NUMBER   = 'number',
        INTEGER  = 'integer',
        FLOAT    = 'float',
        STRING   = 'string',
        TABLE    = 'table',
        FUNCTION = 'function',
    },
    {
        __index = {

            -- @param string a
            -- @param string b
            -- @return boolean
            equals = function(self, a, b)
                return a == b
            end,

            -- @param string a
            -- @param string b
            -- @return boolean
            not_equals = function(self, a, b)
                return a ~= b
            end,

            -- @param any value
            -- @return string
            type = function(self, value)
                return type(value)
            end,

            -- @param Object object
            -- @return string
            class = function(self, object)
                return ("%s.%s"):format(object.__namespace, object.__class)
            end,

            -- @param Interface interface
            -- @return string
            interface = function(self, interface)
                return ("%s.%s"):format(interface.__namespace, interface.__interface)
            end
            
        }
    }
)

return Types
