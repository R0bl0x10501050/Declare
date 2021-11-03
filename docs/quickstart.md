First, let's initialize the module.

```lua
local Declare = require(game.ServerStorage.MainModule)
local Insert = Declare.Insert
local Template = Declare.Template
```

Next, let's define a new Button template.

```lua
local Button = Template "TextButton" {
	Name = "Button",
	Text = "Click Me",
	Size = UDim2.new(0.8,0,0,100),
	
	["Event:MouseButton1Click"] = function()
		print("Clicked a button!")
	end,
}
```

For properties, we use the name, but  for events, we will use the `Event:<NAME>` format.

Now, let's make a Declare Tree.

```lua
local tree = Insert "ScreenGui" {
	Children = {
		Insert "Frame" {
			Size = UDim2.new(0, 1000, 0, 750),
			Children = {
				Button {
					BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
					Position = UDim2.new(0, 0, 0.1, 0)
				},
				Button {
					BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
					Position = UDim2.new(0, 0, 0.4, 0)
				},
				Button {
					BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
					Position = UDim2.new(0, 0, 0.7, 0)
				}
			}
		}
	}
}
```

This will create a `ScreenGui>Frame>3 Buttons`.

Finally, we will mount the GUI on the first player in the game.

```lua
wait(5)
Declare.Mount(tree, game.Players:GetPlayers()[1].PlayerGui)
```

Great! We've made out first Declare program.

Move on to the API Reference to learn more.
