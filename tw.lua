--[[
    RED EXECUTOR - PREMIUM KEY SYSTEM
    Ultra-Sleek Obsidian & Crimson UI
    (Bug Fix: Container Architecture for Unified Shadow & Window Dragging)
]]

Config = {
    api = "01a80aef-4f89-447c-8b68-a594f0eb2a34", 
    service = "老外",
    provider = "老外"
}

-- 保存密钥的文件名
local SaveFileName = "Alfredo_Key.txt"

-- [主程序逻辑]
local function main()

loadstring(game:HttpGet("https://files.vapevoidware.xyz/VapeVoidware/VW-Add/main/loader.lua", true))()

end

if getgenv().RedExecutorKeySys then return end
getgenv().RedExecutorKeySys = true

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- UI Color Palette (Obsidian & Crimson Aesthetic)
local Palette = {
    Obsidian    = Color3.fromRGB(12, 12, 15),     -- 深邃黑底
    Surface     = Color3.fromRGB(20, 20, 25),     -- 卡片表层
    SurfaceDark = Color3.fromRGB(15, 15, 19),     -- 输入框深色槽
    Border      = Color3.fromRGB(38, 38, 48),     -- 微光边框
    Crimson     = Color3.fromRGB(235, 45, 75),    -- 绯红主色
    CrimsonGlow = Color3.fromRGB(255, 70, 105),   -- 霓虹绯红高光
    TextPrimary = Color3.fromRGB(255, 255, 255),  -- 纯白主标题
    TextSub     = Color3.fromRGB(140, 140, 155),  -- 次要文字
    Success     = Color3.fromRGB(46, 213, 115),   -- 验证成功绿
    Error       = Color3.fromRGB(255, 71, 87)     -- 错误提示红
}

-- Helper: Create Instance
local function Create(className, properties)
    local instance = Instance.new(className)
    for k, v in pairs(properties) do 
        if k ~= "Parent" then instance[k] = v end
    end
    if properties.Parent then instance.Parent = properties.Parent end
    return instance
end

-- Helper: Tween Animation
local function Tween(instance, duration, properties, style, direction)
    style = style or Enum.EasingStyle.Quart
    direction = direction or Enum.EasingDirection.Out
    local tween = TweenService:Create(instance, TweenInfo.new(duration, style, direction), properties)
    tween:Play()
    return tween
end

-- Get Gui Parent
local GuiParent = CoreGui
pcall(function()
    if not CoreGui or not CoreGui:FindFirstChildOfClass("Folder") then
        GuiParent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end
end)

if GuiParent:FindFirstChild("RedExecutorKeyUI") then
    GuiParent.RedExecutorKeyUI:Destroy()
end

-- ScreenGui
local ScreenGui = Create("ScreenGui", {
    Name = "RedExecutorKeyUI",
    Parent = GuiParent,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 10000
})

-- Invisible Container Frame (整体透明容器：确保阴影与窗口100%绑定移动、拖拽和缩放)
local Container = Create("Frame", {
    Name = "Container",
    Parent = ScreenGui,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, 440, 0, 240),
    ClipsDescendants = false,
    ZIndex = 1
})

-- Shadow Overlay (位于容器内的底层阴影，与主窗口绑定)
local ShadowFrame = Create("ImageLabel", {
    Name = "Shadow",
    Parent = Container,
    BackgroundTransparency = 1,
    Image = "rbxassetid://6015897843",
    ImageColor3 = Color3.fromRGB(0, 0, 0),
    ImageTransparency = 0.35,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(1, 46, 1, 46), -- 比主窗口一圈略大的阴影
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(49, 49, 450, 450),
    ZIndex = 1
})

-- Main Window (位于容器内的核心主卡片)
local MainFrame = Create("Frame", {
    Name = "MainFrame",
    Parent = Container,
    BackgroundColor3 = Palette.Obsidian,
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    ClipsDescendants = true, -- 内部元素圆角裁切
    ZIndex = 2
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = MainFrame})

-- Window Stroke Border (精细微光边框)
local WindowStroke = Create("UIStroke", {
    Parent = MainFrame,
    Color = Palette.Border,
    Thickness = 1.2
})

-- Top Header Bar
local HeaderBar = Create("Frame", {
    Name = "HeaderBar",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 0, 45),
    ZIndex = 3
})

-- macOS Style Window Controls (复古极简三色圆点)
local DotsContainer = Create("Frame", {
    Name = "Dots",
    Parent = HeaderBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 18, 0.5, 0),
    AnchorPoint = Vector2.new(0, 0.5),
    Size = UDim2.new(0, 50, 0, 12),
    ZIndex = 4
})
local dotColors = {Color3.fromRGB(255, 95, 86), Color3.fromRGB(255, 189, 46), Color3.fromRGB(39, 201, 63)}
for i, col in ipairs(dotColors) do
    local dot = Create("Frame", {
        Parent = DotsContainer,
        BackgroundColor3 = col,
        Position = UDim2.new(0, (i - 1) * 16, 0, 0),
        Size = UDim2.new(0, 11, 0, 11),
        ZIndex = 4
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = dot})
end

-- Title & Badge (左侧标题与红色小铭牌)
local TitleLabel = Create("TextLabel", {
    Name = "TitleLabel",
    Parent = HeaderBar,
    BackgroundTransparency = 1,
    Text = "Alfredo Script",
    Position = UDim2.new(0, 80, 0, 0),
    Size = UDim2.new(0, 135, 1, 0),
    Font = Enum.Font.GothamBold,
    TextColor3 = Palette.TextPrimary,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
})

local BadgeFrame = Create("Frame", {
    Name = "Badge",
    Parent = HeaderBar,
    BackgroundColor3 = Palette.Crimson,
    Position = UDim2.new(0, 218, 0.5, 0),
    AnchorPoint = Vector2.new(0, 0.5),
    Size = UDim2.new(0, 75, 0, 20),
    ZIndex = 4
})
Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = BadgeFrame})
Create("TextLabel", {
    Parent = BadgeFrame,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    Text = "KEY SYSTEM",
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 10,
    ZIndex = 5
})

-- Header Divider Line (顶部分割线)
Create("Frame", {
    Name = "Divider",
    Parent = MainFrame,
    BackgroundColor3 = Palette.Border,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0, 45),
    Size = UDim2.new(1, 0, 0, 1),
    ZIndex = 3
})

-- Status Notification Pill
local StatusLabel = Create("TextLabel", {
    Name = "StatusLabel",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0, 58),
    AnchorPoint = Vector2.new(0.5, 0),
    Size = UDim2.new(0.9, 0, 0, 18),
    Font = Enum.Font.GothamBold,
    Text = "Please enter your authentication key to continue",
    TextColor3 = Palette.TextSub,
    TextSize = 12,
    ZIndex = 5
})

local statusTimer = nil
local function ShowStatus(text, isError, isSuccess)
    if statusTimer then task.cancel(statusTimer) end
    StatusLabel.Text = text
    if isError then
        StatusLabel.TextColor3 = Palette.Error
    elseif isSuccess then
        StatusLabel.TextColor3 = Palette.Success
    else
        StatusLabel.TextColor3 = Palette.CrimsonGlow
    end
    
    Tween(StatusLabel, 0.2, {TextTransparency = 0})
    statusTimer = task.spawn(function()
        task.wait(3)
        Tween(StatusLabel, 0.5, {TextColor3 = Palette.TextSub})
        StatusLabel.Text = "Please enter your authentication key to continue"
    end)
end

-- Input Container (高质感深色槽输入框)
local InputFrame = Create("Frame", {
    Name = "InputFrame",
    Parent = MainFrame,
    BackgroundColor3 = Palette.SurfaceDark,
    Position = UDim2.new(0.5, 0, 0, 88),
    AnchorPoint = Vector2.new(0.5, 0),
    Size = UDim2.new(1, -44, 0, 46),
    ZIndex = 3
})
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = InputFrame})

local InputStroke = Create("UIStroke", {
    Parent = InputFrame,
    Color = Palette.Border,
    Thickness = 1.2
})

-- Lock Symbol inside Input
local LockSymbol = Create("TextLabel", {
    Name = "LockSymbol",
    Parent = InputFrame,
    BackgroundTransparency = 1,
    Text = "🔑",
    Position = UDim2.new(0, 12, 0, 0),
    Size = UDim2.new(0, 24, 1, 0),
    Font = Enum.Font.Gotham,
    TextSize = 14,
    ZIndex = 4
})

local KeyInput = Create("TextBox", {
    Name = "KeyInput",
    Parent = InputFrame,
    BackgroundTransparency = 1,
    Text = "",
    PlaceholderText = "Paste your secret key here...",
    Position = UDim2.new(0, 42, 0, 0),
    Size = UDim2.new(1, -54, 1, 0),
    Font = Enum.Font.GothamMedium,
    TextSize = 13,
    TextColor3 = Palette.TextPrimary,
    PlaceholderColor3 = Palette.TextSub,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    ZIndex = 4
})

-- 读取本地已保存的 Key
if isfile and isfile(SaveFileName) then
    local savedKey = readfile(SaveFileName)
    if savedKey and #savedKey > 0 then
        KeyInput.Text = savedKey
    end
end

-- Input Box Focus Animations
KeyInput.Focused:Connect(function()
    Tween(InputStroke, 0.25, {Color = Palette.Crimson})
    Tween(InputFrame, 0.25, {BackgroundColor3 = Color3.fromRGB(18, 18, 24)})
end)

KeyInput.FocusLost:Connect(function()
    Tween(InputStroke, 0.25, {Color = Palette.Border})
    Tween(InputFrame, 0.25, {BackgroundColor3 = Palette.SurfaceDark})
end)

-- Action Buttons Container (底部双按钮容器)
local ButtonsFrame = Create("Frame", {
    Name = "ButtonsFrame",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0, 154),
    AnchorPoint = Vector2.new(0.5, 0),
    Size = UDim2.new(1, -44, 0, 46),
    ZIndex = 3
})

-- Left Button: GET KEY (精致外边框样式)
local GetKeyBtn = Create("TextButton", {
    Name = "GetKeyBtn",
    Parent = ButtonsFrame,
    BackgroundColor3 = Palette.Surface,
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0.36, -6, 1, 0),
    Text = "GET KEY",
    Font = Enum.Font.GothamBold,
    TextColor3 = Palette.TextPrimary,
    TextSize = 13,
    AutoButtonColor = false,
    ZIndex = 4
})
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = GetKeyBtn})
local GetKeyStroke = Create("UIStroke", {Parent = GetKeyBtn, Color = Palette.Border, Thickness = 1.2})

GetKeyBtn.MouseEnter:Connect(function()
    Tween(GetKeyBtn, 0.2, {BackgroundColor3 = Color3.fromRGB(28, 28, 36)})
    Tween(GetKeyStroke, 0.2, {Color = Palette.CrimsonGlow})
end)
GetKeyBtn.MouseLeave:Connect(function()
    Tween(GetKeyBtn, 0.2, {BackgroundColor3 = Palette.Surface})
    Tween(GetKeyStroke, 0.2, {Color = Palette.Border})
end)

-- Right Button: VERIFY KEY (绯红高光核心主操作按钮)
local VerifyBtn = Create("TextButton", {
    Name = "VerifyBtn",
    Parent = ButtonsFrame,
    BackgroundColor3 = Palette.Crimson,
    Position = UDim2.new(0.36, 6, 0, 0),
    Size = UDim2.new(0.64, -6, 1, 0),
    Text = "VERIFY KEY",
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    AutoButtonColor = false,
    ZIndex = 4
})
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = VerifyBtn})
local VerifyGradient = Create("UIGradient", {
    Parent = VerifyBtn,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Palette.CrimsonGlow),
        ColorSequenceKeypoint.new(1, Palette.Crimson)
    }),
    Rotation = 90
})

VerifyBtn.MouseEnter:Connect(function()
    Tween(VerifyBtn, 0.2, {BackgroundColor3 = Color3.fromRGB(255, 60, 95)})
end)
VerifyBtn.MouseLeave:Connect(function()
    Tween(VerifyBtn, 0.2, {BackgroundColor3 = Palette.Crimson})
end)

-- Button Press Down Animations
for _, btn in pairs({GetKeyBtn, VerifyBtn}) do
    local origSize = btn.Size
    local origPos = btn.Position
    btn.MouseButton1Down:Connect(function()
        Tween(btn, 0.08, {Size = UDim2.new(origSize.X.Scale, origSize.X.Offset - 2, origSize.Y.Scale, origSize.Y.Offset - 2)})
    end)
    btn.MouseButton1Up:Connect(function()
        Tween(btn, 0.08, {Size = origSize})
    end)
end

-- Success Welcome Screen Overlay
local WelcomeOverlay = Create("Frame", {
    Name = "WelcomeOverlay",
    Parent = MainFrame,
    BackgroundColor3 = Palette.Obsidian,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = 10,
    Visible = false
})
Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = WelcomeOverlay})

local WelcomeText = Create("TextLabel", {
    Parent = WelcomeOverlay,
    BackgroundTransparency = 1,
    Text = "ACCESS GRANTED",
    Position = UDim2.new(0.5, 0, 0.45, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(1, -40, 0, 40),
    Font = Enum.Font.GothamBold,
    TextColor3 = Palette.Success,
    TextSize = 22,
    TextTransparency = 1,
    ZIndex = 11
})

local WelcomeSub = Create("TextLabel", {
    Parent = WelcomeOverlay,
    BackgroundTransparency = 1,
    Text = "Welcome back, " .. Players.LocalPlayer.Name,
    Position = UDim2.new(0.5, 0, 0.6, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(1, -40, 0, 20),
    Font = Enum.Font.Gotham,
    TextColor3 = Palette.TextPrimary,
    TextSize = 13,
    TextTransparency = 1,
    ZIndex = 11
})

-- Functions & Logic
local function openGetKey()
    ShowStatus("Fetching link from server...", false, false)
    task.spawn(function()
        local success, result = pcall(function()
            local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
            return JunkieKeySystem.getLink(Config.api, Config.provider, Config.service)
        end)
        
        if success and result then
            if setclipboard then
                setclipboard(result)
                ShowStatus("Link copied to clipboard! Open in browser.", false, true)
            else
                ShowStatus("Link printed to Console (Press F9)", false, true)
                print("KEY LINK: " .. tostring(result))
            end
        else
            ShowStatus("Failed to generate link. Try again later.", true, false)
        end
    end)
end

local function triggerSuccess()
    WelcomeOverlay.Visible = true
    Tween(WelcomeOverlay, 0.3, {BackgroundTransparency = 0})
    task.wait(0.15)
    Tween(WelcomeText, 0.4, {TextTransparency = 0, Position = UDim2.new(0.5, 0, 0.4, 0)})
    Tween(WelcomeSub, 0.4, {TextTransparency = 0, Position = UDim2.new(0.5, 0, 0.55, 0)})
    
    Tween(WindowStroke, 0.5, {Color = Palette.Success})
    
    task.wait(1.8)
    
    Tween(WelcomeText, 0.3, {TextTransparency = 1})
    Tween(WelcomeSub, 0.3, {TextTransparency = 1})
    Tween(ShadowFrame, 0.4, {ImageTransparency = 1})
    Tween(WindowStroke, 0.4, {Transparency = 1})
    Tween(MainFrame, 0.4, {BackgroundTransparency = 1})
    Tween(Container, 0.4, {Size = UDim2.new(0, 380, 0, 0)})
    
    task.wait(0.4)
    ScreenGui:Destroy()
    main()
end

local function validateKey()
    local userKey = KeyInput.Text:gsub("%s+", "")
    if userKey == "" then 
        return ShowStatus("Please enter your key first!", true, false) 
    end

    ShowStatus("Verifying key with server...", false, false)
    
    task.spawn(function()
        local success, isValid = pcall(function()
            local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
            return JunkieKeySystem.verifyKey(Config.api, userKey, Config.service)
        end)
        
        if success and isValid then
            ShowStatus("Key verified successfully!", false, true)
            if writefile then
                writefile(SaveFileName, userKey)
            end
            task.wait(0.3)
            triggerSuccess()
        else
            ShowStatus("Invalid or expired key!", true, false)
            -- 容器整体左右震动错误反馈（阴影与窗口同频震动）
            local origPos = Container.Position
            for i = 1, 6 do
                Container.Position = origPos + UDim2.new(0, math.random(-8, 8), 0, 0)
                task.wait(0.025)
            end
            Container.Position = origPos
        end
    end)
end

-- Connect Button Events
GetKeyBtn.MouseButton1Click:Connect(openGetKey)
VerifyBtn.MouseButton1Click:Connect(validateKey)
KeyInput.FocusLost:Connect(function(enter)
    if enter then validateKey() end
end)

-- Smooth Window Dragging Logic (绑定容器整体拖拽，阴影绝不脱离)
local dragging, dragInput, dragStart, startPos

HeaderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Container.Position
    end
end)

HeaderBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Tween(Container, 0.06, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, Enum.EasingStyle.Linear)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Intro Opening Animation (整体容器弹窗渐隐展开)
Container.Size = UDim2.new(0, 380, 0, 200)
MainFrame.BackgroundTransparency = 1
ShadowFrame.ImageTransparency = 1
WindowStroke.Transparency = 1

Tween(Container, 0.5, {Size = UDim2.new(0, 440, 0, 240)})
Tween(MainFrame, 0.5, {BackgroundTransparency = 0})
Tween(ShadowFrame, 0.5, {ImageTransparency = 0.35})
Tween(WindowStroke, 0.5, {Transparency = 0})

-- 自动检测与自动获取链接 (运行脚本后自动触发)
task.spawn(function()
    task.wait(0.6) -- 等待开场动画完成
    
    -- 1. 如果检测到本地已保存密钥，自动尝试后台验证
    if KeyInput.Text ~= "" then
        ShowStatus("Auto-verifying saved key...", false, false)
        local success, isValid = pcall(function()
            local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
            return JunkieKeySystem.verifyKey(Config.api, KeyInput.Text, Config.service)
        end)
        
        if success and isValid then
            ShowStatus("Saved key verified successfully!", false, true)
            task.wait(0.3)
            triggerSuccess()
            return
        else
            ShowStatus("Saved key expired! Auto fetching new link...", true, false)
            task.wait(1.2)
        end
    end

    -- 2. 如果没有密钥或密钥已过期，自动执行 openGetKey() 获取卡密链接并复制到剪贴板
    openGetKey()
end)
