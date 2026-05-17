local KEY_FILE = "JNHH_Key.txt"

local savedKey = nil

if isfile and readfile and isfile(KEY_FILE) then
    savedKey = readfile(KEY_FILE)
end

local HttpService = game:GetService("HttpService")

-- SUPABASE
local PROJECT_ID = "tvmwazkybhechsrgkflq"
local API_KEY = "sb_publishable_7u9NLnrgyV-KmRmKIat1fQ_jZBYLWfg"

local URL =
    "https://"..PROJECT_ID..".supabase.co/rest/v1/Keys"

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JN_KEYSYSTEM"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,300,0,150)
Frame.Position = UDim2.new(0.5,-150,0.5,-75)
Frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.Parent = Frame

local Box = Instance.new("TextBox")
Box.Size = UDim2.new(0.85,0,0,40)
Box.Position = UDim2.new(0.075,0,0.2,0)
Box.PlaceholderText = "Enter Key"
Box.Text = savedKey or ""
Box.TextScaled = true
Box.BackgroundColor3 = Color3.fromRGB(50,50,50)
Box.TextColor3 = Color3.new(1,1,1)
Box.Parent = Frame

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.85,0,0,40)
Button.Position = UDim2.new(0.075,0,0.55,0)
Button.Text = "Verify Key"
Button.TextScaled = true
Button.BackgroundColor3 = Color3.fromRGB(0,170,255)
Button.TextColor3 = Color3.new(1,1,1)
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
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

    local success, response = pcall(function()
        return request({
            Url = URL .. "?key=eq." .. key,
            Method = "GET",
            Headers = {
                ["apikey"] = API_KEY,
                ["Authorization"] = "Bearer " .. API_KEY
            }
        })
    end)

    if not success or not response then
        Status.Text = "API Error"
        return
    end

    local data = HttpService:JSONDecode(response.Body)

    if not data[1] then
        Status.Text = "Invalid Key"
        return
    end

    local keyData = data[1]

    -- Expiry check
    if keyData.expires_at then
        local expireTime = DateTime.fromIsoDate(keyData.expires_at).UnixTimestamp

        if os.time() > expireTime then
            Status.Text = "Key Expired"
            return
        end
    end

    local hwids = keyData.Hwids or {}
    local max_hwid = keyData.max_hwid or 1

    local found = false

    for _,v in pairs(hwids) do
        if v == hwid then
            found = true
        end
    end

    if not found then

        if #hwids >= max_hwid then
            Status.Text = "HWID Limit Reached"
            return
        end

        table.insert(hwids, hwid)

        request({
            Url = URL .. "?id=eq." .. keyData.id,
            Method = "PATCH",
            Headers = {
                ["Content-Type"] = "application/json",
                ["apikey"] = API_KEY,
                ["Authorization"] = "Bearer " .. API_KEY
            },
            Body = HttpService:JSONEncode({
                Hwids = hwids
            })
        })
    end

    if writefile then
    writefile(KEY_FILE, key)
end

Status.Text = "Key Valid!"

    task.wait(1)

    ScreenGui:Destroy()

    -- LOAD YOUR REAL SCRIPT
    loadstring(game:HttpGet(
        "https://pastebin.com/raw/stzDSY53"
    ))()

end)
