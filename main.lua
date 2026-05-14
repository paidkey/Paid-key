local ValidKeys = {
    ["JN-Key-30days"] = true,
    ["vip-key"] = true,
    ["paid-user"] = true
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,300,0,150)
Frame.Position = UDim2.new(0.5,-150,0.5,-75)
Frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
Frame.Parent = ScreenGui

local Box = Instance.new("TextBox")
Box.Size = UDim2.new(0.8,0,0,40)
Box.Position = UDim2.new(0.1,0,0.25,0)
Box.PlaceholderText = "Enter Key"
Box.Text = ""
Box.TextScaled = true
Box.Parent = Frame

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.8,0,0,40)
Button.Position = UDim2.new(0.1,0,0.6,0)
Button.Text = "Verify Key"
Button.TextScaled = true
Button.Parent = Frame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1,0,0,20)
Status.Position = UDim2.new(0,0,0.88,0)
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.new(1,1,1)
Status.TextScaled = true
Status.Parent = Frame

Button.MouseButton1Click:Connect(function()

    local key = Box.Text

    if ValidKeys[key] then

        Status.Text = "Key Valid!"

        task.wait(1)

        ScreenGui:Destroy()

        loadstring(game:HttpGet(
            "https://pastebin.com/raw/stzDSY53"
        ))()

    else
        Status.Text = "Invalid Key"
    end
end)
