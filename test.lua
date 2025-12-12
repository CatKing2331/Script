--[[

YOUTUBE TUTORIAL: https://www.youtube.com/watch?v=Yb2GXlsTmNM
MADE BY @uerd

]]
Config = {
    api = "01a80aef-4f89-447c-8b68-a594f0eb2a34", 
    service = "老外",
    provider = "老外"

}
local function main()
-- script here
loadstring(game:HttpGet("https://raw.githubusercontent.com/NakanoNino455/roblox/refs/heads/main/change-UI.lua"))()
end

if getgenv().RedExecutorKeySys then return end
getgenv().RedExecutorKeySys = true

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- Configuration
local KeySystemData = {
    Name = "enter title here",
    Colors = {
        Background = Color3.fromRGB(30, 30, 35),
        Title = Color3.fromRGB(220, 50, 50),
        InputField = Color3.fromRGB(25, 25, 30),
        InputFieldBorder = Color3.fromRGB(180, 0, 0),
        Button = Color3.fromRGB(25, 25, 30),
        ButtonHover = Color3.fromRGB(35, 35, 40),
        Error = Color3.fromRGB(220, 50, 50),
        Success = Color3.fromRGB(80, 200, 80),
        Discord = Color3.fromRGB(88, 101, 242)
    },
    Service = "redexecutor",
    SilentMode = false,
    DiscordInvite = "enterdiscordinvite",
    WebsiteURL = "https://yourwebsite.com/", -- leave like that
    FileName = "redexecutor/key.txt"
}

local function CreateObject(class, props)
    local obj = Instance.new(class)
    for prop, value in pairs(props) do 
        if prop ~= "Parent" then
            obj[prop] = value
        end
    end
    if props.Parent then
        obj.Parent = props.Parent
    end
    return obj
end

local function SmoothTween(obj, time, properties)
    local tween = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

local ScreenGui = CreateObject("ScreenGui", {
    Name = "RedExecutorKeySystem", 
    Parent = CoreGui, 
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999
})

local MainFrame = CreateObject("Frame", {
    Name = "MainFrame",
    Parent = ScreenGui,
    BackgroundColor3 = KeySystemData.Colors.Background,
    BorderColor3 = KeySystemData.Colors.InputFieldBorder,
    BorderSizePixel = 2,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, 350, 0, 250),
    ClipsDescendants = true
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 8), Parent = MainFrame})

local TitleBar = CreateObject("Frame", {
    Name = "TitleBar",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Background,
    Size = UDim2.new(1, 0, 0, 30),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0, 0)
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 8, 0, 0), Parent = TitleBar})

local Title = CreateObject("TextLabel", {
    Name = "Title",
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Text = KeySystemData.Name .. " Key System",
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 200, 0, 20),
    Font = Enum.Font.GothamBold,
    TextColor3 = KeySystemData.Colors.Title,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Center,
    AnchorPoint = Vector2.new(0.5, 0.5)
})

local KeyInput = CreateObject("TextBox", {
    Name = "KeyInput",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.InputField,
    Text = "",
    PlaceholderText = "Enter your key here...",
    Position = UDim2.new(0.5, 0, 0.3, 0),
    Size = UDim2.new(0, 280, 0, 35),
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(220, 220, 220),
    PlaceholderColor3 = Color3.fromRGB(140, 140, 140),
    TextXAlignment = Enum.TextXAlignment.Left,
    AnchorPoint = Vector2.new(0.5, 0),
    ClipsDescendants = true,
    ClearTextOnFocus = false
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = KeyInput})
CreateObject("UIStroke", {
    Parent = KeyInput,
    Color = KeySystemData.Colors.InputFieldBorder,
    Thickness = 1,
    Transparency = 0.8
})
CreateObject("UIPadding", {
    Parent = KeyInput,
    PaddingLeft = UDim.new(0, 10)
})

local SubmitButton = CreateObject("TextButton", {
    Name = "ValidateButton",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Button,
    BorderColor3 = KeySystemData.Colors.InputFieldBorder,
    BorderSizePixel = 1,
    Position = UDim2.new(0.3, 0, 0.55, 0),
    Size = UDim2.new(0, 110, 0, 32),
    Text = "Verify Key",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = KeySystemData.Colors.Title,
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0)
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = SubmitButton})

local GetKeyButton = CreateObject("TextButton", {
    Name = "GetKeyButton",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Button,
    BorderColor3 = KeySystemData.Colors.InputFieldBorder,
    BorderSizePixel = 1,
    Position = UDim2.new(0.7, 0, 0.55, 0),
    Size = UDim2.new(0, 110, 0, 32),
    Text = "Get Key",
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextColor3 = KeySystemData.Colors.Title,
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0)
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = GetKeyButton})

local DiscordButton = CreateObject("TextButton", {
    Name = "DiscordButton",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Discord,
    Position = UDim2.new(0.5, 0, 0.75, 0),
    Size = UDim2.new(0, 220, 0, 32),
    Text = "Join Discord",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0)
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = DiscordButton})

local StatusLabel = CreateObject("TextLabel", {
    Name = "StatusLabel",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.9, 0),
    Size = UDim2.new(0, 280, 0, 20),
    Font = Enum.Font.Gotham,
    Text = "",
    TextColor3 = KeySystemData.Colors.Error,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Center,
    AnchorPoint = Vector2.new(0.5, 0),
    TextTransparency = 1
})

local function ShowStatusMessage(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color
    StatusLabel.TextTransparency = 0
    SmoothTween(StatusLabel, 0.3, {TextTransparency = 0})
    
    task.spawn(function()
        task.wait(3)
        if StatusLabel.Text == text then
            SmoothTween(StatusLabel, 0.5, {TextTransparency = 1})
        end
    end)
end

local function AddHoverEffect(button)
    button.MouseEnter:Connect(function()
        SmoothTween(button, 0.2, {
            BackgroundColor3 = KeySystemData.Colors.ButtonHover
        })
    end)
    
    button.MouseLeave:Connect(function()
        SmoothTween(button, 0.2, {
            BackgroundColor3 = KeySystemData.Colors.Button
        })
    end)
end

AddHoverEffect(SubmitButton)
AddHoverEffect(GetKeyButton)

KeyInput.Focused:Connect(function()
    SmoothTween(KeyInput.UIStroke, 0.2, {
        Color = KeySystemData.Colors.Title, 
        Transparency = 0.3
    })
end)

KeyInput.FocusLost:Connect(function()
    SmoothTween(KeyInput.UIStroke, 0.2, {
        Color = KeySystemData.Colors.InputFieldBorder, 
        Transparency = 0.8
    })
end)

local function openGetKey()
    local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    
    local API_KEY = Config.api
    local PROVIDER = Config.provider
    local SERVICE = Config.service
    
    local link = JunkieKeySystem.getLink(API_KEY, PROVIDER, SERVICE)
    if link then
        if setclipboard then
            setclipboard(link)
            ShowStatusMessage("Verification link copied!", KeySystemData.Colors.Success)
        else
            ShowStatusMessage("Link: " .. link, KeySystemData.Colors.Success)
        end
    else
        ShowStatusMessage("Failed to generate link", KeySystemData.Colors.Error)
    end
end

local function validateKey()
    local userKey = KeyInput.Text:gsub("%s+", "")
    if not userKey or userKey == "" then
        ShowStatusMessage("Please enter a key.", KeySystemData.Colors.Error)
        return
    end

    ShowStatusMessage("Validating key...", Color3.fromRGB(255, 165, 0))
    
    local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    
    local API_KEY = Config.api
    local SERVICE = Config.service
    
    local isValid = JunkieKeySystem.verifyKey(API_KEY, userKey, SERVICE)
    if isValid then
        ShowStatusMessage("Key valid! Loading executor...", KeySystemData.Colors.Success)
        
        SmoothTween(MainFrame, 0.5, {
            Position = UDim2.new(0.5, 0, -0.5, 0),
            BackgroundTransparency = 1
        })
        
        task.wait(0.5)
        ScreenGui:Destroy()
        
        main()
    else
        ShowStatusMessage("Invalid key. Try again!", KeySystemData.Colors.Error)
    end
end

SubmitButton.MouseButton1Click:Connect(validateKey)
GetKeyButton.MouseButton1Click:Connect(openGetKey)

local dragging, dragInput, dragStart, startPos
local function onInputChanged(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(onInputChanged)

DiscordButton.MouseButton1Click:Connect(function()
    local discordUrl = "https://discord.gg/" .. KeySystemData.DiscordInvite
    
    if setclipboard then
        setclipboard(discordUrl)
        ShowStatusMessage("Copied Discord invite!", Color3.fromRGB(123, 48, 220))
    else
        ShowStatusMessage("Join: " .. discordUrl, Color3.fromRGB(123, 48, 220))
    end
end)

KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        validateKey()
    end
end)

MainFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundTransparency = 1

SmoothTween(MainFrame, 0.5, {
    Size = UDim2.new(0, 350, 0, 250), 
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundTransparency = 0
})
