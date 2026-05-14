local ValidKeys = {
    ["JN-Key-30days"] = true,
    ["vip-key"] = true,
    ["paid-user"] = true
}

local key = "JN-Key-30days" -- change for testing

if ValidKeys[key] then
    print("Key Valid!")

    loadstring(game:HttpGet(
        "https://pastebin.com/raw/stzDSY53"
    ))()
else
    warn("Invalid Key")
end
