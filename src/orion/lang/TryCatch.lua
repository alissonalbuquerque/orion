local __config__ = require('orion.lang.config')

local Unit = require('orion.singleton.Unit')
local Types = require('orion.lang.Types')
local Object = require('orion.lang.Object')
local Exception = require('orion.lang.Exception')
local RuntimeException = require('orion.lang.RuntimeException')
local TryCatchException = require('orion.exceptions.TryCatchException')



-- @class
local TryCatch = {

    -- @only_read string
    __class = 'TryCatch',

    -- @only_read string
    __namespace = __config__.__namespace,

    -- @param table res
    __construct = function(self, res)
        self.res      = self:_resources(res)
        self._try     = {}
        self._catches = {}
        self._finally = {}
        self._exception = nil
    end,

    -- @param string key
    -- @return Any
    get = function(self, key)
        return self.res[key]
    end,

    -- @param function callback
    -- @param table ...
    -- @return self
    try = function(self, callback)

        if Types:type(callback) ~= Types.FUNCTION then
            TryCatchException.new({ block='try', type='invoked' }):throw()
        end

        self._try = {
            callback = callback
        }

        return self
    end,

    -- @param Class exception
    -- @param function callback
    -- @return self
    catch = function(self, exception, callback)

        if Types:type(exception) ~= Types.TABLE or Types:class(exception.template or {}) == 'nil.nil' then 
            TryCatchException.new({ block='exception', type='invoked' }):throw()
        end

        if Types:type(callback) ~= Types.FUNCTION then
            TryCatchException.new({ block='catch', type='invoked', exception=exception.template:class_name() }):throw()
        end

        table.insert(self._catches, { callback = callback, exception = exception })

        return self
    end,

    -- @param function callback
    -- @return self
    finally = function(self, callback)

        if Types:type(callback) ~= Types.FUNCTION then
            TryCatchException.new({ block='finally', type='invoked' }):throw()
        end

        self._finally = {
            callback = callback
        }

        return self
    end,

    -- @return Unit
    _load_try = function(self)

        local status, output = pcall(self._try.callback, self.res)

        if self.res:has_exception() then
            self._exception = self.res.thrower
            self.res.thrower = nil
        else
            self._exception = self:_exception_handler(status, output)
        end

        return Unit
    end,

    -- @return Unit
    _load_catch = function(self)

        if self._exception == nil then return Unit end

        for _, _catch in ipairs(self._catches) do

            if (self._exception:class_name() == _catch.exception.template:class_name()) or (_catch.exception.template:class_name() == Exception.template:class_name()) then

                local status, output = pcall(_catch.callback, self.res)

                if self.res:has_exception() then
                    self._exception = self.res.thrower
                    self.res.thrower = nil
                else
                    self._exception = self:_exception_handler(status, output)
                end

                break
            end
            
        end

        return Unit
    end,

    -- @return Unit
    _load_finally = function(self)

        if Types:type(self._finally.callback) ~= Types.FUNCTION then return Unit end

        local status, output = pcall(self._finally.callback, self.res)

        local _exception = self:_exception_handler(status, output)

        if self.res:has_exception() then
            self._exception = self.res.thrower
            self.res.thrower = nil
        elseif _exception ~= nil then
            self._exception = _exception
        end

        return Unit
    end,

    -- @param boolean pcall_status
    -- @param string|nil pcall_out
    -- @return Exception|nil
    _exception_handler = function(self, pcall_status, pcall_out)

        local exception = nil

        if pcall_status == false then

            local path, line, class, message = pcall_out:match("^(.-):(%d+): ([%w%.]+): (.*)$")

            if not path then
                path, line, message = pcall_out:match("^(.-):(%d+): (.*)$")
                exception = RuntimeException.new(message)
            else
                exception = require(class).new()
                exception.message = message
            end
            
        end

        return exception
    end,

    -- @throws Exception by propagation.
    -- IF: Exception not found handling invoked in TryCatch ELSE
    -- @return Unit
    _propagate_exception = function(self)
        if self._exception ~= nil then self._exception:throw() else return Unit end
    end,

    -- @throws Exception. IF: try, catch and finally is not suitable.
    -- @return Unit
    _validate = function(self)

        if Types:type(self._try.callback) ~= Types.FUNCTION then
            TryCatchException.new({ block='try', type='validated' }):throw()
        end

        if #self._catches == 0 and Types:type(self._finally.callback) ~= Types.FUNCTION then
            TryCatchException.new({ block='handler', type='validated' }):throw()
        end

        return Unit
    end,

    -- @return Unit
    _prepare = function(self)
        self:_validate()
        self:_load_try()
        self:_load_catch()
        self:_load_finally()
        self:_propagate_exception()
        return Unit
    end,

    -- @param table res
    -- @return table
    _resources = function(self, res)
        local resources = setmetatable(
            res,
            {
                __index = {
                    -- @param Exception exception
                    -- @param table . . .
                    -- @return Unit
                    throw = function(self, exception, ...)
                        local args = {...}
                        self.thrower = exception.new(table.unpack(args))
                        return Unit
                    end,

                    -- @return boolean
                    has_exception = function(self)
                        return self.thrower ~= nil
                    end
                }
            }
        )
        return resources
    end,

    -- @return self
    execute = function(self)
        self:_prepare()
        return self
    end
}

return __config__.__class:create(TryCatch, Object.template)
