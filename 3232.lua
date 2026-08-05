-- This file was generated with SKS V1.2.0

local Pcall_Result, Regex;
local fenv = getfenv();
fenv.FlatIdent_89237 = 0;
fenv.Descriptor = 18;
if isfile then 
    if readfile then 

    end;
end;
if isfile"GamingSpirit_KeySystem.txt" or false then 
end;
local CoreGui = game:GetService("CoreGui");
if not pcall(function(a, b, c, ...)
    Instance.new"ScreenGui".Parent = CoreGui;
end) then
else 

end;
local Frame = Instance.new(
    "Frame",
    Instance.new("ScreenGui", CoreGui)
);
local UDim2_New = UDim2.new;
Frame.Size = UDim2_New(0, 220, 0, 160);
Frame.Position = UDim2_New(0.5, -110, 0.5, -80);
local FromRGB = Color3.fromRGB;
Frame.BackgroundColor3 = FromRGB(30, 30, 30);
Frame.Active = true;
Instance.new("UICorner", Frame);
Frame.InputBegan:Connect(function(a, b, c, ...)
    if (a.UserInputType ~= Enum.UserInputType.MouseButton1) or false then 
        if (a.UserInputType == Enum.UserInputType.Touch) or false then 
        end;
    end;
end);
game:GetService("UserInputService").InputChanged:Connect(function(a_2, b_2, c_2, ...) end);
local Gaming_Spirit_Key = Instance.new("TextLabel", Frame);
Gaming_Spirit_Key.Size = UDim2_New(1, 0, 0, 35);
Gaming_Spirit_Key.Text = "ZTELTE";
local Color3_New = Color3.new;
Gaming_Spirit_Key.TextColor3 = Color3_New(1, 1, 1);
Gaming_Spirit_Key.BackgroundTransparency = 1;
Gaming_Spirit_Key.Font = Enum.Font.GothamBold;
local TextBox = Instance.new("TextBox", Frame);
TextBox.Size = UDim2_New(0, 180, 0, 35);
TextBox.Position = UDim2_New(0.5, -90, 0.3, 0);
TextBox.PlaceholderText = "Enter Key...";
TextBox.BackgroundColor3 = FromRGB(45, 45, 45);
TextBox.TextColor3 = Color3_New(1, 1, 1);
Instance.new("UICorner", TextBox);
local Verify = Instance.new("TextButton", Frame);
Verify.Size = UDim2_New(0, 180, 0, 35);
Verify.Position = UDim2_New(0.5, -90, 0.58, 0);
Verify.Text = "Verify";
Verify.BackgroundColor3 = FromRGB(46, 204, 113);
Verify.TextColor3 = Color3_New(1, 1, 1);
Instance.new("UICorner", Verify);
local Key_Link = Instance.new("TextButton", Frame);
Key_Link.Size = UDim2_New(0, 180, 0, 25);
Key_Link.Position = UDim2_New(0.5, -90, 0.83, 0);
Key_Link.Text = "Get Key Link";
Key_Link.BackgroundColor3 = FromRGB(52, 152, 219);
Key_Link.TextColor3 = Color3_New(1, 1, 1);
Instance.new("UICorner", Key_Link);
Key_Link.MouseButton1Click:Connect(function(a_2, b_2, c_2, ...)
    if setclipboard then 
        setclipboard"https://lootdest.org/s?LqaMr3vF";
    end;
    Key_Link.Text = "Link Copied!";
    task.wait(2);
    Key_Link.Text = "Get Key Link";
end);
Verify.MouseButton1Click:Connect(function(a_3, b_3, c_3, ...)
    success_1, Pcall_Result = pcall(function(a_4, b_4, c_4, ...)
        return game:HttpGet("https://pastebin.com/raw/3Yk4R5xS");
    end);
    if success_1 or false then 
        if Pcall_Result or false then 
            Regex = Pcall_Result:gsub("%s+", "");
        end;
    end;
    if not Regex then
    else 
        if (TextBox.Text == Regex) or false then 
        end;
    end;
    TextBox.PlaceholderText = "WRONG KEY!";
end);
