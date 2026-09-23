-- @static
local Values = setmetatable(
    {
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

            -- @param any received
            -- @param any expected
            -- @param any assign
            -- @return any
            valid_assign = function(self, received, expected, assign)
                if received == expected then
                    return assign
                else
                    return received
                end
            end,

            -- @param any value
            -- @return string
            to_string = function(self, value)
                return tostring(value)
            end,

            -- @param any value
            -- @return number|nil
            to_number = function(self, value)
                return tonumber(value)
            end

        }
    }
)

return Values
