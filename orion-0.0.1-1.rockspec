package = "orion"

version = "0.0.1-1"

source = {
  url = "git+https://github.com/alissonalbuquerque/orion.git",
  branch = "main"
}

description = {
  summary  = "A framework POO writed in lua vanilla",
  detailed = "Implementation tables like object orientation paradigm, only lua language",
  homepage = "https://github.com/alissonalbuquerque/orion",
  license  = "MIT"
}

dependencies = {
  "lua >= 5.4"
}

build = {
  type = "builtin",
  modules = {
    ["orion.core"]                         = "src/orion/core/init.lua",
    ["orion.core.config"]                  = "src/orion/core/config.lua",
    ["orion.core.Class"]                   = "src/orion/core/Class.lua",
    ["orion.core.Package"]                 = "src/orion/core/Package.lua",

    ["orion.exceptions"]                   = "src/orion/exceptions/init.lua",
    ["orion.exceptions.config"]            = "src/orion/exceptions/config.lua",
    ["orion.exceptions.TryCatchException"] = "src/orion/exceptions/TryCatchException.lua",
    ["orion.exceptions.TypeError"]         = "src/orion/exceptions/TypeError.lua",
    ["orion.exceptions.ValueError"]        = "src/orion/exceptions/ValueError.lua",

    ["orion.lang"]                         = "src/orion/lang/init.lua",
    ["orion.lang.config"]                  = "src/orion/lang/config.lua",
    ["orion.lang.AbstractClass"]           = "src/orion/lang/AbstractClass.lua",
    ["orion.lang.Case"]                    = "src/orion/lang/Case.lua",
    ["orion.lang.Enum"]                    = "src/orion/lang/Enum.lua",
    ["orion.lang.Exception"]               = "src/orion/lang/Exception.lua",
    ["orion.lang.Object"]                  = "src/orion/lang/Object.lua",
    ["orion.lang.RuntimeException"]        = "src/orion/lang/RuntimeException.lua",
    ["orion.lang.TryCatch"]                = "src/orion/lang/TryCatch.lua",
    ["orion.lang.Types"]                   = "src/orion/lang/Types.lua",
    ["orion.lang.Unit"]                    = "src/orion/lang/Unit.lua",
    ["orion.lang.Values"]                  = "src/orion/lang/Values.lua",

    ["orion.singleton"]                    = "src/orion/singleton/init.lua",
    ["orion.singleton.config"]             = "src/orion/singleton/config.lua",
    ["orion.singleton.Conversion"]         = "src/orion/singleton/Conversion.lua",
    ["orion.singleton.Unit"]               = "src/orion/singleton/Unit.lua",

    ["orion.types"]                        = "src/orion/types/init.lua",
    ["orion.types.config"]                 = "src/orion/types/config.lua",
    ["orion.types.Boolean"]                = "src/orion/types/Boolean.lua",
    ["orion.types.Conversion"]             = "src/orion/types/Conversion.lua",
    ["orion.types.Float"]                  = "src/orion/types/Float.lua",
    ["orion.types.Integer"]                = "src/orion/types/Integer.lua",
    ["orion.types.Number"]                 = "src/orion/types/Number.lua",
  }
}
