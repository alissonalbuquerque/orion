package = "orion-minimal"

version = "0.0.1-1"

source = {
  url = "git+https://github.com/alissonalbuquerque/orion.git",
  branch = "minimal"
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
    ["orion.min.version"]           = "src/orion/min/version.lua",

    ["orion.min"]                   = "src/orion/min/init.lua",
    ["orion.min.config"]            = "src/orion/min/config.lua",

    ["orion.min.AbstractClass"]     = "src/orion/min/AbstractClass.lua",
    ["orion.min.Class"]             = "src/orion/min/Class.lua",
    ["orion.min.Exception"]         = "src/orion/min/Exception.lua",
    ["orion.min.Object"]            = "src/orion/min/Object.lua",
    ["orion.min.Package"]           = "src/orion/min/Package.lua",
    ["orion.min.RuntimeException"]  = "src/orion/min/RuntimeException.lua",
    ["orion.min.TryCatchException"] = "src/orion/min/TryCatchException.lua",
    ["orion.min.TryCatch"]          = "src/orion/min/TryCatch.lua",
    ["orion.min.Types"]             = "src/orion/min/Types.lua",
    ["orion.min.Unit"]              = "src/orion/min/Unit.lua",
  }
}
