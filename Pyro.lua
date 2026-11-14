
--==================================================
-- PYROVEX HUB - ADVANCED TOP LOADING EFFECT
-- BLUE x RED x BLACK x PURPLE
-- 5 SECONDS | PREMIUM ANIMATED LOADER
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local LogoAsset = "rbxthumb://type=Asset&id=97950138094007&w=420&h=420"

local Old = PlayerGui:FindFirstChild("PyrovexTopLoader")
if Old then Old:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PyrovexTopLoader"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local function New(class,props,parent)
    local object = Instance.new(class)

    for property,value in pairs(props or {}) do
        object[property] = value
    end

    object.Parent = parent
    return object
end

local function Tween(obj,properties,duration,style,direction)
    local tween = TweenService:Create(
        obj,
        TweenInfo.new(
            duration or 0.25,
            style or Enum.EasingStyle.Quart,
            direction or Enum.EasingDirection.Out
        ),
        properties
    )

    tween:Play()
    return tween
end

local Main = New("Frame",{
    Name = "LoadingContainer",
    Size = UDim2.fromOffset(340,62),
    Position = UDim2.new(0.5,0,0,-85),
    AnchorPoint = Vector2.new(0.5,0),
    BackgroundColor3 = Color3.fromRGB(10,12,23),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 10
},ScreenGui)

New("UICorner",{
    CornerRadius = UDim.new(0,13)
},Main)

local MainStroke = New("UIStroke",{
    Color = Color3.fromRGB(90,105,210),
    Thickness = 1.3,
    Transparency = 0.1
},Main)

New("UIGradient",{
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(12,18,35)),
        ColorSequenceKeypoint.new(0.5,Color3.fromRGB(15,12,28)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(28,12,25))
    }),
    Rotation = 15
},Main)

-- OUTER GLOW

local Glow = New("Frame",{
    Name = "Glow",
    Size = UDim2.new(1,-12,0,2),
    Position = UDim2.fromOffset(6,0),
    BackgroundColor3 = Color3.fromRGB(80,120,255),
    BorderSizePixel = 0,
    ZIndex = 12
},Main)

New("UICorner",{
    CornerRadius = UDim.new(1,0)
},Glow)

New("UIGradient",{
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(0,130,255)),
        ColorSequenceKeypoint.new(0.35,Color3.fromRGB(120,65,255)),
        ColorSequenceKeypoint.new(0.7,Color3.fromRGB(230,45,100)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(255,65,65))
    })
},Glow)

-- SETTINGS EMOJI

local Settings = New("TextLabel",{
    Name = "SettingsIcon",
    Size = UDim2.fromOffset(32,32),
    Position = UDim2.fromOffset(11,10),
    BackgroundTransparency = 1,
    Text = "⚙️",
    TextSize = 24,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255,255,255),
    ZIndex = 15
},Main)

task.spawn(function()
    while ScreenGui.Parent and Settings.Parent do
        local rotate = Tween(
            Settings,
            {Rotation = Settings.Rotation + 360},
            1.35,
            Enum.EasingStyle.Linear
        )

        rotate.Completed:Wait()
    end
end)

-- TITLE

local Title = New("TextLabel",{
    Name = "Title",
    Position = UDim2.fromOffset(51,8),
    Size = UDim2.new(1,-115,0,17),
    BackgroundTransparency = 1,
    Text = "PYROVEX HUB",
    TextColor3 = Color3.fromRGB(245,248,255),
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
    ZIndex = 15
},Main)

-- STATUS

local Status = New("TextLabel",{
    Name = "Status",
    Position = UDim2.fromOffset(51,25),
    Size = UDim2.new(1,-105,0,15),
    BackgroundTransparency = 1,
    Text = "Initializing loader...",
    TextColor3 = Color3.fromRGB(150,165,195),
    TextSize = 8,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium,
    ZIndex = 15
},Main)

-- PERCENTAGE

local Percentage = New("TextLabel",{
    Name = "Percentage",
    Position = UDim2.new(1,-54,0,24),
    Size = UDim2.fromOffset(43,16),
    BackgroundTransparency = 1,
    Text = "0%",
    TextColor3 = Color3.fromRGB(150,190,255),
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Right,
    Font = Enum.Font.GothamBold,
    ZIndex = 15
},Main)

-- PROGRESS BACKGROUND

local BarBG = New("Frame",{
    Name = "ProgressBackground",
    Size = UDim2.new(1,-22,0,5),
    Position = UDim2.fromOffset(11,48),
    BackgroundColor3 = Color3.fromRGB(32,35,53),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 15
},Main)

New("UICorner",{
    CornerRadius = UDim.new(1,0)
},BarBG)

-- PROGRESS BAR

local Bar = New("Frame",{
    Name = "ProgressBar",
    Size = UDim2.new(0,0,1,0),
    BackgroundColor3 = Color3.fromRGB(50,130,255),
    BorderSizePixel = 0,
    ZIndex = 16
},BarBG)

New("UICorner",{
    CornerRadius = UDim.new(1,0)
},Bar)

local BarGradient = New("UIGradient",{
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(0,145,255)),
        ColorSequenceKeypoint.new(0.35,Color3.fromRGB(100,80,255)),
        ColorSequenceKeypoint.new(0.7,Color3.fromRGB(190,55,160)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(255,55,70))
    }),
    Rotation = 0
},Bar)

-- MOVING SHINE

local Shine = New("Frame",{
    Name = "ProgressShine",
    Size = UDim2.new(0,45,1,0),
    Position = UDim2.new(0,0,0,0),
    BackgroundColor3 = Color3.fromRGB(255,255,255),
    BackgroundTransparency = 0.55,
    BorderSizePixel = 0,
    ZIndex = 17
},Bar)

New("UICorner",{
    CornerRadius = UDim.new(1,0)
},Shine)

New("UIGradient",{
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,1),
        NumberSequenceKeypoint.new(0.5,0),
        NumberSequenceKeypoint.new(1,1)
    })
},Shine)

-- LOADING ENTRANCE

Tween(
    Main,
    {Position = UDim2.new(0.5,0,0,12)},
    0.75,
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.Out
)

-- BORDER ANIMATION

task.spawn(function()
    while ScreenGui.Parent do
        Tween(MainStroke,{
            Transparency = 0.55,
            Color = Color3.fromRGB(180,65,160)
        },0.8)

        task.wait(0.8)

        if not ScreenGui.Parent then break end

        Tween(MainStroke,{
            Transparency = 0.1,
            Color = Color3.fromRGB(70,145,255)
        },0.8)

        task.wait(0.8)
    end
end)

-- SHINE ANIMATION

task.spawn(function()
    while ScreenGui.Parent and Shine.Parent do
        Shine.Position = UDim2.new(0,-45,0,0)

        local shineTween = Tween(
            Shine,
            {Position = UDim2.new(1,0,0,0)},
            0.75,
            Enum.EasingStyle.Linear
        )

        shineTween.Completed:Wait()
        task.wait(0.12)
    end
end)

-- LOADING STATUS

local LoadingMessages = {
    {Time = 0, Text = "Initializing Pyrovex Hub..."},
    {Time = 1, Text = "Preparing loader interface..."},
    {Time = 2, Text = "Loading script collection..."},
    {Time = 3, Text = "Setting up components..."},
    {Time = 4, Text = "Almost ready..."}
}

for _,message in ipairs(LoadingMessages) do
    task.delay(message.Time,function()
        if not ScreenGui.Parent then return end

        Tween(Status,{
            TextTransparency = 1
        },0.15)

        task.wait(0.15)

        if not ScreenGui.Parent then return end

        Status.Text = message.Text

        Tween(Status,{
            TextTransparency = 0
        },0.2)
    end)
end

-- EXACT 5 SECOND PROGRESS

local StartTime = os.clock()
local Duration = 5

local Progress = Tween(
    Bar,
    {Size = UDim2.new(1,0,1,0)},
    Duration,
    Enum.EasingStyle.Linear
)

Progress:Play()

while os.clock() - StartTime < Duration do
    if not ScreenGui.Parent then return end

    local elapsed = os.clock() - StartTime
    local percent = math.clamp(math.floor((elapsed / Duration) * 100),0,100)

    Percentage.Text = percent.."%"

    task.wait(0.04)
end

Percentage.Text = "100%"
Status.Text = "Pyrovex Hub is ready!"

-- FINISH EFFECT

Tween(MainStroke,{
    Color = Color3.fromRGB(80,220,160),
    Transparency = 0
},0.2)

Tween(Bar,{
    BackgroundColor3 = Color3.fromRGB(60,220,150)
},0.2)

task.wait(0.25)

-- LOADING EXIT

Tween(Main,{
    Position = UDim2.new(0.5,0,0,-85),
    BackgroundTransparency = 1
},0.65,Enum.EasingStyle.Quint,Enum.EasingDirection.In)

Tween(Settings,{TextTransparency = 1},0.35)
Tween(Title,{TextTransparency = 1},0.35)
Tween(Status,{TextTransparency = 1},0.35)
Tween(Percentage,{TextTransparency = 1},0.35)
Tween(BarBG,{BackgroundTransparency = 1},0.35)
Tween(Glow,{BackgroundTransparency = 1},0.35)

task.wait(0.7)

if ScreenGui then
    ScreenGui:Destroy()
end

local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local RS=game:GetService("RunService")
local TextService=game:GetService("TextService")
local LP=Players.LocalPlayer

local C={
BG=Color3.fromRGB(8,4,10),
P1=Color3.fromRGB(25,7,16),
P2=Color3.fromRGB(43,9,22),
Red=Color3.fromRGB(220,28,62),
Red2=Color3.fromRGB(255,65,90),
Purple=Color3.fromRGB(125,45,255),
Purple2=Color3.fromRGB(190,85,255),
White=Color3.fromRGB(248,242,246),
Gray=Color3.fromRGB(155,135,145),
Good=Color3.fromRGB(65,215,130),
Bad=Color3.fromRGB(255,55,80)
}

local Checking=false
local Minimized=false

local function Corner(o,r)
local x=Instance.new("UICorner")
x.CornerRadius=UDim.new(0,r)
x.Parent=o
end

local function Stroke(o,c,t,w)
local x=Instance.new("UIStroke")
x.Color=c
x.Transparency=t or 0
x.Thickness=w or 1
x.Parent=o
return x
end

local function Tween(o,t,p)
local x=TS:Create(
o,
TweenInfo.new(t,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),
p
)
x:Play()
return x
end

local function Button(parent,text,pos,size)
local b=Instance.new("TextButton")
b.Position=pos
b.Size=size
b.BackgroundColor3=C.P2
b.BorderSizePixel=0
b.Text=text
b.TextColor3=C.White
b.TextSize=8
b.Font=Enum.Font.GothamBold
b.AutoButtonColor=false
b.Parent=parent
Corner(b,8)
Stroke(b,C.Red,.45,1)
return b
end

local GUI=Instance.new("ScreenGui")
GUI.Name="PyrovexDebugger"
GUI.ResetOnSpawn=false
GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
GUI.Parent=(gethui and gethui()) or game:GetService("CoreGui")

-- ROOT

local Root=Instance.new("Frame")
Root.Size=UDim2.fromOffset(350,300)
Root.Position=UDim2.new(.5,-175,.5,-150)
Root.BackgroundTransparency=1
Root.Parent=GUI

-- LEFT SCRIPT EDITOR

local Editor=Instance.new("Frame")
Editor.Size=UDim2.fromOffset(170,300)
Editor.Position=UDim2.fromOffset(0,0)
Editor.BackgroundColor3=C.BG
Editor.BorderSizePixel=0
Editor.ClipsDescendants=true
Editor.Parent=Root

Corner(Editor,12)
Stroke(Editor,C.Purple,.12,1.3)

local EG=Instance.new("UIGradient")
EG.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(30,6,23)),
ColorSequenceKeypoint.new(.5,C.BG),
ColorSequenceKeypoint.new(1,Color3.fromRGB(10,3,12))
}
EG.Rotation=25
EG.Parent=Editor

-- SCRIPT SCROLLER

local Scroll=Instance.new("ScrollingFrame")
Scroll.Position=UDim2.fromOffset(5,5)
Scroll.Size=UDim2.new(1,-10,1,-10)
Scroll.BackgroundColor3=Color3.fromRGB(6,3,8)
Scroll.BorderSizePixel=0
Scroll.ClipsDescendants=true
Scroll.ScrollingDirection=Enum.ScrollingDirection.XY
Scroll.ScrollBarThickness=5
Scroll.ScrollBarImageColor3=C.Purple
Scroll.ScrollBarImageTransparency=.05
Scroll.HorizontalScrollBarInset=Enum.ScrollBarInset.ScrollBar
Scroll.VerticalScrollBarInset=Enum.ScrollBarInset.ScrollBar
Scroll.CanvasPosition=Vector2.new(0,0)
Scroll.CanvasSize=UDim2.fromOffset(20,20)
Scroll.Parent=Editor

Corner(Scroll,9)
Stroke(Scroll,C.Purple,.58,1)

-- TEXT BOX

local Box=Instance.new("TextBox")
Box.Position=UDim2.fromOffset(7,7)
Box.Size=UDim2.fromOffset(145,280)
Box.BackgroundTransparency=1
Box.BorderSizePixel=0
Box.ClearTextOnFocus=false
Box.MultiLine=true
Box.Text=""
Box.PlaceholderText="Paste Lua script here..."
Box.PlaceholderColor3=Color3.fromRGB(90,70,95)
Box.TextColor3=Color3.fromRGB(230,220,232)
Box.TextSize=9
Box.Font=Enum.Font.Code
Box.TextXAlignment=Enum.TextXAlignment.Left
Box.TextYAlignment=Enum.TextYAlignment.Top
Box.TextWrapped=false
Box.Parent=Scroll

-- SCROLL SIZE FIX

local function UpdateCanvas()
local viewportW=math.max(1,Scroll.AbsoluteSize.X-14)
local viewportH=math.max(1,Scroll.AbsoluteSize.Y-14)
local text=Box.Text

if text=="" then
	Box.Size=UDim2.fromOffset(viewportW,viewportH)
	Scroll.CanvasSize=UDim2.fromOffset(viewportW,viewportH)
	return
end

local bounds=TextService:GetTextSize(
	text,
	Box.TextSize,
	Box.Font,
	Vector2.new(100000,100000)
)

local textW=math.max(viewportW,bounds.X+25)
local textH=math.max(viewportH,bounds.Y+25)

Box.Size=UDim2.fromOffset(textW,textH)
Scroll.CanvasSize=UDim2.fromOffset(textW+14,textH+14)

end

Box:GetPropertyChangedSignal("Text"):Connect(function()
task.defer(UpdateCanvas)
end)

Scroll:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
task.defer(UpdateCanvas)
end)

-- RIGHT MENU

local Main=Instance.new("Frame")
Main.Size=UDim2.fromOffset(180,300)
Main.Position=UDim2.fromOffset(170,0)
Main.BackgroundColor3=C.BG
Main.BorderSizePixel=0
Main.ClipsDescendants=true
Main.Parent=Root

Corner(Main,12)
local MainStroke=Stroke(Main,C.Red,.1,1.3)

local MG=Instance.new("UIGradient")
MG.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(38,7,19)),
ColorSequenceKeypoint.new(.5,C.BG),
ColorSequenceKeypoint.new(1,Color3.fromRGB(10,3,11))
}
MG.Rotation=135
MG.Parent=Main

-- HEADER

local Logo=Instance.new("Frame")
Logo.Size=UDim2.fromOffset(34,34)
Logo.Position=UDim2.fromOffset(8,8)
Logo.BackgroundColor3=C.Red
Logo.BorderSizePixel=0
Logo.Parent=Main

Corner(Logo,10)
local LogoStroke=Stroke(Logo,C.Purple2,.1,1.1)

local LG=Instance.new("UIGradient")
LG.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,C.Red),
ColorSequenceKeypoint.new(.5,C.Purple),
ColorSequenceKeypoint.new(1,C.Red)
}
LG.Rotation=45
LG.Parent=Logo

local N=Instance.new("TextLabel")
N.Size=UDim2.fromScale(1,1)
N.BackgroundTransparency=1
N.Text="P"
N.TextColor3=C.White
N.TextSize=18
N.Font=Enum.Font.GothamBlack
N.Parent=Logo

local Title=Instance.new("TextLabel")
Title.Position=UDim2.fromOffset(48,8)
Title.Size=UDim2.new(1,-82,0,17)
Title.BackgroundTransparency=1
Title.Text="Pyrovex Hub"
Title.TextColor3=C.White
Title.TextSize=10
Title.Font=Enum.Font.GothamBold
Title.TextXAlignment=Enum.TextXAlignment.Left
Title.Parent=Main

local Sub=Instance.new("TextLabel")
Sub.Position=UDim2.fromOffset(49,24)
Sub.Size=UDim2.new(1,-53,0,12)
Sub.BackgroundTransparency=1
Sub.Text="by Kingflame/Pyrovex Team"
Sub.TextColor3=C.Gray
Sub.TextSize=5.5
Sub.Font=Enum.Font.Gotham
Sub.TextXAlignment=Enum.TextXAlignment.Left
Sub.TextTruncate=Enum.TextTruncate.AtEnd
Sub.Parent=Main

local Close=Button(
Main,
"×",
UDim2.new(1,-36,0,9),
UDim2.fromOffset(27,27)
)
Close.TextSize=15

-- STATUS

local Status=Instance.new("Frame")
Status.Position=UDim2.fromOffset(7,50)
Status.Size=UDim2.new(1,-14,0,48)
Status.BackgroundColor3=C.P1
Status.BorderSizePixel=0
Status.Parent=Main

Corner(Status,9)
Stroke(Status,C.Red,.55,1)

local ST=Instance.new("TextLabel")
ST.Position=UDim2.fromOffset(9,6)
ST.Size=UDim2.new(1,-18,0,10)
ST.BackgroundTransparency=1
ST.Text="STATUS"
ST.TextColor3=C.Gray
ST.TextSize=6
ST.Font=Enum.Font.GothamBold
ST.TextXAlignment=Enum.TextXAlignment.Left
ST.Parent=Status

local SV=Instance.new("TextLabel")
SV.Position=UDim2.fromOffset(9,21)
SV.Size=UDim2.new(1,-18,0,18)
SV.BackgroundTransparency=1
SV.Text="READY TO CHECK"
SV.TextColor3=C.White
SV.TextSize=8
SV.Font=Enum.Font.GothamBold
SV.TextXAlignment=Enum.TextXAlignment.Left
SV.Parent=Status

-- ANALYSIS

local Result=Instance.new("Frame")
Result.Position=UDim2.fromOffset(7,105)
Result.Size=UDim2.new(1,-14,0,91)
Result.BackgroundColor3=C.P1
Result.BorderSizePixel=0
Result.Parent=Main

Corner(Result,9)
Stroke(Result,C.Purple,.55,1)

local RTitle=Instance.new("TextLabel")
RTitle.Position=UDim2.fromOffset(9,6)
RTitle.Size=UDim2.new(1,-18,0,10)
RTitle.BackgroundTransparency=1
RTitle.Text="ANALYSIS"
RTitle.TextColor3=C.Gray
RTitle.TextSize=6
RTitle.Font=Enum.Font.GothamBold
RTitle.TextXAlignment=Enum.TextXAlignment.Left
RTitle.Parent=Result

local RScroll=Instance.new("ScrollingFrame")
RScroll.Position=UDim2.fromOffset(7,21)
RScroll.Size=UDim2.new(1,-14,1,-27)
RScroll.BackgroundTransparency=1
RScroll.BorderSizePixel=0
RScroll.ScrollingDirection=Enum.ScrollingDirection.Y
RScroll.ScrollBarThickness=3
RScroll.ScrollBarImageColor3=C.Purple
RScroll.CanvasSize=UDim2.fromOffset(0,0)
RScroll.Parent=Result

local RV=Instance.new("TextLabel")
RV.Position=UDim2.fromOffset(2,2)
RV.Size=UDim2.new(1,-8,0,50)
RV.BackgroundTransparency=1
RV.Text="No analysis yet."
RV.TextColor3=C.Gray
RV.TextSize=7
RV.Font=Enum.Font.Code
RV.TextWrapped=true
RV.TextXAlignment=Enum.TextXAlignment.Left
RV.TextYAlignment=Enum.TextYAlignment.Top
RV.Parent=RScroll

local function ResultText(text,color)
RV.Text=text
RV.TextColor3=color or C.Gray

task.defer(function()
	local h=RV.TextBounds.Y+12
	RV.Size=UDim2.new(1,-8,0,math.max(50,h))
	RScroll.CanvasSize=UDim2.fromOffset(0,h+5)
end)

end

-- BUTTON GRID

local Check=Button(
Main,
"CHECK SCRIPT",
UDim2.fromOffset(7,202),
UDim2.fromOffset(81,34)
)

local Clear=Button(
Main,
"CLEAR",
UDim2.fromOffset(92,202),
UDim2.fromOffset(81,34)
)

local Copy=Button(
Main,
"COPY",
UDim2.fromOffset(7,240),
UDim2.fromOffset(81,34)
)

local Reset=Button(
Main,
"RESET",
UDim2.fromOffset(92,240),
UDim2.fromOffset(81,34)
)

local Info=Instance.new("TextLabel")
Info.Position=UDim2.fromOffset(7,280)
Info.Size=UDim2.new(1,-14,0,10)
Info.BackgroundTransparency=1
Info.Text="Pyrovex Hub • Analysis Only"
Info.TextColor3=C.Gray
Info.TextSize=5.5
Info.Font=Enum.Font.Gotham
Info.TextXAlignment=Enum.TextXAlignment.Center
Info.Parent=Main

-- RESTORE BUTTON

local Restore=Instance.new("TextButton")
Restore.Size=UDim2.fromOffset(50,50)
Restore.Position=UDim2.new(.5,-25,0,12)
Restore.BackgroundColor3=C.Red
Restore.BorderSizePixel=0
Restore.Text="P"
Restore.TextColor3=C.White
Restore.TextSize=20
Restore.Font=Enum.Font.GothamBlack
Restore.AutoButtonColor=false
Restore.Visible=false
Restore.Parent=GUI

Corner(Restore,14)
local RestoreStroke=Stroke(Restore,C.Purple2,.1,1.3)

local RG=Instance.new("UIGradient")
RG.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,C.Red),
ColorSequenceKeypoint.new(.5,C.Purple),
ColorSequenceKeypoint.new(1,C.Red)
}
RG.Rotation=45
RG.Parent=Restore

-- HOVER

local function Hover(b)
b.MouseEnter:Connect(function()
Tween(b,.13,{
BackgroundColor3=Color3.fromRGB(68,12,34)
})
end)

b.MouseLeave:Connect(function()
	Tween(b,.13,{
		BackgroundColor3=C.P2
	})
end)

end

Hover(Check)
Hover(Clear)
Hover(Copy)
Hover(Reset)
Hover(Close)

-- DRAG ROOT

local function Drag(frame)
local dragging=false
local startPos
local startRoot

frame.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1
	or input.UserInputType==Enum.UserInputType.Touch then
		dragging=true
		startPos=input.Position
		startRoot=Root.Position

		input.Changed:Connect(function()
			if input.UserInputState==Enum.UserInputState.End then
				dragging=false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if not dragging then return end

	if input.UserInputType==Enum.UserInputType.MouseMovement
	or input.UserInputType==Enum.UserInputType.Touch then
		local delta=input.Position-startPos

		Root.Position=UDim2.new(
			startRoot.X.Scale,
			startRoot.X.Offset+delta.X,
			startRoot.Y.Scale,
			startRoot.Y.Offset+delta.Y
		)
	end
end)

end

Drag(Main)

-- COMPILE-ONLY LUA CHECK
-- DOES NOT EXECUTE THE SCRIPT

local function Analyze(code)
local errors={}

if code=="" or code:match("^%s*$") then
	table.insert(errors,"Script input is empty.")
	return errors
end

if type(loadstring)=="function" then
	local fn,err=loadstring(code)

	if fn then
		return errors
	end

	table.insert(errors,tostring(err or "Lua syntax error."))
	return errors
end

-- FALLBACK CHECKER
-- Basic checks only; not a full Lua parser.

local function count(pattern)
	local n=0
	for _ in code:gmatch(pattern) do
		n+=1
	end
	return n
end

if code:match("===") then
	table.insert(errors,"Possible invalid '===' operator.")
end

if count("%(")~=count("%)") then
	table.insert(errors,"Possible unmatched parentheses.")
end

if count("%[")~=count("%]") then
	table.insert(errors,"Possible unmatched square brackets.")
end

if count("{")~=count("}") then
	table.insert(errors,"Possible unmatched curly brackets.")
end

local functionCount=count("%f[%a]function%f[%A]")
local ifCount=count("%f[%a]if%f[%A]")
local forCount=count("%f[%a]for%f[%A]")
local whileCount=count("%f[%a]while%f[%A]")
local doCount=count("%f[%a]do%f[%A]")
local endCount=count("%f[%a]end%f[%A]")

local blocks=
	functionCount+
	ifCount+
	forCount+
	whileCount+
	doCount

if endCount>blocks then
	table.insert(errors,"Possible unexpected 'end' keyword.")
elseif blocks>endCount then
	table.insert(errors,"Possible missing 'end' keyword.")
end

return errors

end

-- CHECK SCRIPT

Check.MouseButton1Click:Connect(function()
if Checking then return end

Checking=true
Check.Text="CHECKING..."
SV.Text="ANALYZING..."
SV.TextColor3=C.Purple2

ResultText("Scanning Lua syntax...",C.Gray)

task.wait(.35)

local errors=Analyze(Box.Text)

if #errors==0 then
	SV.Text="NO ERROR FOUND"
	SV.TextColor3=C.Good

	ResultText(
		"✓ No syntax errors found.\n\nCompile check completed.",
		C.Good
	)
else
	SV.Text="ERROR FOUND"
	SV.TextColor3=C.Bad

	local output="Errors found: "..#errors.."\n\n"

	for i,v in ipairs(errors) do
		output=output..i..". "..v.."\n"
	end

	ResultText(output,C.Bad)
end

Check.Text="CHECK SCRIPT"
Checking=false

end)

-- CLEAR

Clear.MouseButton1Click:Connect(function()
Box.Text=""
Scroll.CanvasPosition=Vector2.new(0,0)

SV.Text="READY TO CHECK"
SV.TextColor3=C.White

ResultText("No analysis yet.",C.Gray)

end)

-- COPY

Copy.MouseButton1Click:Connect(function()
if Box.Text=="" then
SV.Text="NOTHING TO COPY"
SV.TextColor3=C.Bad
return
end

if setclipboard then
	local ok=pcall(function()
		setclipboard(Box.Text)
	end)

	if ok then
		SV.Text="COPIED"
		SV.TextColor3=C.Good
	else
		SV.Text="COPY FAILED"
		SV.TextColor3=C.Bad
	end
else
	SV.Text="COPY NOT AVAILABLE"
	SV.TextColor3=C.Bad
end

task.delay(1,function()
	if GUI.Parent then
		SV.Text="READY TO CHECK"
		SV.TextColor3=C.White
	end
end)

end)

-- RESET

Reset.MouseButton1Click:Connect(function()
Box.Text=""
Scroll.CanvasPosition=Vector2.new(0,0)
RScroll.CanvasPosition=Vector2.new(0,0)

SV.Text="READY TO CHECK"
SV.TextColor3=C.White

ResultText("No analysis yet.",C.Gray)

end)

-- CLOSE / MINIMIZE

Close.MouseButton1Click:Connect(function()
if Minimized then return end
Minimized=true

Tween(Root,.25,{
	Size=UDim2.fromOffset(5,5)
})

task.wait(.22)

Root.Visible=false
Restore.Visible=true
Restore.Size=UDim2.fromOffset(8,8)
Restore.BackgroundTransparency=1

Tween(Restore,.3,{
	Size=UDim2.fromOffset(50,50),
	BackgroundTransparency=0
})

end)

-- RESTORE

Restore.MouseButton1Click:Connect(function()
if not Minimized then return end
Minimized=false

Restore.Visible=false
Root.Visible=true
Root.Size=UDim2.fromOffset(5,5)

Tween(Root,.32,{
	Size=UDim2.fromOffset(350,300)
})

task.defer(UpdateCanvas)

end)

-- RESTORE BUTTON DRAG

do
local dragging=false
local startPos
local startRestore

Restore.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1
	or input.UserInputType==Enum.UserInputType.Touch then
		dragging=true
		startPos=input.Position
		startRestore=Restore.Position

		input.Changed:Connect(function()
			if input.UserInputState==Enum.UserInputState.End then
				dragging=false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if not dragging then return end

	if input.UserInputType==Enum.UserInputType.MouseMovement
	or input.UserInputType==Enum.UserInputType.Touch then
		local delta=input.Position-startPos

		Restore.Position=UDim2.new(
			startRestore.X.Scale,
			startRestore.X.Offset+delta.X,
			startRestore.Y.Scale,
			startRestore.Y.Offset+delta.Y
		)
	end
end)

end

-- ANIMATION

local t=0

RS.RenderStepped:Connect(function(dt)
if not GUI.Parent then return end

t+=dt
local v=(math.sin(t*2)+1)/2

MainStroke.Color=C.Red:Lerp(C.Purple,v)
LogoStroke.Color=C.Purple2:Lerp(C.Red,v)
RestoreStroke.Color=C.Red:Lerp(C.Purple2,v)

end)

task.defer(UpdateCanvas)
