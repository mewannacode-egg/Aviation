-- Simple GUI by you

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextButton = Instance.new("TextButton")

-- Parent
ScreenGui.Parent = game.CoreGui

-- Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)

-- Button
TextButton.Parent = Frame
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Position = UDim2.new(0.5, -100, 0.5, -25)
TextButton.Text = "Click Me"
TextButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
TextButton.TextColor3 = Color3.fromRGB(255,255,255)

-- Button function
TextButton.MouseButton1Click:Connect(function()
    print("Button Clicked!")
end)
