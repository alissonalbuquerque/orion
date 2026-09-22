local __config__ = require('orion.exceptions.config')
local Exception  = require('orion.lang.Exception')

-- @class
local TryCatchException = {

    __class = 'TryCatchException',

    __namespace = __config__.__namespace,

    TRY       = 'try',
    CATCH     = 'catch',
    FINALLY   = 'finally',
    HANDLER   = 'handler',    
    EXCEPTION = 'exception',

    TYPE_INVOKED  = 'invoked',
    TYPE_VALIDATED = 'validated',

    -- @param any value
    -- @param string message
    __construct = function(self, options)

        if options.type == self.TYPE_INVOKED then

            if options.block == self.TRY then
                self.message = ("'%s' invoked must be callback is type as function"):format(options.block)
            end

            if options.block == self.CATCH then
                self.message = ("'%s' by '%s' invoked must be callback is type as function"):format(options.block, options.exception)
            end

            if options.block == self.FINALLY then
                self.message = ("'%s' invoked must be callback is type as function"):format(options.block)
            end

            if options.block == self.EXCEPTION then
                self.message = "'catch' invoked, but no matching Exception was found"
            end

        end

        if options.type == self.TYPE_VALIDATED then
            
            if options.block == self.TRY then
                self.message = ("'%s' must be invoked and callback is type as function"):format(options.block)
            end

            if options.block == self.HANDLER then
                self.message = "'try' must have at least one 'catch' or 'finally' invoked and callback must be a function"
            end

        end

    end,

    -- @throws error by built-in Lua error function.
    throw = function(self)
        error(("%s: %s"):format(self:class_name(), self:get_message()))
    end
}

return __config__.__class:create(TryCatchException, Exception.template)