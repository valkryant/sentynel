local exec = Instance.new("ScreenGui")
local Executor = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Down = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local EditorScroller = Instance.new("ScrollingFrame")
local Editor = Instance.new("TextBox")
local UIListLayout = Instance.new("UIListLayout")
local Clear = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
local Copy = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
local Execute = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint")
local TopBar = Instance.new("TextLabel")
local UICorner_6 = Instance.new("UICorner")
local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint")
local Exit = Instance.new("TextButton")
local ImageLabel = Instance.new("ImageLabel")
local Minimize = Instance.new("TextButton")
local ImageLabel_2 = Instance.new("ImageLabel")

exec.Name = "exec"
exec.Parent = gethui() or (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"))
exec.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
exec.ResetOnSpawn = false

Executor.Name = "Executor"
Executor.Parent = exec
Executor.Active = true
Executor.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
Executor.BackgroundTransparency = 0.120
Executor.ClipsDescendants = true
Executor.Draggable = true
Executor.Position = UDim2.new(0.307999998, 0, 2, 0)
Executor.Size = UDim2.new(0, 481, 0, 287)

UICorner.Parent = Executor

Down.Name = "Down"
Down.Parent = Executor
Down.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Down.BackgroundTransparency = 0.700
Down.Position = UDim2.new(0, 0, 0, 281)
Down.Size = UDim2.new(0, 480, 0, 6)

UICorner_2.Parent = Down

UIAspectRatioConstraint.Parent = Down
UIAspectRatioConstraint.AspectRatio = 80.000

EditorScroller.Name = "EditorScroller"
EditorScroller.Parent = Executor
EditorScroller.Active = true
EditorScroller.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
EditorScroller.BackgroundTransparency = 0.600
EditorScroller.BorderSizePixel = 0
EditorScroller.Position = UDim2.new(0, 9, 0, 47)
EditorScroller.Size = UDim2.new(0, 465, 0, 191)
EditorScroller.ScrollBarThickness = 5

Editor.Name = "Editor"
Editor.Parent = EditorScroller
Editor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Editor.BackgroundTransparency = 1.000
Editor.Size = UDim2.new(1, 0, 0, 191)
Editor.ClearTextOnFocus = false
Editor.Font = Enum.Font.SourceSans
Editor.MultiLine = true
Editor.Text = ""
Editor.TextColor3 = Color3.fromRGB(255, 255, 255)
Editor.TextSize = 20.000
Editor.TextWrapped = true
Editor.TextXAlignment = Enum.TextXAlignment.Left
Editor.TextYAlignment = Enum.TextYAlignment.Top

UIListLayout.Parent = EditorScroller
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Clear.Name = "Clear"
Clear.Parent = Executor
Clear.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Clear.BackgroundTransparency = 0.600
Clear.Position = UDim2.new(0, 182, 0, 248)
Clear.Size = UDim2.new(0, 102, 0, 25)
Clear.Font = Enum.Font.SourceSans
Clear.Text = "Clear"
Clear.TextColor3 = Color3.fromRGB(255, 255, 255)
Clear.TextSize = 20.000

UICorner_3.Parent = Clear

UIAspectRatioConstraint_2.Parent = Clear
UIAspectRatioConstraint_2.AspectRatio = 4.080

Copy.Name = "Copy"
Copy.Parent = Executor
Copy.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Copy.BackgroundTransparency = 0.600
Copy.Position = UDim2.new(0, 294, 0, 248)
Copy.Size = UDim2.new(0, 102, 0, 25)
Copy.Font = Enum.Font.SourceSans
Copy.Text = "Copy"
Copy.TextColor3 = Color3.fromRGB(255, 255, 255)
Copy.TextSize = 20.000

UICorner_4.Parent = Copy

UIAspectRatioConstraint_3.Parent = Copy
UIAspectRatioConstraint_3.AspectRatio = 4.080

Execute.Name = "Execute"
Execute.Parent = Executor
Execute.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Execute.BackgroundTransparency = 0.600
Execute.Position = UDim2.new(0, 70, 0, 248)
Execute.Size = UDim2.new(0, 102, 0, 25)
Execute.Font = Enum.Font.SourceSans
Execute.Text = "Execute"
Execute.TextColor3 = Color3.fromRGB(255, 255, 255)
Execute.TextSize = 20.000

UICorner_5.Parent = Execute

UIAspectRatioConstraint_4.Parent = Execute
UIAspectRatioConstraint_4.AspectRatio = 4.080

TopBar.Name = "TopBar"
TopBar.Parent = Executor
TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopBar.BackgroundTransparency = 0.600
TopBar.Position = UDim2.new(0.00207900209, 0, 0, 0)
TopBar.Size = UDim2.new(0, 481, 0, 35)
TopBar.Font = Enum.Font.SourceSansItalic
TopBar.Text = "Executor"
TopBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBar.TextSize = 25.000

UICorner_6.Parent = TopBar

UIAspectRatioConstraint_5.Parent = TopBar
UIAspectRatioConstraint_5.AspectRatio = 13.743

Exit.Name = "Exit"
Exit.Parent = TopBar
Exit.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
Exit.BackgroundTransparency = 0.500
Exit.BorderSizePixel = 0
Exit.Position = UDim2.new(0.869999945, 0, 0.0857151747, 0)
Exit.Size = UDim2.new(0.0138690183, 40, 0.842997849, -10)
Exit.Font = Enum.Font.Gotham
Exit.Text = "X"
Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
Exit.TextSize = 13.000

ImageLabel.Parent = Exit
ImageLabel.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Position = UDim2.new(0.999998331, 0, 0, 0)
ImageLabel.Size = UDim2.new(0, 9, 0, 16)
ImageLabel.Image = "http://www.roblox.com/asset/?id=8650484523"
ImageLabel.ImageColor3 = Color3.fromRGB(12, 4, 20)
ImageLabel.ImageTransparency = 0.500

Minimize.Name = "Minimize"
Minimize.Parent = TopBar
Minimize.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
Minimize.BackgroundTransparency = 0.500
Minimize.BorderSizePixel = 0
Minimize.Position = UDim2.new(0.781519771, 0, -4.35969923e-07, 0)
Minimize.Size = UDim2.new(0.0194963068, 27, 0.928713143, -10)
Minimize.Font = Enum.Font.Gotham
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextSize = 18.000

ImageLabel_2.Parent = Minimize
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_2.BackgroundTransparency = 1.000
ImageLabel_2.Position = UDim2.new(-0.441000015, 0, 0, 0)
ImageLabel_2.Size = UDim2.new(0, 12, 0, 16)
ImageLabel_2.Image = "http://www.roblox.com/asset/?id=10555881849"
ImageLabel_2.ImageColor3 = Color3.fromRGB(12, 4, 20)
ImageLabel_2.ImageTransparency = 0.500

-- Scripts:

local function TJUXECO_fake_script()
	Executor.Active = true
	Executor.Draggable = true
	exec.ResetOnSpawn = false
end
coroutine.wrap(TJUXECO_fake_script)()
local function CZXUM_fake_script()
	Executor:TweenPosition(UDim2.new(0.308, 0,0.262, 0), "Out", "Quint",1,true)
end
coroutine.wrap(CZXUM_fake_script)()
local function INJLLH_fake_script()
	Clear.MouseButton1Click:Connect(function()
		Clear.Parent.EditorScroller.Editor.Text = ""
	end)
end
coroutine.wrap(INJLLH_fake_script)()
local function IQOSZN_fake_script() -- Copy.LocalScript 
	Copy.MouseButton1Click:Connect(function()
		setclipboard(Editor.Text)
	end)
end
coroutine.wrap(IQOSZN_fake_script)()
local function MVBS_fake_script() -- Execute.LocalScript 
	Execute.MouseButton1Click:Connect(function()
		assert(loadstring(Editor.Text))()
	end)
end
coroutine.wrap(MVBS_fake_script)()
local function VLSJXUV_fake_script() -- Exit.LocalScript 
	local editor =Editor
	
	local con1, con2 = nil, nil
	
	Exit.MouseButton1Click:Connect(function()
		if con1 then con1:Disconnect() con1 = nil end
		if con2 then con2:Disconnect() con2 = nil end
		Exit.Parent.Parent.Parent:Destroy()
	end)
	
	local function updTxtScale()
		local width = editor.AbsoluteSize.X
		local text = editor.Text
		local font = editor.Font
		local textSize = editor.TextSize
		local textBounds = game:GetService("TextService"):GetTextSize(text, textSize, font, Vector2.new(width, math.huge))
	
		if textBounds.Y <= 200 then
			editor.Size = UDim2.new(1, 0, 0, 200)
		else
			editor.Size = UDim2.new(1, 0, 0, textBounds.Y+15)
		end
	end
	
	con1 = editor:GetPropertyChangedSignal("Text"):Connect(updTxtScale)
	
	con2 = game:GetService("RunService").Stepped:Connect(function()
		editor.Parent.CanvasSize = UDim2.new(0, 0, 0, editor.Parent:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y+30)
	end)
	
	updTxtScale()
end
coroutine.wrap(VLSJXUV_fake_script)()
local function PWJRPAS_fake_script() -- Minimize.LocalScript 
	p = false
	Minimize.MouseButton1Click:Connect(function()
		if not p then
			p = not p
			Minimize.Parent.Parent:TweenSize(UDim2.new(0, 481, 0, 35), "Out", "Quint", 1, true)
		else
			p = not p
			Minimize.Parent.Parent:TweenSize(UDim2.new(0, 481, 0, 287), "Out", "Quint", 1, true)
		end
	end)
end
coroutine.wrap(PWJRPAS_fake_script)()
