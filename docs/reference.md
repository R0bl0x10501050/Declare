# API Reference

## Declare.Insert

#### Params
* ClassName: `string`
* Properties/Events: `table<any>`

#### Returns

`Instance<any>`

#### Example

```lua
local Declare = require(path.to.Declare)
local Insert = Declare.Insert

-- Remember: NO parenthesis syntax!
local element = Insert "Part" {
    Name = "Light",
    Color = Color3.new(1, 1, 1),
    
    ["Event:Touched"] = function()
        print("Touched the light!")
    end,
    
    Children = {
        Insert "PointLight" {}
    }
}
```

## Declare.Template

#### Params
* ClassName `string`
* Properties/Events: `table<any>`

#### Returns

`function`

#### Example

```lua
local Declare = require(path.to.Declare)
local Template = Declare.Template

-- Remember: NO parenthesis syntax!
local Brick = Template "Part" {
    Name = "Brick",
    Material = Enum.Material.Brick,
}

local CoolBrick = Brick {
    Color = Color3.fromRGB(255, 0, 0)
}
```

## Declare.Mount

#### Params
* Element: `Instance<any>`
* Parent: `Instance<any>`

#### Returns

`nil`

#### Example

```lua
-- Remember: NO parenthesis syntax!
local Brick = Insert "Part" {
    Name = "Brick",
    Material = Enum.Material.Brick,
}

Declare.Mount(Brick, workspace)
```
