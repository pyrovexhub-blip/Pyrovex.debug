local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local TextService = game:GetService("TextService")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

local LOGO = "rbxthumb://type=Asset&id=97950138094007&w=420&h=420"
local MAX_DISPLAY_ORDER = 2147483647

local C = {
    BG = Color3.fromRGB(8,4,10),
    P1 = Color3.fromRGB(25,7,16),
    P2 = Color3.fromRGB(43,9,22),

    Red = Color3.fromRGB(220,28,62),
    Red2 = Color3.fromRGB(255,65,90),

    Purple = Color3.fromRGB(125,45,255),
    Purple2 = Color3.fromRGB(190,85,255),

    White = Color3.fromRGB(248,242,246),
    Gray = Color3.fromRGB(155,135,145),

    Good = Color3.fromRGB(65,215,130),
    Bad = Color3.fromRGB(255,55,80)
}

--========================================================
-- GENERAL FUNCTIONS
--========================================================

local function New(class, props, parent)
    local obj = Instance.new(class)

    for k,v in pairs(props or {}) do
        obj[k] = v
    end

    obj.Parent = parent
    return obj
end

local function Corner(obj, radius)
    return New("UICorner", {
        CornerRadius = UDim.new(0,radius)
    },obj)
end

local function Stroke(obj,color,transparency,thickness)
    return New("UIStroke", {
        Color = color,
        Transparency = transparency or 0,
        Thickness = thickness or 1
    },obj)
end

local function Gradient(obj, colors, rotation)
    return New("UIGradient", {
        Color = colors,
        Rotation = rotation or 0
    },obj)
end

local function Tween(obj,duration,properties,style,direction)
    local tw = TS:Create(
        obj,
        TweenInfo.new(
            duration,
            style or Enum.EasingStyle.Quart,
            direction or Enum.EasingDirection.Out
        ),
        properties
    )

    tw:Play()
    return tw
end

local function MakeButton(parent,text,pos,size)
    local b = New("TextButton", {
        Position = pos,
        Size = size,
        BackgroundColor3 = C.P2,
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = C.White,
        TextSize = 8,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    },parent)

    Corner(b,8)
    Stroke(b,C.Red,.45,1)

    return b
end

--========================================================
-- PREMIUM LOADING SCREEN
--========================================================

local OldLoader = PlayerGui:FindFirstChild("PyrovexTopLoader")
if OldLoader then
    OldLoader:Destroy()
end

local Loader = New("ScreenGui", {
    Name = "PyrovexTopLoader",
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    DisplayOrder = MAX_DISPLAY_ORDER,
    ZIndexBehavior = Enum.ZIndexBehavior.Global
},PlayerGui)

local LoadMain = New("Frame", {
    Size = UDim2.fromOffset(340,62),
    Position = UDim2.new(.5,0,0,-85),
    AnchorPoint = Vector2.new(.5,0),
    BackgroundColor3 = C.BG,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 10
},Loader)

Corner(LoadMain,13)

local LoadStroke = Stroke(LoadMain,C.Purple,.1,1.4)

Gradient(LoadMain,ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(16,10,31)),
    ColorSequenceKeypoint.new(.5,Color3.fromRGB(15,7,20)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(35,8,21))
}),20)

-- TOP GLOW

local TopGlow = New("Frame", {
    Size = UDim2.new(1,-12,0,2),
    Position = UDim2.fromOffset(6,0),
    BackgroundColor3 = C.Purple,
    BorderSizePixel = 0,
    ZIndex = 15
},LoadMain)

Corner(TopGlow,10)

Gradient(TopGlow,ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,130,255)),
    ColorSequenceKeypoint.new(.35,C.Purple),
    ColorSequenceKeypoint.new(.7,C.Red),
    ColorSequenceKeypoint.new(1,C.Red2)
}),0)

-- LOADING IMAGE

local LoadLogo = New("ImageLabel", {
    Size = UDim2.fromOffset(34,34),
    Position = UDim2.fromOffset(9,9),
    BackgroundColor3 = C.P2,
    BorderSizePixel = 0,
    Image = LOGO,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 16
},LoadMain)

Corner(LoadLogo,10)
LoadLogo.ClipsDescendants = true
Stroke(LoadLogo,C.Purple2,.05,1.2)

local LogoBorder = LoadLogo:FindFirstChildOfClass("UIStroke")

task.spawn(function()
    while Loader.Parent do
        LogoBorder.Color = C.Red:Lerp(
            C.Purple2,
            (math.sin(tick()*2)+1)/2
        )

        task.wait(.025)
    end
end)

-- LOADING TITLE

local LoadTitle = New("TextLabel", {
    Position = UDim2.fromOffset(51,8),
    Size = UDim2.new(1,-110,0,17),
    BackgroundTransparency = 1,
    Text = "PYROVEX HUB",
    TextColor3 = C.White,
    TextSize = 11,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 16
},LoadMain)

local LoadStatus = New("TextLabel", {
    Position = UDim2.fromOffset(51,25),
    Size = UDim2.new(1,-105,0,15),
    BackgroundTransparency = 1,
    Text = "Initializing Pyrovex Hub...",
    TextColor3 = C.Gray,
    TextSize = 8,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 16
},LoadMain)

local LoadPercent = New("TextLabel", {
    Position = UDim2.new(1,-54,0,24),
    Size = UDim2.fromOffset(43,16),
    BackgroundTransparency = 1,
    Text = "0%",
    TextColor3 = C.Purple2,
    TextSize = 9,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Right,
    ZIndex = 16
},LoadMain)

-- PROGRESS BACKGROUND

local LoadBG = New("Frame", {
    Size = UDim2.new(1,-22,0,5),
    Position = UDim2.fromOffset(11,48),
    BackgroundColor3 = Color3.fromRGB(36,27,43),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 16
},LoadMain)

Corner(LoadBG,10)

local LoadBar = New("Frame", {
    Size = UDim2.new(0,0,1,0),
    BackgroundColor3 = C.Red,
    BorderSizePixel = 0,
    ZIndex = 17
},LoadBG)

Corner(LoadBar,10)

Gradient(LoadBar,ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,145,255)),
    ColorSequenceKeypoint.new(.35,C.Purple),
    ColorSequenceKeypoint.new(.7,C.Red),
    ColorSequenceKeypoint.new(1,C.Red2)
}),0)

-- MOVING SHINE

local Shine = New("Frame", {
    Size = UDim2.new(0,35,1,0),
    BackgroundColor3 = Color3.new(1,1,1),
    BackgroundTransparency = .45,
    BorderSizePixel = 0,
    ZIndex = 18
},LoadBar)

Corner(Shine,10)

Gradient(Shine,ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
    ColorSequenceKeypoint.new(.5,Color3.new(1,1,1)),
    ColorSequenceKeypoint.new(1,Color3.new(1,1,1))
}),0)

Tween(
    LoadMain,
    .8,
    {Position = UDim2.new(.5,0,0,12)},
    Enum.EasingStyle.Quint
)

task.spawn(function()
    while Loader.Parent do
        Tween(LoadStroke,.8,{
            Color = C.Red,
            Transparency = .1
        })

        task.wait(.8)

        if not Loader.Parent then break end

        Tween(LoadStroke,.8,{
            Color = C.Purple2,
            Transparency = .25
        })

        task.wait(.8)
    end
end)

task.spawn(function()
    while Loader.Parent and Shine.Parent do
        Shine.Position = UDim2.new(0,-40,0,0)

        Tween(
            Shine,
            .7,
            {Position = UDim2.new(1,0,0,0)},
            Enum.EasingStyle.Linear
        ).Completed:Wait()

        task.wait(.1)
    end
end)

-- LOADING SEQUENCE

local Messages = {
    "Initializing Pyrovex Hub...",
    "Preparing interface components...",
    "Loading script analyzer...",
    "Optimizing visual components...",
    "Almost ready..."
}

local Start = os.clock()
local Duration = 5
local MessageIndex = 1

Tween(
    LoadBar,
    Duration,
    {Size = UDim2.new(1,0,1,0)},
    Enum.EasingStyle.Linear
)

while os.clock()-Start < Duration do
    if not Loader.Parent then return end

    local elapsed = os.clock()-Start
    local progress = math.clamp(elapsed/Duration,0,1)

    LoadPercent.Text = math.floor(progress*100).."%"

    local index = math.min(
        #Messages,
        math.floor(elapsed)+1
    )

    if index ~= MessageIndex then
        MessageIndex = index

        Tween(LoadStatus,.12,{
            TextTransparency = 1
        })

        task.wait(.12)

        if not Loader.Parent then return end

        LoadStatus.Text = Messages[index]

        Tween(LoadStatus,.2,{
            TextTransparency = 0
        })
    end

    task.wait(.025)
end

LoadPercent.Text = "100%"
LoadStatus.Text = "Pyrovex Hub is ready!"

Tween(LoadStroke,.2,{
    Color = C.Good,
    Transparency = 0
})

Tween(LoadBar,.2,{
    BackgroundColor3 = C.Good
})

task.wait(.3)

Tween(
    LoadMain,
    .65,
    {
        Position = UDim2.new(.5,0,0,-85),
        BackgroundTransparency = 1
    },
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.In
)

for _,obj in ipairs({
    LoadLogo,
    LoadTitle,
    LoadStatus,
    LoadPercent,
    LoadBG,
    TopGlow
}) do
    if obj:IsA("ImageLabel") then
        Tween(obj,.3,{
            ImageTransparency = 1,
            BackgroundTransparency = 1
        })
    elseif obj:IsA("TextLabel") then
        Tween(obj,.3,{
            TextTransparency = 1
        })
    else
        Tween(obj,.3,{
            BackgroundTransparency = 1
        })
    end
end

task.wait(.7)
Loader:Destroy()

--========================================================
-- MAIN PYROVEX SCRIPT ANALYZER
--========================================================

local OldGUI = PlayerGui:FindFirstChild("PyrovexDebugger")
if OldGUI then
    OldGUI:Destroy()
end

local GUI = New("ScreenGui", {
    Name = "PyrovexDebugger",
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    DisplayOrder = MAX_DISPLAY_ORDER,
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
    Enabled = true
},PlayerGui)

local Checking = false
local Minimized = false

-- ROOT - ORIGINAL DIMENSIONS

local Root = New("Frame", {
    Size = UDim2.fromOffset(350,300),
    Position = UDim2.new(.5,-175,.5,-150),
    BackgroundTransparency = 1
},GUI)

--========================================================
-- LEFT EDITOR
--========================================================

local Editor = New("Frame", {
    Size = UDim2.fromOffset(170,300),
    Position = UDim2.fromOffset(0,0),
    BackgroundColor3 = C.BG,
    BorderSizePixel = 0,
    ClipsDescendants = true
},Root)

Corner(Editor,12)
Stroke(Editor,C.Purple,.1,1.3)

Gradient(Editor,ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(30,6,23)),
    ColorSequenceKeypoint.new(.5,C.BG),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(10,3,12))
}),25)

-- EDITOR HEADER

local EditorHeader = New("Frame", {
    Size = UDim2.new(1,-12,0,20),
    Position = UDim2.fromOffset(6,5),
    BackgroundColor3 = C.P1,
    BorderSizePixel = 0
},Editor)

Corner(EditorHeader,6)

local EditorName = New("TextLabel", {
    Position = UDim2.fromOffset(6,0),
    Size = UDim2.fromOffset(65,20),
    BackgroundTransparency = 1,
    Text = "LUA EDITOR",
    TextColor3 = C.Purple2,
    TextSize = 7,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
},EditorHeader)

-- LIVE LOCS

local LOCLabel = New("TextLabel", {
    Position = UDim2.new(1,-91,0,0),
    Size = UDim2.fromOffset(43,20),
    BackgroundTransparency = 1,
    Text = "LOC: 0",
    TextColor3 = C.Good,
    TextSize = 6,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Right
},EditorHeader)

-- LIVE LINES

local LinesLabel = New("TextLabel", {
    Position = UDim2.new(1,-46,0,0),
    Size = UDim2.fromOffset(40,20),
    BackgroundTransparency = 1,
    Text = "LN: 1",
    TextColor3 = C.Purple2,
    TextSize = 6,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Right
},EditorHeader)

--========================================================
-- SCRIPT SCROLLER
--========================================================

local Scroll = New("ScrollingFrame", {
    Position = UDim2.fromOffset(5,29),
    Size = UDim2.new(1,-10,1,-34),
    BackgroundColor3 = Color3.fromRGB(6,3,8),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ScrollingDirection = Enum.ScrollingDirection.XY,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = C.Purple,
    ScrollBarImageTransparency = .05,
    CanvasPosition = Vector2.zero,
    CanvasSize = UDim2.fromOffset(160,260)
},Editor)

Corner(Scroll,8)
Stroke(Scroll,C.Purple,.58,1)

--========================================================
-- LINE NUMBER GUTTER
--========================================================

local Gutter = New("Frame", {
    Position = UDim2.fromOffset(0,0),
    Size = UDim2.new(0,24,1,0),
    BackgroundColor3 = Color3.fromRGB(14,7,17),
    BorderSizePixel = 0,
    ZIndex = 2
},Scroll)

local GutterLine = New("Frame", {
    Position = UDim2.new(1,-1,0,0),
    Size = UDim2.new(0,1,1,0),
    BackgroundColor3 = C.Purple,
    BackgroundTransparency = .55,
    BorderSizePixel = 0,
    ZIndex = 3
},Gutter)

local LineNumbers = New("TextLabel", {
    Position = UDim2.fromOffset(0,5),
    Size = UDim2.new(1,-3,0,250),
    BackgroundTransparency = 1,
    Text = "1",
    TextColor3 = Color3.fromRGB(155,110,185),
    TextSize = 9,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = false,
    ZIndex = 3
},Gutter)

--========================================================
-- SCRIPT TEXTBOX
--========================================================

local Box = New("TextBox", {
    Position = UDim2.fromOffset(29,5),
    Size = UDim2.fromOffset(125,250),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    MultiLine = true,
    Text = "",
    PlaceholderText = "Paste Lua script here...",
    PlaceholderColor3 = Color3.fromRGB(90,70,95),
    TextColor3 = Color3.fromRGB(230,220,232),
    TextSize = 9,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = false,
    ZIndex = 3
},Scroll)

--========================================================
-- LIVE SCRIPT STATISTICS + LINE NUMBERS
--========================================================

local function UpdateCanvas()
    local text = Box.Text
    local lineCount = 1
    local locCount = 0
    local longest = ""

    for line in (text.."\n"):gmatch("(.-)\n") do
        lineCount += 1

        if line:match("%S") then
            locCount += 1
        end

        if #line > #longest then
            longest = line
        end
    end

    lineCount = math.max(1,lineCount-1)

    -- UPDATE LINE NUMBERS

    local numberText = {}

    for i = 1,lineCount do
        numberText[i] = tostring(i)
    end

    LineNumbers.Text = table.concat(numberText,"\n")

    -- UPDATE LOC / LN

    LOCLabel.Text = "LOC: "..locCount
    LinesLabel.Text = "LN: "..lineCount

    -- TEXT DIMENSIONS

    local viewportW = math.max(1,Scroll.AbsoluteSize.X-38)
    local viewportH = math.max(1,Scroll.AbsoluteSize.Y-14)

    local measured = TextService:GetTextSize(
        longest,
        Box.TextSize,
        Box.Font,
        Vector2.new(100000,100000)
    )

    local textW = math.max(viewportW,measured.X+12)
    local textH = math.max(
        viewportH,
        lineCount*12+12
    )

    Box.Size = UDim2.fromOffset(textW,textH)

    LineNumbers.Size = UDim2.new(
        1,-3,
        0,textH
    )

    Gutter.Size = UDim2.new(
        0,24,
        0,textH+10
    )

    Scroll.CanvasSize = UDim2.fromOffset(
        textW+39,
        textH+15
    )
end

Box:GetPropertyChangedSignal("Text"):Connect(function()
    task.defer(UpdateCanvas)
end)

Scroll:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    task.defer(UpdateCanvas)
end)

--========================================================
-- RIGHT MENU
--========================================================

local Main = New("Frame", {
    Size = UDim2.fromOffset(180,300),
    Position = UDim2.fromOffset(170,0),
    BackgroundColor3 = C.BG,
    BorderSizePixel = 0,
    ClipsDescendants = true
},Root)

Corner(Main,12)

local MainStroke = Stroke(Main,C.Red,.1,1.3)

Gradient(Main,ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(38,7,19)),
    ColorSequenceKeypoint.new(.5,C.BG),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(10,3,11))
}),135)

--========================================================
-- HEADER + IMAGE LOGO
--========================================================

local Logo = New("ImageLabel", {
    Size = UDim2.fromOffset(34,34),
    Position = UDim2.fromOffset(8,8),
    BackgroundColor3 = C.P2,
    BorderSizePixel = 0,
    Image = LOGO,
    ScaleType = Enum.ScaleType.Crop
},Main)

Corner(Logo,10)
Logo.ClipsDescendants = true

local LogoStroke = Stroke(Logo,C.Purple2,.05,1.2)

local LogoGradient = Gradient(Logo,ColorSequence.new({
    ColorSequenceKeypoint.new(0,C.Red),
    ColorSequenceKeypoint.new(.5,C.Purple),
    ColorSequenceKeypoint.new(1,C.Red)
}),45)

local Title = New("TextLabel", {
    Position = UDim2.fromOffset(48,8),
    Size = UDim2.new(1,-82,0,17),
    BackgroundTransparency = 1,
    Text = "Pyrovex Hub",
    TextColor3 = C.White,
    TextSize = 10,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left
},Main)

local Sub = New("TextLabel", {
    Position = UDim2.fromOffset(49,24),
    Size = UDim2.new(1,-53,0,12),
    BackgroundTransparency = 1,
    Text = "by Kingflame/Pyrovex Team",
    TextColor3 = C.Gray,
    TextSize = 5.5,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd
},Main)

local Close = MakeButton(
    Main,
    "×",
    UDim2.new(1,-36,0,9),
    UDim2.fromOffset(27,27)
)

Close.TextSize = 15

--========================================================
-- STATUS
--========================================================

local Status = New("Frame", {
    Position = UDim2.fromOffset(7,50),
    Size = UDim2.new(1,-14,0,48),
    BackgroundColor3 = C.P1,
    BorderSizePixel = 0
},Main)

Corner(Status,9)
Stroke(Status,C.Red,.55,1)

local ST = New("TextLabel", {
    Position = UDim2.fromOffset(9,6),
    Size = UDim2.new(1,-18,0,10),
    BackgroundTransparency = 1,
    Text = "STATUS",
    TextColor3 = C.Gray,
    TextSize = 6,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
},Status)

local SV = New("TextLabel", {
    Position = UDim2.fromOffset(9,21),
    Size = UDim2.new(1,-18,0,18),
    BackgroundTransparency = 1,
    Text = "READY TO CHECK",
    TextColor3 = C.White,
    TextSize = 8,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
},Status)

--========================================================
-- ANALYSIS
--========================================================

local Result = New("Frame", {
    Position = UDim2.fromOffset(7,105),
    Size = UDim2.new(1,-14,0,91),
    BackgroundColor3 = C.P1,
    BorderSizePixel = 0
},Main)

Corner(Result,9)
Stroke(Result,C.Purple,.55,1)

local RTitle = New("TextLabel", {
    Position = UDim2.fromOffset(9,6),
    Size = UDim2.new(1,-18,0,10),
    BackgroundTransparency = 1,
    Text = "ANALYSIS",
    TextColor3 = C.Gray,
    TextSize = 6,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
},Result)

local RScroll = New("ScrollingFrame", {
    Position = UDim2.fromOffset(7,21),
    Size = UDim2.new(1,-14,1,-27),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.Purple,
    CanvasSize = UDim2.fromOffset(0,0)
},Result)

local RV = New("TextLabel", {
    Position = UDim2.fromOffset(2,2),
    Size = UDim2.new(1,-8,0,50),
    BackgroundTransparency = 1,
    Text = "No analysis yet.",
    TextColor3 = C.Gray,
    TextSize = 7,
    Font = Enum.Font.Code,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
},RScroll)

local function ResultText(text,color)
    RV.Text = text
    RV.TextColor3 = color or C.Gray

    task.defer(function()
        local h = RV.TextBounds.Y+12

        RV.Size = UDim2.new(
            1,-8,
            0,math.max(50,h)
        )

        RScroll.CanvasSize = UDim2.fromOffset(0,h+5)
    end)
end

--========================================================
-- BUTTON GRID
--========================================================

local Check = MakeButton(
    Main,
    "CHECK SCRIPT",
    UDim2.fromOffset(7,202),
    UDim2.fromOffset(81,34)
)

local Clear = MakeButton(
    Main,
    "CLEAR",
    UDim2.fromOffset(92,202),
    UDim2.fromOffset(81,34)
)

local Copy = MakeButton(
    Main,
    "COPY",
    UDim2.fromOffset(7,240),
    UDim2.fromOffset(81,34)
)

local Reset = MakeButton(
    Main,
    "RESET",
    UDim2.fromOffset(92,240),
    UDim2.fromOffset(81,34)
)

local Info = New("TextLabel", {
    Position = UDim2.fromOffset(7,280),
    Size = UDim2.new(1,-14,0,10),
    BackgroundTransparency = 1,
    Text = "Pyrovex Hub • Analysis Only",
    TextColor3 = C.Gray,
    TextSize = 5.5,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Center
},Main)

--========================================================
-- FLOATING RESTORE BUTTON
--========================================================

local Restore = New("ImageButton", {
    Size = UDim2.fromOffset(50,50),
    Position = UDim2.new(.5,-25,0,12),
    BackgroundColor3 = C.Red,
    BorderSizePixel = 0,
    Image = LOGO,
    ScaleType = Enum.ScaleType.Crop,
    Visible = false,
    AutoButtonColor = false
},GUI)

Corner(Restore,14)
Restore.ClipsDescendants = true

local RestoreStroke = Stroke(Restore,C.Purple2,.05,1.4)

Gradient(Restore,ColorSequence.new({
    ColorSequenceKeypoint.new(0,C.Red),
    ColorSequenceKeypoint.new(.5,C.Purple),
    ColorSequenceKeypoint.new(1,C.Red)
}),45)

--========================================================
-- HOVER ANIMATIONS
--========================================================

local function Hover(button)
    button.MouseEnter:Connect(function()
        Tween(button,.15,{
            BackgroundColor3 = Color3.fromRGB(83,15,40)
        })
    end)

    button.MouseLeave:Connect(function()
        Tween(button,.15,{
            BackgroundColor3 = C.P2
        })
    end)

    button.MouseButton1Down:Connect(function()
        Tween(button,.08,{
            BackgroundColor3 = C.Purple
        })
    end)

    button.MouseButton1Up:Connect(function()
        Tween(button,.12,{
            BackgroundColor3 = Color3.fromRGB(83,15,40)
        })
    end)
end

Hover(Check)
Hover(Clear)
Hover(Copy)
Hover(Reset)
Hover(Close)

--========================================================
-- DRAG ROOT
--========================================================

local function Drag(frame)
    local dragging = false
    local startPos
    local startRoot

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            startPos = input.Position
            startRoot = Root.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if not dragging then return end

        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position-startPos

            Root.Position = UDim2.new(
                startRoot.X.Scale,
                startRoot.X.Offset+delta.X,
                startRoot.Y.Scale,
                startRoot.Y.Offset+delta.Y
            )
        end
    end)
end

Drag(Main)

--========================================================
-- COMPILE-ONLY LUA CHECK
-- DOES NOT EXECUTE PASTED CODE
--========================================================

local function Analyze(code)
    local errors = {}

    if code == "" or code:match("^%s*$") then
        table.insert(errors,"Script input is empty.")
        return errors
    end

    if type(loadstring) == "function" then
        local fn,err = loadstring(code)

        if fn then
            return errors
        end

        table.insert(
            errors,
            tostring(err or "Lua syntax error.")
        )

        return errors
    end

    -- BASIC FALLBACK CHECKER

    local function count(pattern)
        local n = 0

        for _ in code:gmatch(pattern) do
            n += 1
        end

        return n
    end

    if code:match("===") then
        table.insert(errors,"Possible invalid '===' operator.")
    end

    if count("%(") ~= count("%)") then
        table.insert(errors,"Possible unmatched parentheses.")
    end

    if count("%[") ~= count("%]") then
        table.insert(errors,"Possible unmatched square brackets.")
    end

    if count("{") ~= count("}") then
        table.insert(errors,"Possible unmatched curly brackets.")
    end

    local functionCount = count("%f[%a]function%f[%A]")
    local ifCount = count("%f[%a]if%f[%A]")
    local forCount = count("%f[%a]for%f[%A]")
    local whileCount = count("%f[%a]while%f[%A]")
    local doCount = count("%f[%a]do%f[%A]")
    local endCount = count("%f[%a]end%f[%A]")

    local blocks =
        functionCount +
        ifCount +
        forCount +
        whileCount +
        doCount

    if endCount > blocks then
        table.insert(errors,"Possible unexpected 'end' keyword.")
    elseif blocks > endCount then
        table.insert(errors,"Possible missing 'end' keyword.")
    end

    return errors
end

--========================================================
-- CHECK SCRIPT
--========================================================

Check.MouseButton1Click:Connect(function()
    if Checking then return end

    Checking = true

    Check.Text = "CHECKING..."
    SV.Text = "ANALYZING..."
    SV.TextColor3 = C.Purple2

    ResultText("Scanning Lua syntax...",C.Gray)

    task.wait(.35)

    local errors = Analyze(Box.Text)

    if #errors == 0 then
        SV.Text = "NO ERROR FOUND"
        SV.TextColor3 = C.Good

        ResultText(
            "✓ No syntax errors found.\n\nCompile check completed.",
            C.Good
        )
    else
        SV.Text = "ERROR FOUND"
        SV.TextColor3 = C.Bad

        local output = "Errors found: "..#errors.."\n\n"

        for i,v in ipairs(errors) do
            output = output..i..". "..v.."\n"
        end

        ResultText(output,C.Bad)
    end

    Check.Text = "CHECK SCRIPT"
    Checking = false
end)

--========================================================
-- CLEAR
--========================================================

Clear.MouseButton1Click:Connect(function()
    Box.Text = ""
    Scroll.CanvasPosition = Vector2.zero

    SV.Text = "READY TO CHECK"
    SV.TextColor3 = C.White

    ResultText("No analysis yet.",C.Gray)

    UpdateCanvas()
end)

--========================================================
-- COPY
--========================================================

Copy.MouseButton1Click:Connect(function()
    if Box.Text == "" then
        SV.Text = "NOTHING TO COPY"
        SV.TextColor3 = C.Bad
        return
    end

    if setclipboard then
        local ok = pcall(function()
            setclipboard(Box.Text)
        end)

        if ok then
            SV.Text = "COPIED"
            SV.TextColor3 = C.Good
        else
            SV.Text = "COPY FAILED"
            SV.TextColor3 = C.Bad
        end
    else
        SV.Text = "COPY NOT AVAILABLE"
        SV.TextColor3 = C.Bad
    end

    task.delay(1,function()
        if GUI.Parent then
            SV.Text = "READY TO CHECK"
            SV.TextColor3 = C.White
        end
    end)
end)

--========================================================
-- RESET
--========================================================

Reset.MouseButton1Click:Connect(function()
    Box.Text = ""

    Scroll.CanvasPosition = Vector2.zero
    RScroll.CanvasPosition = Vector2.zero

    SV.Text = "READY TO CHECK"
    SV.TextColor3 = C.White

    ResultText("No analysis yet.",C.Gray)

    UpdateCanvas()
end)

--========================================================
-- CLOSE / MINIMIZE
--========================================================

Close.MouseButton1Click:Connect(function()
    if Minimized then return end

    Minimized = true

    Tween(Root,.25,{
        Size = UDim2.fromOffset(5,5)
    })

    task.wait(.22)

    Root.Visible = false

    Restore.Visible = true
    Restore.Size = UDim2.fromOffset(8,8)
    Restore.BackgroundTransparency = 1
    Restore.ImageTransparency = 1

    Tween(Restore,.3,{
        Size = UDim2.fromOffset(50,50),
        BackgroundTransparency = 0,
        ImageTransparency = 0
    })
end)

--========================================================
-- RESTORE
--========================================================

Restore.MouseButton1Click:Connect(function()
    if not Minimized then return end

    Minimized = false

    Restore.Visible = false

    Root.Visible = true
    Root.Size = UDim2.fromOffset(5,5)

    Tween(Root,.32,{
        Size = UDim2.fromOffset(350,300)
    })

    task.defer(UpdateCanvas)
end)

--========================================================
-- RESTORE DRAG
--========================================================

do
    local dragging = false
    local startPos
    local startRestore

    Restore.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            startPos = input.Position
            startRestore = Restore.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if not dragging then return end

        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position-startPos

            Restore.Position = UDim2.new(
                startRestore.X.Scale,
                startRestore.X.Offset+delta.X,
                startRestore.Y.Scale,
                startRestore.Y.Offset+delta.Y
            )
        end
    end)
end

--========================================================
-- ADVANCED COLOR ANIMATION
--========================================================

local animationTime = 0

local AnimationConnection

AnimationConnection = RS.RenderStepped:Connect(function(dt)
    if not GUI.Parent then
        AnimationConnection:Disconnect()
        return
    end

    animationTime += dt

    local value = (math.sin(animationTime*2)+1)/2

    MainStroke.Color = C.Red:Lerp(C.Purple2,value)
    LogoStroke.Color = C.Purple2:Lerp(C.Red,value)
    RestoreStroke.Color = C.Red:Lerp(C.Purple2,value)

    LogoGradient.Rotation = (animationTime*35)%360

    if animationTime > 100000 then
        animationTime = 0
    end
end)

--========================================================
-- INITIAL UPDATE
--========================================================

task.defer(UpdateCanvas)

ResultText("No analysis yet.",C.Gray)

--========================================================
-- PYROVEX HUB INITIALIZED
--========================================================
