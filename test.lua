--[[
    响应式密钥系统 - 移动端修复版 (Mobile Fix)
    修复了 CoreGui 崩溃问题和 GetKey 失败问题
]]

Config = {
    api = "01a80aef-4f89-447c-8b68-a594f0eb2a34", 
    service = "老外",
    provider = "老外"
}

-- 防止重复运行
if getgenv().ResponsiveKeySys then 
    warn("Script already running!")
    return 
end
getgenv().ResponsiveKeySys = true

-- 服务
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- 1. 修复父级问题：手机端优先使用 PlayerGui
local function GetUIParent()
    -- 尝试获取 PlayerGui，这在手机上最稳定
    local success, playerGui = pcall(function()
        return LocalPlayer:WaitForChild("PlayerGui", 5)
    end)
    
    if success and playerGui then
        return playerGui
    end
    
    -- 如果失败，尝试 CoreGui (仅作为备选)
    return CoreGui
end

local function main()
    -- 密钥验证成功后执行的脚本
    warn("Key Verified! Loading Script...")
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NakanoNino455/roblox/refs/heads/main/change-UI.lua"))()
    end)
end

-- 检测设备类型
local function isMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

-- 配置
local UIConfig = {
    Name = "密钥验证系统",
    Colors = {
        Primary = Color3.fromRGB(100, 80, 255),
        Secondary = Color3.fromRGB(80, 60, 200),
        Background = Color3.fromRGB(20, 20, 25),
        Surface = Color3.fromRGB(30, 30, 38),
        Border = Color3.fromRGB(100, 80, 255),
        Text = Color3.fromRGB(240, 240, 245),
        TextDim = Color3.fromRGB(160, 160, 170),
        Success = Color3.fromRGB(80, 220, 120),
        Error = Color3.fromRGB(255, 80, 100),
        Warning = Color3.fromRGB(255, 180, 60)
    }
}

-- 创建UI对象辅助函数
local function Create(class, props)
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

-- 平滑动画
local function Tween(obj, time, props)
    local tween = TweenService:Create(
        obj, 
        TweenInfo.new(time, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), 
        props
    )
    tween:Play()
    return tween
end

-- 创建主界面
local parentTarget = GetUIParent()
if not parentTarget then
    warn("Could not find UI Parent!")
    getgenv().ResponsiveKeySys = false
    return
end

local ScreenGui = Create("ScreenGui", {
    Name = "ResponsiveKeySystem_MobileFix", 
    Parent = parentTarget, 
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 9999, -- 确保在最上层
    IgnoreGuiInset = true
})

-- 根据设备调整尺寸
local frameWidth = isMobile() and 320 or 400
local frameHeight = isMobile() and 380 or 420

local MainFrame = Create("Frame", {
    Name = "MainFrame",
    Parent = ScreenGui,
    BackgroundColor3 = UIConfig.Colors.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, frameWidth, 0, frameHeight),
    ClipsDescendants = true
})
Create("UICorner", {CornerRadius = UDim.new(0, 16), Parent = MainFrame})
Create("UIStroke", {
    Parent = MainFrame,
    Color = UIConfig.Colors.Border,
    Thickness = 2,
    Transparency = 0.5
})

-- 标题区域
local Header = Create("Frame", {
    Name = "Header",
    Parent = MainFrame,
    BackgroundColor3 = UIConfig.Colors.Primary,
    Size = UDim2.new(1, 0, 0, isMobile() and 60 or 70),
    BorderSizePixel = 0
})
Create("UICorner", {CornerRadius = UDim.new(0, 16), Parent = Header})
Create("Frame", {
    Parent = Header,
    BackgroundColor3 = UIConfig.Colors.Primary,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 1, -20),
    Size = UDim2.new(1, 0, 0, 20)
})

local TitleLabel = Create("TextLabel", {
    Name = "Title",
    Parent = Header,
    BackgroundTransparency = 1,
    Text = UIConfig.Name,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0.9, 0, 0, isMobile() and 24 or 28),
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = isMobile() and 18 or 22,
    TextXAlignment = Enum.TextXAlignment.Center,
    AnchorPoint = Vector2.new(0.5, 0.5)
})

-- 内容容器
local ContentFrame = Create("Frame", {
    Name = "Content",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, isMobile() and 70 or 80),
    Size = UDim2.new(1, 0, 1, -(isMobile() and 70 or 80))
})

-- 输入框标签
local InputLabel = Create("TextLabel", {
    Name = "InputLabel",
    Parent = ContentFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0, isMobile() and 15 or 20),
    Size = UDim2.new(0.85, 0, 0, 20),
    Font = Enum.Font.GothamMedium,
    Text = "输入密钥 / Enter Key",
    TextColor3 = UIConfig.Colors.TextDim,
    TextSize = isMobile() and 12 or 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    AnchorPoint = Vector2.new(0.5, 0)
})

-- 密钥输入框
local KeyInputFrame = Create("Frame", {
    Name = "KeyInputFrame",
    Parent = ContentFrame,
    BackgroundColor3 = UIConfig.Colors.Surface,
    Position = UDim2.new(0.5, 0, 0, isMobile() and 45 or 50),
    Size = UDim2.new(0.85, 0, 0, isMobile() and 45 or 50),
    AnchorPoint = Vector2.new(0.5, 0)
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = KeyInputFrame})
Create("UIStroke", {
    Parent = KeyInputFrame,
    Color = UIConfig.Colors.Border,
    Thickness = 1.5,
    Transparency = 0.7
})

local KeyInput = Create("TextBox", {
    Name = "KeyInput",
    Parent = KeyInputFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0.5, 0),
    Size = UDim2.new(1, -30, 1, 0),
    Font = Enum.Font.Gotham,
    Text = "",
    PlaceholderText = "请在此输入密钥...",
    TextColor3 = UIConfig.Colors.Text,
    PlaceholderColor3 = UIConfig.Colors.TextDim,
    TextSize = isMobile() and 14 or 15,
    TextXAlignment = Enum.TextXAlignment.Left,
    AnchorPoint = Vector2.new(0, 0.5),
    ClearTextOnFocus = false
})

-- 按钮容器
local ButtonsFrame = Create("Frame", {
    Name = "Buttons",
    Parent = ContentFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0, isMobile() and 110 or 120),
    Size = UDim2.new(0.85, 0, 0, isMobile() and 140 or 150),
    AnchorPoint = Vector2.new(0.5, 0)
})

-- 创建按钮函数
local function CreateButton(name, text, position, color, textColor)
    local button = Create("TextButton", {
        Name = name,
        Parent = ButtonsFrame,
        BackgroundColor3 = color,
        Position = position,
        Size = UDim2.new(1, 0, 0, isMobile() and 42 or 45),
        Font = Enum.Font.GothamBold,
        Text = text,
        TextColor3 = textColor or Color3.fromRGB(255, 255, 255),
        TextSize = isMobile() and 14 or 15,
        AutoButtonColor = false,
        AnchorPoint = Vector2.new(0.5, 0)
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = button})
    
    button.MouseButton1Down:Connect(function()
        Tween(button, 0.1, {Size = UDim2.new(0.95, 0, 0, isMobile() and 40 or 43)})
    end)
    button.MouseButton1Up:Connect(function()
        Tween(button, 0.1, {Size = UDim2.new(1, 0, 0, isMobile() and 42 or 45)})
    end)
    
    return button
end

-- 获取密钥按钮
local GetKeyBtn = CreateButton(
    "GetKeyButton",
    "🔑 获取密钥 / Get Key",
    UDim2.new(0.5, 0, 0, 0),
    UIConfig.Colors.Secondary,
    Color3.fromRGB(255, 255, 255)
)

-- 验证密钥按钮
local CheckKeyBtn = CreateButton(
    "CheckKeyButton",
    "✓ 验证密钥 / Check Key",
    UDim2.new(0.5, 0, 0, isMobile() and 52 or 55),
    UIConfig.Colors.Primary,
    Color3.fromRGB(255, 255, 255)
)

-- 状态标签
local StatusLabel = Create("TextLabel", {
    Name = "Status",
    Parent = ContentFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 1, isMobile() and -35 or -40),
    Size = UDim2.new(0.85, 0, 0, isMobile() and 30 or 35),
    Font = Enum.Font.Gotham,
    Text = "",
    TextColor3 = UIConfig.Colors.TextDim,
    TextSize = isMobile() and 12 or 13,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,
    AnchorPoint = Vector2.new(0.5, 0),
    TextTransparency = 1,
    TextWrapped = true
})

local function ShowStatus(message, color, duration)
    StatusLabel.Text = message
    StatusLabel.TextColor3 = color
    Tween(StatusLabel, 0.3, {TextTransparency = 0})
    
    task.spawn(function()
        task.wait(duration or 3)
        if StatusLabel.Text == message then
            Tween(StatusLabel, 0.5, {TextTransparency = 1})
        end
    end)
end

-- 输入框焦点效果
KeyInput.Focused:Connect(function()
    Tween(KeyInputFrame.UIStroke, 0.2, {
        Color = UIConfig.Colors.Primary,
        Transparency = 0.3
    })
end)

KeyInput.FocusLost:Connect(function(enterPressed)
    Tween(KeyInputFrame.UIStroke, 0.2, {
        Color = UIConfig.Colors.Border,
        Transparency = 0.7
    })
    
    if enterPressed and KeyInput.Text ~= "" then
        CheckKeyBtn.MouseButton1Click:Fire()
    end
end)

-- 2. 修复 Get Key 功能：增强错误处理和备用方案
GetKeyBtn.MouseButton1Click:Connect(function()
    ShowStatus("正在请求... / Requesting...", UIConfig.Colors.Warning, 2)
    
    local success, result = pcall(function()
        -- 尝试加载 SDK
        local sdkUrl = "https://junkie-development.de/sdk/JunkieKeySystem.lua"
        local sdkScript = game:HttpGet(sdkUrl)
        local JunkieKeySystem = loadstring(sdkScript)()
        return JunkieKeySystem.getLink(Config.api, Config.provider, Config.service)
    end)
    
    if success and result then
        -- 3. 安全的剪贴板复制
        local copySuccess = pcall(function()
            if setclipboard then
                setclipboard(result)
            elseif toclipboard then
                toclipboard(result)
            else
                error("No clipboard support")
            end
        end)
        
        if copySuccess then
            ShowStatus("✓ 链接已复制! / Copied!", UIConfig.Colors.Success, 3)
        else
            -- 如果复制失败，显示在输入框里
            KeyInput.Text = result
            ShowStatus("请手动复制链接 / Copy manually from input", UIConfig.Colors.Warning, 5)
        end
    else
        ShowStatus("HTTP 请求失败 / Request Failed", UIConfig.Colors.Error, 3)
        warn("Get Key Error: " .. tostring(result))
    end
end)

-- 验证密钥功能
CheckKeyBtn.MouseButton1Click:Connect(function()
    local userKey = KeyInput.Text:gsub("%s+", "")
    
    if userKey == "" then
        ShowStatus("⚠ 请输入密钥 / Enter key", UIConfig.Colors.Warning, 2)
        return
    end
    
    ShowStatus("验证中... / Checking...", UIConfig.Colors.Warning, 2)
    
    local success, isValid = pcall(function()
        local sdkScript = game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua")
        local JunkieKeySystem = loadstring(sdkScript)()
        return JunkieKeySystem.verifyKey(Config.api, userKey, Config.service)
    end)
    
    if success and isValid then
        ShowStatus("✓ 成功! / Success!", UIConfig.Colors.Success, 2)
        
        task.wait(0.5)
        Tween(MainFrame, 0.4, {
            Position = UDim2.new(0.5, 0, -0.5, 0),
            Size = UDim2.new(0, frameWidth * 0.8, 0, frameHeight * 0.8)
        })
        
        task.wait(0.4)
        ScreenGui:Destroy()
        -- 运行主脚本
        main()
    else
        ShowStatus("✗ 密钥错误 / Invalid Key", UIConfig.Colors.Error, 3)
        
        -- 晃动效果
        local originalPos = KeyInputFrame.Position
        for i = 1, 3 do
            Tween(KeyInputFrame, 0.05, {Position = originalPos + UDim2.new(0, 10, 0, 0)})
            task.wait(0.05)
            Tween(KeyInputFrame, 0.05, {Position = originalPos - UDim2.new(0, 10, 0, 0)})
            task.wait(0.05)
        end
        Tween(KeyInputFrame, 0.05, {Position = originalPos})
    end
end)

-- 入场动画
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundTransparency = 1

Tween(MainFrame, 0.5, {
    Size = UDim2.new(0, frameWidth, 0, frameHeight),
    BackgroundTransparency = 0
})

task.wait(0.2)
Tween(Header, 0.4, {BackgroundTransparency = 0})
Tween(ContentFrame, 0.4, {BackgroundTransparency = 0})
