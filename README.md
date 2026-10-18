
# Orion

A lightweight object-oriented programming framework for Lua 5.4.

## Features

- Class-based object-oriented programming
- Package and module organization
- Built-in types and utilities
- Exception handling
- Singleton support

## Requirements

- Lua 5.4 or later

## Installation

```bash
luarocks install orion
```

## Quick Start

```lua
-- return string
local orion_v = require("orion.version") 
print(orion_v)
```

## Documentation

- [Getting Started](#getting-started)
- [Classes](#classes)
- [Packages](#packages)
- [Types](#types)
- [Exception Handling](#exception-handling)
- [API Reference](#api-reference)

## Getting Started

Orion é um framework de programação orientada a objetos inspirado em Java. Its contém recursos embutidos para implementar soluções orientadas a objetos e a possibilidade de implementação de novas classes para problemas especificos de cada desenvolvedor em particular. É o primeiro passo para soluções solidas, expansiveis e documentadas de escrever código orientado a objetos em lua com construção e suporte avançado como em outras linguagem de programação com Orientação a Objetos Nativa. Orion se aproveita de recursos nativos da linguagem para a implementação de classes sem a necessecidade de bibliotecas externas. tudo contido na biblioteca é desenvolvido a partir de Lua e testado na sua versão 5.4.

Veja um exemplo de uso da Linguagem com Classes de Enumeration:

```lua
local Enum = require('orion.lang.Enum')

local colors = Enum.new({
    RED   = '#FF0000',
    GREEN = '#00FF00',
    BLUE  = '#0000FF',
})

print(("%s -> %s"):format(colors.RED:get_name(), colors.RED:get_value()))
print(("%s -> %s"):format(colors.GREEN:get_name(), colors.GREEN:get_value()))
print(("%s -> %s"):format(colors.BLUE:get_name(), colors.BLUE:get_value()))
```

## Classes

As classes de Orion tem suporte atualmente a construção de classes com recursos de Herança, Polimorfismo (Lógico / Procedural), implementação a partir de mecanismos de Classe Abstrata e Interfaces veja um breve exemplo de implementação de classe abaixo, fique a vontade para aprofundar os conhecimentos nase sessões especificas. As classes do framework são fruto de um estudo dos recursos da estrutura nativa de dados nativa da linguagem as tables, elas são manipuladas a partir de um manipulador de recursos de tabelas e tipos nativos da linguagem para estruturar objetos a partir de um carregamento estruturados dos recursos fornecidos pelo pacote modulo orion.core.Class e recursos do pacote orion.lang para a construição das maioria das classes do projeto

Classes, Abstratas, Interfaces, Polimorfismo, Herança
Tabelas estudo orientado a objetos
Tudo isso atribuido a um PipeLine de carregamento do pacote orion.core.Class


## Packages

Explain how packages organize code and modules.

## Types

Document the available types, constructors,
validation rules, and supported operations.

## Exception Handling

Document how exceptions are raised, caught,
and handled.

## API Reference

List the public modules, classes, methods,
parameters, return values, and exceptions.

## License

MIT
