if getgenv().Real0x4Loaded then return end

local function NACaller(pp)--helps me log better
	local s,err=pcall(pp)
	if not s then warn("NA script err: "..err) end
end



local NAbegin=tick()

NACaller(function() getgenv().Real0x4Loaded=true end)
NACaller(function() getgenv().NATestingVer=false end)

--[[ Version ]]--
local curVer=2.2

--[[ Brand ]]--
local mainName='0x4F27A8C9'
local testingName='0x4'
local adminName='0x'
if getgenv().NATestingVer then
	adminName=testingName
else
	adminName=mainName
end

if not gethui then
	getgenv().gethui=function()
		local h=(SafeGetService("CoreGui"):FindFirstChildWhichIsA("ScreenGui") or SafeGetService("CoreGui") or SafeGetService("Players").LocalPlayer:FindFirstChild("PlayerGui"))
		return h
	end
end

if identifyexecutor()=="Solara" or not fireproximityprompt then -- proximity prompt fix | Credits: Benomat (https://scriptblox.com/u/benomat)
	getgenv().fireproximityprompt=function(pp)
		local oldenabled=pp.Enabled
		local oldhold=pp.HoldDuration
		local oldrlos=pp.RequiresLineOfSight
		pp.Enabled=true
		pp.HoldDuration=0
		pp.RequiresLineOfSight=false
		wait(.23)
		pp:InputHoldBegin()
		task.wait()
		pp:InputHoldEnd()
		wait(.1)
		pp.Enabled=pp.Enabled
		pp.HoldDuration=pp.HoldDuration
		pp.RequiresLineOfSight=pp.RequiresLineOfSight
	end
end

local GetService=game.GetService
local iamcore=gethui()
local NA_storage=Instance.new("ScreenGui")--Stupid Ahh script removing folders
if not game:IsLoaded() then
	local waiting=Instance.new("Message")
	waiting.Parent=iamcore
	waiting.Text=adminName..' is waiting for the game to load'
	game.Loaded:Wait()
	waiting:Destroy()
end
local loader=''
if getgenv().NATestingVer then
	loader=[[loadstring(game:HttpGet("https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/testbuild.lua"))();]]
else
	loader=[[loadstring(game:HttpGet("https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/src.lua"))();]]
end
local queueteleport=(syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport) or function() end

--Notification library
local Notification=nil

repeat 
	local s,r=pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/notifs.lua"))()
	end);

	if s then
		Notification=r;
	else
		warn("Couldn't load notification module, retrying...");
		task.wait();
	end
until Notification~=nil --waits for the module to load (cause loadstring takes ages)

local Notify=Notification.Notify;

local function DoNotif(txt,dur,naem)
	if not dur then dur=5 end
	if not naem then naem=adminName end
	Notify({
		Description=txt;
		Title=naem;
		Duration=dur;
	});
end

wait();--added wait due to the Http being a bit delayed on returning

--Custom file functions checker checker
local CustomFunctionSupport=isfile and isfolder and writefile and readfile and listfiles;
local FileSupport=isfile and isfolder and writefile and readfile and makefolder;

--Creates folder & files for Prefix & Plugins
if FileSupport then
	if not isfolder('0x4') then
		makefolder('0x4')
	else
	end

	if not isfile("0x4/Prefix.txt") then
		writefile("0x4/Prefix.txt",';')
	else
	end
end
local prefixCheck=";"
if FileSupport then
	prefixCheck=readfile("0x4/Prefix.txt",';')
else
	prefixCheck=";"
	DoNotif("Your exploit does not support read/write file",5)
end
--[[ PREFIX AND OTHER STUFF. ]]--
local opt={
	prefix=prefixCheck,
	tupleSeparator=',',
	ui={},
	keybinds={},
}

--[[ Update Logs ]]--
local updLogs={
	log1="Added Tween Fly commands ('tfly','tweenfly')";
	log2="Fixed small bugs";
	log3="Updated 'Antivoid' command";
	log4="Updated 'fly' command (bypasses most anticheats on games)";
	log5="Added 'serverlist' command (shows a list of servers to join in)";
}

local updDate="30/12/2024" --

--[[ VARIABLES ]]--
local cloneref = cloneref or blankfunction

if not cloneref then
	getgenv().cloneref=function(service)
		return game:GetService(service)
	end
end

local function SafeGetService(service)
	return cloneref(game:GetService(service))
end

local PlaceId,JobId,GameId=game.PlaceId,game.JobId,game.GameId
local Players=SafeGetService("Players");
local UserInputService=SafeGetService("UserInputService");
local vim=SafeGetService("VirtualInputManager");
local AssetService=SafeGetService("AssetService");
local ProximityPromptService=SafeGetService("ProximityPromptService");
local TweenService=SafeGetService("TweenService");
local RunService=SafeGetService("RunService");
local TeleportService=SafeGetService("TeleportService");
local HttpService=SafeGetService('HttpService');
local RunService2=SafeGetService("RunService");
local StarterGui=SafeGetService("StarterGui");
local SoundService=SafeGetService("SoundService");
local Lighting=SafeGetService("Lighting");
local ReplicatedStorage=SafeGetService("ReplicatedStorage");
local GuiService=SafeGetService("GuiService");
local COREGUI=gethui();
local CoreGui=gethui();
local coregui=gethui();
local IsOnMobile=false--table.find({Enum.Platform.IOS,Enum.Platform.Android},UserInputService:GetPlatform());
local IsOnPC=false--table.find({Enum.Platform.Windows,Enum.Platform.UWP,Enum.Platform.Linux,Enum.Platform.SteamOS,Enum.Platform.OSX,Enum.Platform.Chromecast,Enum.Platform.WebOS},UserInputService:GetPlatform());
local sethidden=sethiddenproperty or set_hidden_property or set_hidden_prop
local Player=SafeGetService("Players").LocalPlayer;
local plr=SafeGetService("Players").LocalPlayer;
local PlrGui=Player:FindFirstChild("PlayerGui");
local speaker=Player
local IYLOADED=false--This is used for the ;iy command that executes infinite yield commands using this admin command script (BTW)
local Character=Player.Character;
local Humanoid=Character and Character:FindFirstChildWhichIsA("Humanoid") or false
local Clicked=true
local LegacyChat=SafeGetService("TextChatService").ChatVersion==Enum.ChatVersion.LegacyChatService
_G.Spam=false
--[[ FOR LOOP COMMANDS ]]--
local view=false
local anniblockspam=false
local control=false
local FakeLag=false
local Loopvoid=false
local Loopkill=false
local Loopbring=false
local Loopbanish=false
local Loopvoid=false
local Loopcuff=false
local loopgrab=false
local Loopstand=false
local Looptornado=false
local Loopmute=false
local Loopglitch=false
local OrgDestroyHeight = SafeGetService("Workspace").FallenPartsDestroyHeight
local Watch=false
local Admin={}
_G.NAadminsLol={
	156256804;--v3r
	530829101;--Viper
	229501685;--legshot
	3470956640;--Bart3kk
	1456118719;--zzz
	817571515;--Aimlock
	144324719;--Cosmic
	1844177730;--glexinator
	2624269701;--Akim
	2502806181; -- null
	1594235217; -- Purple
}

if UserInputService.TouchEnabled then
	IsOnMobile=true
end

if UserInputService.KeyboardEnabled then
	IsOnPC=true
end

--[[ Some more variables ]]--

local localPlayer=Player
local LocalPlayer=Player
local character=Player.Character
local mouse=localPlayer:GetMouse()
local camera=SafeGetService("Workspace").CurrentCamera
local camtype=camera.CameraType
local Commands,Aliases={},{}
local player,plr,lp=SafeGetService("Players").LocalPlayer,SafeGetService("Players").LocalPlayer,SafeGetService("Players").LocalPlayer

local bringc={}

--[[ Welcome Messages ]]--
local msg={
	"Hey";
	"Hello";
	"Hi";
	"Hi There";
	"Hola";
}

--[[ Goofy Text ]]--
local Goofer={
	"Egg";
	"i am a goofy goober";
	"mmmm lasagna";
	"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
	"i am wondering if i even have a life";
	"[REDACTED]";
	"hey guys welcome to another video";
	"⚠️⚠️⚠️";
	":-(";
	"(╯°□°)╯︵ ┻━┻";
	"freaky";
	"unreal";
	"💀💀💀";
	"X_X";
	"not bothered to add a message here";
}

--[[ Prediction ]]--
function levenshtein(s,t)
	local d={}
	local lenS,lenT=#s,#t
	for i=0,lenS do
		d[i]={}
		d[i][0]=i
	end
	for j=0,lenT do
		d[0][j]=j
	end
	for i=1,lenS do
		for j=1,lenT do
			local cost=(s:sub(i,i)==t:sub(j,j)) and 0 or 1
			d[i][j]=math.min(d[i-1][j]+1,d[i][j-1]+1,d[i-1][j-1]+cost)
		end
	end
	return d[lenS][lenT]
end

function didYouMean(arg)
	local closer=nil
	local min=math.huge

	for cmd in pairs(Commands) do
		local j=levenshtein(arg,cmd)
		if j<min then
			min=j
			closer=cmd
		end
	end

	for alias in pairs(Aliases) do
		local j=levenshtein(arg,alias)
		if j<min then
			min=j
			closer=alias
		end
	end

	return closer
end

function isRelAdmin(Player)
	for _,id in ipairs(_G.NAadminsLol) do
		if id==SafeGetService("Players").LocalPlayer.UserId then
			return false
		elseif Player.UserId==id then
			return true
		end
	end
	return false
end

function loadedResults(res)
	if res==nil then res=0 end
	local sec=tonumber(res)
	local hr=math.floor(sec / 3600)
	local min=math.floor((sec % 3600) / 60)
	local remain=sec % 60
	local format=''
	if hr > 0 then
		format=string.format("%d:%02d:%05.2f | Hours,Minutes,Seconds",hr,min,remain)
	elseif min > 0 then
		format=string.format("%d:%05.2f | Minutes,Seconds",min,remain)
	else
		format=string.format("%.2f | Seconds",remain)
	end
	return format
end


--[[ COMMAND FUNCTIONS ]]--
local commandcount=0
cmd={}
cmd.add=function(...)
	local vars={...}
	local aliases,info,func=vars[1],vars[2],vars[3]
	for i,cmdName in pairs(aliases) do
		if i==1 then
			Commands[cmdName:lower()]={func,info}
		else
			Aliases[cmdName:lower()]={func,info}
		end
	end
	commandcount=commandcount+1
end

cmd.run=function(args)
	local caller,arguments=args[1],args; table.remove(args,1);

	local success,msg=pcall(function()
		local command=Commands[caller:lower()] or Aliases[caller:lower()]
		if command then
			command[1](unpack(arguments))
		else
			local closest=didYouMean(caller:lower())
			if closest then
				DoNotif("Command [ "..caller.." ] doesn't exist\nDid you mean [ "..closest.." ]?",4)
			else
			end
		end
	end)
	if not success then warn(adminName..": "..msg) end
end

function randomString()
	local length=math.random(10,20)
	local array={}
	for i=1,length do
		array[i]=string.char(math.random(32,126))
	end
	return table.concat(array)
end

function NAProtection(inst,var)
	if inst then
		if var then
			inst[var]="\0"
			inst.Archivable=false
		else
			inst.Name="\0"
			inst.Archivable=false
		end
	end
end

NA_storage.Name=randomString()
NA_storage.Parent=iamcore

--[[ LIBRARY FUNCTIONS ]]--
local lib={}
lib.wrap=function(f)
	return coroutine.wrap(f)()
end

local wrap=lib.wrap

local wait=function(int)
	if not int then int=0 end
	local t=tick()
	repeat
		RunService.Heartbeat:Wait(0)
	until (tick()-t) >=int
	return (tick()-t),t
end

function r15(plr)
	plr=(plr or SafeGetService("Players").LocalPlayer)
	if plr then
		if plr.Character:FindFirstChildOfClass('Humanoid').RigType==Enum.HumanoidRigType.R15 then
			return true
		end
	end
	return false
end

function r6(Player)
	Player=(Player or SafeGetService("Players").LocalPlayer)
	if Player then
		if Player.Character.Humanoid.RigType==Enum.HumanoidRigType.R6 then
			return true
		end
	end
	return false
end

function rngMsg()
	return msg[math.random(1,#msg)]
end

function goof()
	return Goofer[math.random(1,#Goofer)]
end

function getRoot(char)
	local rootPart=char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function getChar()
	return SafeGetService("Players").LocalPlayer.Character
end

function getPlrChar(plr)
	local isChar=SafeGetService("Players")[plr].Character
	if isChar then
		return isChar
	else
		return false
	end
end

function getBp()
	return SafeGetService("Players").LocalPlayer:FindFirstChildOfClass("Backpack")
end

function getHum()
	if SafeGetService("Players").LocalPlayer and getChar() and getChar():FindFirstChildOfClass("Humanoid") then
		return getChar():FindFirstChildOfClass("Humanoid")
	else
		return false
	end
end

function getPlrHum(plr)
	if plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
		return getChar():FindFirstChildOfClass("Humanoid")
	else
		return false
	end
end

function isNumber(str)
	if tonumber(str)~=nil or str=='inf' then
		return true
	end
end

function FindInTable(tbl,val)
	if tbl==nil then return false end
	for _,v in pairs(tbl) do
		if v==val then return true end
	end 
	return false
end

function GetInTable(Table,Name)
	for i=1,#Table do
		if Table[i]==Name then
			return i
		end
	end
	return false
end

--[[ FUNCTION TO GET A PLAYER ]]--
local getPlr=function(Name)
	if Name:lower()=="random" then
		return Players:GetPlayers()[math.random(#Players:GetPlayers())]
	elseif Name:lower()=="me" then
		return SafeGetService("Players").LocalPlayer
	elseif not Name then
		return SafeGetService("Players").LocalPlayer
	elseif Name:lower()=="friends" then
		local friends={}
		for _,plr in pairs(Players:GetPlayers()) do
			if plr:IsFriendsWith(LocalPlayer.UserId) and plr~=LocalPlayer then
				table.insert(friends,plr)
			end
		end
		return friends
	elseif Name:lower()=="nonfriends" then
		local noFriends={}
		for _,plr in pairs(Players:GetPlayers()) do
			if not plr:IsFriendsWith(LocalPlayer.UserId) and plr~=LocalPlayer then
				table.insert(noFriends,plr)
			end
		end
		return noFriends
	elseif Name:lower()=="enemies" then
		local nonTeam={}
		local team=LocalPlayer.Team
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team~=team then
				table.insert(nonTeam,plr)
			end
		end
		return nonTeam
	elseif Name:lower()=="allies" then
		local teamBuddies={}
		local team=LocalPlayer.Team
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Team==team then
				table.insert(teamBuddies,plr)
			end
		end
		return teamBuddies
	else
		Name=Name:lower():gsub("%s","")
		for _,x in next,Players:GetPlayers() do
			if x.Name:lower():match(Name) then
				return x
			elseif x.DisplayName:lower():match("^"..Name) then
				return x
			end
		end
	end
end

--[[ MORE VARIABLES ]]--
local plr=Player
local speaker=Player
local char=plr.Character
local JSONEncode,JSONDecode=HttpService.JSONEncode,HttpService.JSONDecode
local con=game.Loaded.Connect
local LoadTime=tick();

NACaller(function()
	Players.LocalPlayer.CharacterAdded:Connect(function(c)
		character=c
		Character=c
		char=c
	end)
end)

RunService.Stepped:connect(function()
	if anniblockspam then
		SafeGetService("Workspace").Tools.Chest_Invisibility_Cloak.Part.CFrame=CFrame.new(getRoot(getChar()).Position)

		if SafeGetService("Players").LocalPlayer.Backpack:FindFirstChild("InvisibilityCloak") then
			getChar().Humanoid:EquipTool(SafeGetService("Players").LocalPlayer.Backpack.InvisibilityCloak)
		end

		for i,v in pairs(getChar():GetChildren()) do
			if (v:IsA("Tool")) then
				v.Handle.Mesh:Destroy()
			end
		end

		for i,v in pairs(getChar():GetChildren()) do
			if (v:IsA("Tool")) then
				v.Parent=SafeGetService("Workspace")
			end
		end

	end
end)

local ESPenabled=false


function round(num,numDecimalPlaces)
	local mult=10^(numDecimalPlaces or 0)
	return math.floor(num*mult+0.5) / mult
end

function getIdentity()--returns the number of the identity
	local LogService=SafeGetService("LogService")
	local output=""
	local con=nil
	con=LogService.MessageOut:Connect(function(msg,msgType)
		if msgType==Enum.MessageType.MessageOutput then
			local identityNum=msg:lower():match("current identity is (%d+)")
			if identityNum then
				output=identityNum
				con:Disconnect()
			end
		end
	end)
	printidentity()
	task.wait();

	return output
end

local function placeName()
	local page=SafeGetService("AssetService"):GetGamePlacesAsync()
	while true do
		for _,place in ipairs(page:GetCurrentPage()) do
			if place.PlaceId==PlaceId then
				return place.Name
			end
		end
		if page.IsFinished then
			break
		end
		page:AdvanceToNextPageAsync()
	end
	return "unknown"
end

function removeESP()
	for i,c in pairs(COREGUI:GetChildren()) do
		if string.sub(c.Name,-4)=='_ESP' then
			c:Destroy()
		end
	end
end

function ESP(plr)
	task.spawn(function()
		for i,v in pairs(COREGUI:GetChildren()) do
			if v.Name==plr.Name..'_ESP' then
				v:Destroy()
			end
		end
		wait()
		if plr.Character and plr.Name~=Players.LocalPlayer.Name and not COREGUI:FindFirstChild(plr.Name..'_ESP') then
			local ESPholder=Instance.new("Folder")
			ESPholder.Name=plr.Name..'_ESP'
			ESPholder.Parent=COREGUI
			repeat wait(1) until plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")

			local a=Instance.new("Highlight")
			a.Name=plr.Name
			a.Parent=ESPholder
			a.Adornee=plr.Character
			a.FillTransparency=0.45
			a.FillColor=Color3.fromRGB(0,255,0)

			if plr.Character and plr.Character:FindFirstChild('Head') then
				local BillboardGui=Instance.new("BillboardGui")
				local TextLabel=Instance.new("TextLabel")
				BillboardGui.Adornee=plr.Character.Head
				BillboardGui.Name=plr.Name
				BillboardGui.Parent=ESPholder
				BillboardGui.Size=UDim2.new(0,100,0,150)
				BillboardGui.StudsOffset=Vector3.new(0,1,0)
				BillboardGui.AlwaysOnTop=true
				TextLabel.Parent=BillboardGui
				TextLabel.BackgroundTransparency=1
				TextLabel.Position=UDim2.new(0,0,0,-50)
				TextLabel.Size=UDim2.new(0,100,0,100)
				TextLabel.Font=Enum.Font.SourceSansSemibold
				TextLabel.TextSize=17
				TextLabel.TextColor3=Color3.new(12,4,20)
				TextLabel.TextStrokeTransparency=0.3
				TextLabel.TextYAlignment=Enum.TextYAlignment.Bottom
				TextLabel.Text='@'..plr.Name..' | '..plr.DisplayName..''
				TextLabel.ZIndex=10
				local espLoopFunc
				local addedFunc
				addedFunc=plr.CharacterAdded:Connect(function()
					if ESPenabled then
						espLoopFunc:Disconnect()
						ESPholder:Destroy()
						repeat wait(1) until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
						ESP(plr)
						addedFunc:Disconnect()
					else
						addedFunc:Disconnect()
					end
				end)
				function espLoop()
					if COREGUI:FindFirstChild(plr.Name..'_ESP') then
						if plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid") and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
							local pos=math.floor((getRoot(Players.LocalPlayer.Character).Position-getRoot(plr.Character).Position).magnitude)
							TextLabel.Text='@'..plr.Name..' | '..plr.DisplayName ..' | Studs: '..pos
							a.Adornee=plr.Character
						end
					else
						addedFunc:Disconnect()
						espLoopFunc:Disconnect()
					end
				end
				espLoopFunc=RunService.RenderStepped:Connect(espLoop)
			end
		end
	end)
end



local Signal1,Signal2=nil,nil
local flyMobile=nil
local MobileWeld=nil

function mobilefly(speed)
	local controlModule=require(SafeGetService("Players").LocalPlayer.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))
	local character=getChar() or LocalPlayer.CharacterAdded:Wait()
	if flyMobile then flyMobile:Destroy() end
	flyMobile=Instance.new("Part",workspace)
	flyMobile.Name=randomString()
	flyMobile.Size, flyMobile.CanCollide = Vector3.new(0.05, 0.05, 0.05), false
	if MobileWeld then MobileWeld:Destroy() end
	MobileWeld=Instance.new("Weld",flyMobile)
	MobileWeld.Name=randomString()
	MobileWeld.Part0, MobileWeld.Part1, MobileWeld.C0 = flyMobile, character:FindFirstChildWhichIsA("Humanoid").RootPart, CFrame.new(0, 0, 0)

	local existingBV=flyMobile:FindFirstChildWhichIsA("BodyVelocity")
	local existingBG=flyMobile:FindFirstChildWhichIsA("BodyGyro")

	if not existingBV then
		local bv=Instance.new("BodyVelocity")
		bv.Name=randomString()
		bv.MaxForce=Vector3.new(0,0,0)
		bv.Velocity=Vector3.new(0,0,0)
		bv.Parent=flyMobile
	end

	if not existingBG then
		local bg=Instance.new("BodyGyro")
		bg.Name=randomString()
		bg.MaxTorque=Vector3.new(9e9,9e9,9e9)
		bg.P=1000
		bg.D=50
		bg.Parent=flyMobile
	end

	Signal1=LocalPlayer.CharacterAdded:Connect(function(newChar)

		local newBV=flyMobile:FindFirstChildWhichIsA("BodyVelocity")
		local newBG=flyMobile:FindFirstChildWhichIsA("BodyGyro")
		local newWeld=flyMobile:FindFirstChildWhichIsA("Weld")

		if not newBV then
			local bv=Instance.new("BodyVelocity")
			bv.Name=randomString()
			bv.MaxForce=Vector3.new(0,0,0)
			bv.Velocity=Vector3.new(0,0,0)
			bv.Parent=flyMobile
		end

		if not newBG then
			local bg=Instance.new("BodyGyro")
			bg.Name=randomString()
			bg.MaxTorque=Vector3.new(9e9,9e9,9e9)
			bg.P=1000
			bg.D=50
			bg.Parent=flyMobile
		end

		if not newWeld then
			MobileWeld=Instance.new("Weld",flyMobile)
			MobileWeld.Name=randomString()
			MobileWeld.Part0, MobileWeld.Part1, MobileWeld.C0 = flyMobile, newChar:FindFirstChildWhichIsA("Humanoid").RootPart, CFrame.new(0, 0, 0)
		else
			MobileWeld.Part0, MobileWeld.Part1, MobileWeld.C0 = flyMobile, newChar:FindFirstChildWhichIsA("Humanoid").RootPart, CFrame.new(0, 0, 0)
		end

	end)

	local camera=SafeGetService("Workspace").CurrentCamera

	Signal2=RunService.RenderStepped:Connect(function()
		local character=getChar()
		local humanoid=character and character:FindFirstChildOfClass("Humanoid")
		local bv=flyMobile and flyMobile:FindFirstChildWhichIsA("BodyVelocity")
		local bg=flyMobile and flyMobile:FindFirstChildWhichIsA("BodyGyro")

		if character and humanoid and flyMobile and MobileWeld and bv and bg then
			bv.MaxForce=Vector3.new(9e9,9e9,9e9)
			bg.MaxTorque=Vector3.new(9e9,9e9,9e9)
			humanoid.PlatformStand=true

			bg.CFrame=camera.CFrame
			local direction=controlModule:GetMoveVector()
			local newVelocity=Vector3.new()

			if direction.X~=0 then
				newVelocity=newVelocity+camera.CFrame.RightVector*(direction.X*speed)
			end
			if direction.Z~=0 then
				newVelocity=newVelocity-camera.CFrame.LookVector*(direction.Z*speed)
			end

			bv.Velocity=newVelocity
		end
	end)
end

function unmobilefly()
	local char=getChar()
	if char and flyMobile then
		local humanoid=char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.PlatformStand=false
		end
		if flyMobile then flyMobile:Destroy() end
	end
	if Signal1 then Signal1:Disconnect() end
	if Signal2 then Signal2:Disconnect() end
end


function x(v)
	if v then
		for _,i in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
				i.LocalTransparencyModifier=0.5
			end
		end
	else
		for _,i in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
				i.LocalTransparencyModifier=0
			end
		end
	end
end

local cmdlp=SafeGetService("Players").LocalPlayer

plr=cmdlp

local cmdm=plr:GetMouse()
local goofyFLY=nil
function sFLY(vfly)
	while not cmdlp or not cmdlp.Character or not cmdlp.Character:FindFirstChild('HumanoidRootPart') or not cmdlp.Character:FindFirstChild('Humanoid') or not cmdm do
		wait()
	end 
	if goofyFLY then goofyFLY:Destroy() end
	goofyFLY=Instance.new("Part",workspace)
	goofyFLY.Name=randomString()
	goofyFLY.Size, goofyFLY.CanCollide = Vector3.new(0.05, 0.05, 0.05), false
	local CONTROL={F=0,B=0,L=0,R=0,Q=0,E=0}
	local lCONTROL={F=0,B=0,L=0,R=0,Q=0,E=0}
	local SPEED=0
	function FLY()
		FLYING=true
		local BG=Instance.new('BodyGyro',goofyFLY)
		local BV=Instance.new('BodyVelocity',goofyFLY)
		local Weld=Instance.new("Weld",goofyFLY)
		BG.Name=randomString()
		BV.Name=randomString()
		Weld.Name=randomString()
		Weld.Part0, Weld.Part1, Weld.C0 = goofyFLY, cmdlp.Character:FindFirstChildWhichIsA("Humanoid").RootPart, CFrame.new(0, 0, 0)
		BG.P=9e4
		BG.maxTorque=Vector3.new(9e9,9e9,9e9)
		BG.cframe=goofyFLY.CFrame
		BV.velocity=Vector3.new(0,0,0)
		BV.maxForce=Vector3.new(9e9,9e9,9e9)
		spawn(function()
			while FLYING do
				if not vfly then
					cmdlp.Character:FindFirstChild("Humanoid").PlatformStand=true
				end
				if CONTROL.L+CONTROL.R~=0 or CONTROL.F+CONTROL.B~=0 or CONTROL.Q+CONTROL.E~=0 then
					SPEED=50
				elseif not (CONTROL.L+CONTROL.R~=0 or CONTROL.F+CONTROL.B~=0 or CONTROL.Q+CONTROL.E~=0) and SPEED~=0 then
					SPEED=0
				end
				if (CONTROL.L+CONTROL.R)~=0 or (CONTROL.F+CONTROL.B)~=0 or (CONTROL.Q+CONTROL.E)~=0 then
					BV.velocity=((SafeGetService("Workspace").CurrentCamera.CoordinateFrame.lookVector*(CONTROL.F+CONTROL.B))+((SafeGetService("Workspace").CurrentCamera.CoordinateFrame*CFrame.new(CONTROL.L+CONTROL.R,(CONTROL.F+CONTROL.B+CONTROL.Q+CONTROL.E)*0.2,0).p)-SafeGetService("Workspace").CurrentCamera.CoordinateFrame.p))*SPEED
					lCONTROL={F=CONTROL.F,B=CONTROL.B,L=CONTROL.L,R=CONTROL.R}
				elseif (CONTROL.L+CONTROL.R)==0 and (CONTROL.F+CONTROL.B)==0 and (CONTROL.Q+CONTROL.E)==0 and SPEED~=0 then
					BV.velocity=((SafeGetService("Workspace").CurrentCamera.CoordinateFrame.lookVector*(lCONTROL.F+lCONTROL.B))+((SafeGetService("Workspace").CurrentCamera.CoordinateFrame*CFrame.new(lCONTROL.L+lCONTROL.R,(lCONTROL.F+lCONTROL.B+CONTROL.Q+CONTROL.E)*0.2,0).p)-SafeGetService("Workspace").CurrentCamera.CoordinateFrame.p))*SPEED
				else
					BV.velocity=Vector3.new(0,0,0)
				end
				BG.cframe=SafeGetService("Workspace").CurrentCamera.CoordinateFrame
				wait()
			end
			CONTROL={F=0,B=0,L=0,R=0,Q=0,E=0}
			lCONTROL={F=0,B=0,L=0,R=0,Q=0,E=0}
			SPEED=0
			BG:destroy()
			BV:destroy()
			cmdlp.Character.Humanoid.PlatformStand=false
		end)
	end
	cmdm.KeyDown:connect(function(KEY)
		if KEY:lower()=='w' then
			if vfly then
				CONTROL.F=speedofthevfly
			else
				CONTROL.F=speedofthefly
			end
		elseif KEY:lower()=='s' then
			if vfly then
				CONTROL.B=-speedofthevfly
			else
				CONTROL.B=-speedofthefly
			end
		elseif KEY:lower()=='a' then
			if vfly then
				CONTROL.L=-speedofthevfly
			else
				CONTROL.L=-speedofthefly
			end
		elseif KEY:lower()=='d' then
			if vfly then
				CONTROL.R=speedofthevfly
			else
				CONTROL.R=speedofthefly
			end
		elseif KEY:lower()=='y' then
			if vfly then
				CONTROL.Q=speedofthevfly*2
			else
				CONTROL.Q=speedofthefly*2
			end
		elseif KEY:lower()=='t' then
			if vfly then
				CONTROL.E=-speedofthevfly*2
			else
				CONTROL.E=-speedofthefly*2
			end
		end
	end)
	cmdm.KeyUp:connect(function(KEY)
		if KEY:lower()=='w' then
			CONTROL.F=0
		elseif KEY:lower()=='s' then
			CONTROL.B=0
		elseif KEY:lower()=='a' then
			CONTROL.L=0
		elseif KEY:lower()=='d' then
			CONTROL.R=0
		elseif KEY:lower()=='y' then
			CONTROL.Q=0
		elseif KEY:lower()=='t' then
			CONTROL.E=0
		end
	end)
	FLY()
end


local tool=nil
spawn(function()
	repeat wait() until getChar()
	tool=getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool") or nil
end)

function attachTool(tool,cf)
	for i,v in pairs(tool:GetDescendants()) do
		if not (v:IsA("BasePart") or v:IsA("Mesh") or v:IsA("SpecialMesh")) then
			v:Destroy()
		end
	end
	wait()
	getChar().Humanoid.Name=1
	local l=getChar()["1"]:Clone()
	l.Parent=getChar()
	l.Name="Humanoid"

	getChar()["1"]:Destroy()
	SafeGetService("Workspace").CurrentCamera.CameraSubject=getChar()
	getChar().Animate.Disabled=true
	wait();
	getChar().Humanoid.DisplayDistanceType="None"

	tool.Parent=getChar()
end

local nc=false
local ncLoop=nil
ncLoop=SafeGetService("RunService").Stepped:Connect(function()
	if nc and getChar()~=nil then
		for _,v in pairs(getChar():GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide==true then
				v.CanCollide=false
			end
		end
	end
end)

local netsleepTargets={}
local nsLoop=nil
nsLoop=SafeGetService("RunService").Stepped:Connect(function()
	if #netsleepTargets==0 then return end
	for i,v in pairs(netsleepTargets) do
		if v.Character then
			for i,v in pairs(v.Character:GetChildren()) do
				if v:IsA("BasePart")==false and v:IsA("Accessory")==false then continue end
				if v:IsA("BasePart") then
					sethiddenproperty(v,"NetworkIsSleeping",true)
				elseif v:IsA("Accessory") and v:FindFirstChild("Handle") then
					sethiddenproperty(v.Handle,"NetworkIsSleeping",true)
				end
			end
		end
	end
end)

local lp=SafeGetService("Players").LocalPlayer


--[[ LIB FUNCTIONS ]]--
chatmsgshooks={}
Playerchats={}

lib.LocalPlayerChat=function(...)
	local args={...} 
	if SafeGetService("TextChatService"):FindFirstChild("TextChannels") then
		local sendto=SafeGetService("TextChatService").TextChannels.RBXGeneral
		if args[2]~=nil and  args[2]~="All"  then
			if not Playerchats[args[2]] then
				for i,v in pairs(SafeGetService("TextChatService").TextChannels:GetChildren()) do
					if string.find(v.Name,"RBXWhisper:") then
						if v:FindFirstChild(args[2]) and v:FindFirstChild(SafeGetService("Players").LocalPlayer.Name) then
							if v[SafeGetService("Players").LocalPlayer.Name].CanSend==false then
								continue
							end
							sendto=v
							Playerchats[args[2]]=v
							break
						end
					end
				end
			else
				sendto=Playerchats[args[2]]
			end
			if sendto==SafeGetService("TextChatService").TextChannels.RBXGeneral then
				chatmsgshooks[args[1]]={args[1],args}
				task.spawn(function()
					SafeGetService("TextChatService").TextChannels.RBXGeneral:SendAsync("/w @"..args[2])
				end)
				return "Hooking"
			end
		end
		sendto:SendAsync(args[1] or "")
	else
		if args[2] and args[2]~="All" then
			SafeGetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w "..args[2].." "..args[1] or "","All")
		else
			SafeGetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(args[1] or "","All")
		end
	end
end

if SafeGetService("TextChatService"):FindFirstChild("TextChannels") then
	SafeGetService("TextChatService").TextChannels.ChildAdded:Connect(function(v)
		if string.find(v.Name,"RBXWhisper:") then
			task.wait(1)
			for id,va in pairs(chatmsgshooks) do
				if v:FindFirstChild(va[1]) and v:FindFirstChild(SafeGetService("Players").LocalPlayer.Name) then
					if v[SafeGetService("Players").LocalPlayer.Name].CanSend==false then
						continue
					end
					Playerchats[va[1]]=v
					chatmsgshooks[id]=nil
					lib.LocalPlayerChat(va[2])
					break
				end
			end
		end
	end)
end

lib.lpchat=lib.LocalPlayerChat

lib.lock=function(instance,par)
	locks[instance]=true
	instance.Parent=par or instance.Parent
	instance.Name="RightGrip"
end
local lock=lib.lock
local locks={}

lib.find=function(t,v)	--mmmmmm
	for i,e in pairs(t) do
		if i==v or e==v then
			return i
		end
	end
	return nil
end

lib.parseText=function(text,watch,rPlr)
	local parsed={}
	if not text then return nil end
	local prefix
	if rPlr then
		prefix=isRelAdmin(rPlr) and ";" or watch
		watch=prefix
	else
		prefix=watch
	end
	for arg in text:gmatch("[^"..watch.."]+") do
		arg=arg:gsub("-","%%-")
		local pos=text:find(arg)
		arg=arg:gsub("%%","")
		if pos then
			local find=text:sub(pos-prefix:len(),pos-1)
			if (find==prefix and watch==prefix) or watch~=prefix then
				table.insert(parsed,arg)
			end
		else
			table.insert(parsed,nil)
		end
	end
	return parsed
end

lib.parseCommand=function(text,rPlr)
	wrap(function()
		local commands
		if rPlr then
			commands=lib.parseText(text,opt.prefix,rPlr)
		else
			commands=lib.parseText(text,opt.prefix)
		end
		for _,parsed in pairs(commands) do
			local args={}
			for arg in parsed:gmatch("[^ ]+") do
				table.insert(args,arg)
			end
			cmd.run(args)
		end
	end)
end

local connections={}

lib.connect=function(name,connection)	--no :(
	connections[name..tostring(math.random(1000000,9999999))]=connection
	return connection
end

lib.disconnect=function(name)
	for title,connection in pairs(connections) do
		if title:find(name)==1 then
			connection:Disconnect()
		end
	end
end

local m=math			--prepare for annoying and unnecessary tool grip math
local rad=m.rad
local clamp=m.clamp
local sin=m.sin
local tan=m.tan
local cos=m.cos

--[[ PLAYER FUNCTIONS ]]--
local argument={}
argument.getPlayers=function(str)
	local playerNames,players=lib.parseText(str,opt.tupleSeparator),{}
	for _,arg in pairs(playerNames or {"me"}) do
		arg=arg:lower()
		local playerList=Players:GetPlayers()
		if arg=="me" or arg==nil then
			table.insert(players,localPlayer)

		elseif arg=="all" then
			for _,plr in pairs(playerList) do
				table.insert(players,plr)
			end

		elseif arg=="others" then
			for _,plr in pairs(playerList) do
				if plr~=localPlayer then
					table.insert(players,plr)
				end
			end

		elseif arg=="random" then
			table.insert(players,playerList[math.random(1,#playerList)])

		elseif arg:find("%%")==1 then
			local teamName=arg:sub(2)
			for _,plr in pairs(playerList) do
				if tostring(plr.Team):lower():find(teamName)==1 then
					table.insert(players,plr)
				end
			end

		else
			for _,plr in pairs(playerList) do
				if plr.Name:lower():find(arg)==1 or (plr.DisplayName and plr.DisplayName:lower():find(arg)==1) or (tostring(plr.UserId):lower():find(arg)==1) then
					table.insert(players,plr)
				end
			end
		end
	end
	return players
end

--[[ COMMANDS ]]--

cmd.add({"url"},{"url <link>","Run the script using url"},function(...)
	local args={...}
	local code=""

	for i,v in ipairs(args) do
		if i>1 then
			code=code.." "..v
		else
			code=v
		end
	end
	loadstring(game:HttpGet(code))()
end)

cmd.add({"loadstring","ls"},{"loadstring <code> (ls)","Run the code using the loadstring"},function(...)
	local args={...}
	local code=""

	for i,v in ipairs(args) do
		if i>1 then
			code=code.." "..v
		else
			code=v
		end
	end
	assert(loadstring(code))()
end)

cmd.add({"executor","exec"},{"executor (exec)","Very simple executor"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/basicExec.lua"))()
end)

cmd.add({"scripthub","hub"},{"scripthub (hub)","Thanks to scriptblox api"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/sHub.lua"))()
end)

cmd.add({"valk"},{"valk","Only works on dollhouse"},function()
	repeat SafeGetService("RunService").Stepped:wait()
	until game:IsLoaded() and SafeGetService("Players").LocalPlayer

	pcall(function()
		local plr=SafeGetService("Players").LocalPlayer
		local giver=SafeGetService("Workspace"):WaitForChild("Valkyrie Helm giver")

		local head=plr.Character:WaitForChild("Head")
		firetouchinterest(head,giver,0)

		plr.CharacterAdded:Connect(function(char)
			head=char:WaitForChild("Head")
			firetouchinterest(head,giver,0)
		end)
	end)
end)

cmd.add({"resizechat","rc"},{"resizechat (rc)","Makes chat resizable and draggable"},function()
	require(SafeGetService("Chat").ClientChatModules.ChatSettings).WindowResizable=true
	require(SafeGetService("Chat").ClientChatModules.ChatSettings).WindowDraggable=true
end)

local alreadyantilag=false
cmd.add({"lag"},{"lag <player>","Chat lag"},function()

	local Message="a" 
	local Unicode=" "
	Message=Message..Unicode:rep(200-#Message)

	local SayMessageRequest=SafeGetService("ReplicatedStorage"):FindFirstChild("SayMessageRequest",true)

	for i=1,7 do
		SayMessageRequest:FireServer(Message,"All")
	end

	if alreadyantilag==false then
		local Players=SafeGetService("Players")

		local Player=Players.LocalPlayer
		local PlayerGui=Player.PlayerGui

		local Chat=PlayerGui:FindFirstChild("Chat") 
		local MessageDisplay=Chat and Chat:FindFirstChild("Frame_MessageLogDisplay",true)
		local Scroller=MessageDisplay and MessageDisplay:FindFirstChild("Scroller")

		local Gsub=string.gsub
		local Lower=string.lower

		if not Scroller then return end

		for _,x in next,Scroller:GetChildren() do
			local MessageTextLabel=x:FindFirstChildWhichIsA("TextLabel")

			if MessageTextLabel then
				local Message=Gsub(MessageTextLabel.Text,"^%s+","")

				if Message:match(" ") then
					x:Destroy()
				end
			end
		end

		local ChatAdded=Scroller.ChildAdded:Connect(function(x)
			local MessageTextLabel=x:FindFirstChildWhichIsA("TextLabel")
			local SenderTextButton=MessageTextLabel and MessageTextLabel:FindFirstChildWhichIsA("TextButton")
			if MessageTextLabel and SenderTextButton then
				repeat task.wait() until not MessageTextLabel.Text:match("__+")
				local Message=Gsub(MessageTextLabel.Text,"^%s+","")

				if Message:match(" ") then
					x:Destroy()
				end
			end
		end)
		alreadyantilag=true
	else
	end
end)

	--[[cmd.add({"plugins"},{"plugins","Check what kind of plugins you have,add plugins using a gui,delete a plugin."},function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/NamelessAdminPlugin"))();
	end)]]

cmd.add({"prefix"},{"prefix <prefix>","Changes the admin prefix"},function(...)
	local PrefixChange=(...)

	if PrefixChange==nil then
		DoNotif("Please enter a valid prefix",5)
	elseif PrefixChange=="p" or PrefixChange=="[" or PrefixChange=="P" then
		DoNotif("idk why but this prefix breaks changing the prefix so pick smthing else alr?",5)
	else
		opt.prefix=PrefixChange
		DoNotif("Prefix set to: "..PrefixChange,5)
	end
end)


cmd.add({"saveprefix"},{"saveprefix <prefix>","Saves the prefix to what u want"},function(...)
	if not FileSupport then return end
	local PrefixChange=(...)

	if PrefixChange==nil then
		DoNotif("Please enter a valid prefix",5)
	elseif PrefixChange=="p" or PrefixChange=="[" or PrefixChange=="P" then
		DoNotif("idk why but this prefix breaks changing the prefix so pick smthing else alr?",5)
	else
		writefile("0x4/Prefix.txt",PrefixChange)
		opt.prefix=PrefixChange
		DoNotif("Prefix saved to: "..PrefixChange,5)
	end
end)

--[ UTILITY ]--

cmd.add({"chatlogs","clogs"},{"chatlogs (clogs)","Open the chat logs"},function()
	gui.chatlogs()
end)

cmd.add({"gotocampos","tocampos","tcp"},{"gotocampos (tocampos,tcp)","Teleports you to your camera position works with free cam but freezes you"},function()
	local player=SafeGetService("Players").LocalPlayer
	local UserInputService=SafeGetService("UserInputService")
	function teleportPlayer()
		local character=player.Character or player.CharacterAdded:wait(1)
		local camera=SafeGetService("Workspace").CurrentCamera
		local cameraPosition=camera.CFrame.Position
		character:SetPrimaryPartCFrame(CFrame.new(cameraPosition))
	end
	local camera=SafeGetService("Workspace").CurrentCamera
	repeat wait() until camera.CFrame~=CFrame.new()

	teleportPlayer()
end)

cmd.add({"kanye"},{"kanye","Random kanye quote"},function()
	local check="https://api.kanye.rest/"
	local final=game:HttpGet(check)
	local final2=string.gsub(final,'"quote"',"")
	local final3=string.gsub(final2,"[%{%:%}]","")
	lib.LocalPlayerChat(final3.."-Kanye West",'All')
end)

cmd.add({"teleportgui","tpui","universeviewer","uviewer"},{"teleportgui (tpui,universeviewer,uviewer)","Gives an UI that grabs all places and teleports you by clicking a simple button"},function()
	--loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/Game%20Universe%20Viewer"))()
	gui.universeGui()
end)

cmd.add({"serverremotespy","srs","sremotespy"},{"serverremotespy (srs,sremotespy)","Gives an UI that logs all the remotes being called from the server (thanks SolSpy lol)"},function()
	loadstring(game:HttpGet("https://github.com/ltseverydayyou/uuuuuuu/blob/main/Server%20Spy.lua?raw=spy"))()
end)

cmd.add({"clickfling","mousefling"},{"mousefling (clickfling)","Fling a player by clicking them"},function()
	local Players=SafeGetService("Players")
	local Mouse=SafeGetService("Players").LocalPlayer:GetMouse()

	Mouse.Button1Down:Connect(function()
		local Target=Mouse.Target
		if Target and Target.Parent and Target.Parent:IsA("Model") and Players:GetPlayerFromCharacter(Target.Parent) then
			local PlayerName=Players:GetPlayerFromCharacter(Target.Parent).Name
			local player=SafeGetService("Players").LocalPlayer
			local Targets={PlayerName}

			local Players=SafeGetService("Players")
			local Player=Players.LocalPlayer

			local AllBool=false

			local GetPlayer=function(Name)
				Name=Name:lower()
				if Name=="all" or Name=="others" then
					AllBool=true
					return
				elseif Name=="random" then
					local GetPlayers=Players:GetPlayers()
					if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
					return GetPlayers[math.random(#GetPlayers)]
				elseif Name~="random" and Name~="all" and Name~="others" then
					for _,x in next,Players:GetPlayers() do
						if x~=Player then
							if x.Name:lower():match("^"..Name) then
								return x;
							elseif x.DisplayName:lower():match("^"..Name) then
								return x;
							end
						end
					end
				else
					return
				end
			end

			local Message=function(_Title,_Text,Time)
				print(_Title)
				print(_Text)
				print(Time)
			end

			local SkidFling=function(TargetPlayer)
				local Character=Player.Character
				local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
				local RootPart=Humanoid and Humanoid.RootPart

				local TCharacter=TargetPlayer.Character
				local THumanoid
				local TRootPart
				local THead
				local Accessory
				local Handle

				if TCharacter:FindFirstChildOfClass("Humanoid") then
					THumanoid=TCharacter:FindFirstChildOfClass("Humanoid")
				end
				if THumanoid and THumanoid.RootPart then
					TRootPart=THumanoid.RootPart
				end
				if TCharacter:FindFirstChild("Head") then
					THead=TCharacter.Head
				end
				if TCharacter:FindFirstChildOfClass("Accessory") then
					Accessory=TCharacter:FindFirstChildOfClass("Accessory")
				end
				if Accessoy and Accessory:FindFirstChild("Handle") then
					Handle=Accessory.Handle
				end

				if Character and Humanoid and RootPart then
					if RootPart.Velocity.Magnitude<50 then
						getgenv().OldPos=RootPart.CFrame
					end
					if THumanoid and THumanoid.Sit and not AllBool then
					end
					if THead then
						SafeGetService("Workspace").CurrentCamera.CameraSubject=THead
					elseif not THead and Handle then
						SafeGetService("Workspace").CurrentCamera.CameraSubject=Handle
					elseif THumanoid and TRootPart then
						SafeGetService("Workspace").CurrentCamera.CameraSubject=THumanoid
					end
					if not TCharacter:FindFirstChildWhichIsA("BasePart") then
						return
					end

					local FPos=function(BasePart,Pos,Ang)
						RootPart.CFrame=CFrame.new(BasePart.Position)*Pos*Ang
						Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position)*Pos*Ang)
						RootPart.Velocity=Vector3.new(9e7,9e7*10,9e7)
						RootPart.RotVelocity=Vector3.new(9e8,9e8,9e8)
					end

					local SFBasePart=function(BasePart)
						local TimeToWait=2
						local Time=tick()
						local Angle=0

						repeat
							if RootPart and THumanoid then
								if BasePart.Velocity.Magnitude<50 then
									Angle=Angle+100

									FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(2.25,1.5,-2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(-2.25,-1.5,2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()
								else
									FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,-THumanoid.WalkSpeed),CFrame.Angles(0,0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,-TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(0,0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(-90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
									task.wait()
								end
							else
								break
							end
						until BasePart.Velocity.Magnitude>500 or BasePart.Parent~=TargetPlayer.Character or TargetPlayer.Parent~=Players or not TargetPlayer.Character==TCharacter or THumanoid.Sit or Humanoid.Health <=0 or tick()>Time+TimeToWait
					end

					SafeGetService("Workspace").FallenPartsDestroyHeight=0/0

					local BV=Instance.new("BodyVelocity")
					BV.Name="EpixVel"
					BV.Parent=RootPart
					BV.Velocity=Vector3.new(9e8,9e8,9e8)
					BV.MaxForce=Vector3.new(1/0,1/0,1/0)

					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)

					if TRootPart and THead then
						if (TRootPart.CFrame.p-THead.CFrame.p).Magnitude>5 then
							SFBasePart(THead)
						else
							SFBasePart(TRootPart)
						end
					elseif TRootPart and not THead then
						SFBasePart(TRootPart)
					elseif not TRootPart and THead then
						SFBasePart(THead)
					elseif not TRootPart and not THead and Accessory and Handle then
						SFBasePart(Handle)
					else
					end

					BV:Destroy()
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
					SafeGetService("Workspace").CurrentCamera.CameraSubject=Humanoid

					repeat
						RootPart.CFrame=getgenv().OldPos*CFrame.new(0,.5,0)
						Character:SetPrimaryPartCFrame(getgenv().OldPos*CFrame.new(0,.5,0))
						Humanoid:ChangeState("GettingUp")
						table.foreach(Character:GetChildren(),function(_,x)
							if x:IsA("BasePart") then
								x.Velocity,x.RotVelocity=Vector3.new(),Vector3.new()
							end
						end)
						task.wait()
					until (RootPart.Position-getgenv().OldPos.p).Magnitude<25
					SafeGetService("Workspace").FallenPartsDestroyHeight=getgenv().FPDH
				else
				end
			end

			getgenv().Welcome=true
			if Targets[1] then for _,x in next,Targets do GetPlayer(x) end else return end

			if AllBool then
				for _,x in next,Players:GetPlayers() do
					SkidFling(x)
				end
			end

			for _,x in next,Targets do
				if GetPlayer(x) and GetPlayer(x)~=Player then
					if GetPlayer(x).UserId~=1414978355 then
						local TPlayer=GetPlayer(x)
						if TPlayer then
							SkidFling(TPlayer)
						end
					else
					end
				elseif not GetPlayer(x) and not AllBool then
				end
			end
		end
	end)
end)

cmd.add({"ping"},{"ping","Shows your ping"},function()
	local Ping=Instance.new("ScreenGui")
	local Pingtext=Instance.new("TextLabel")
	local UICorner=Instance.new("UICorner")
	local UIAspectRatioConstraint=Instance.new("UIAspectRatioConstraint")

	Ping.Name="Ping"
	Ping.Parent=gethui()
	Ping.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
	Ping.ResetOnSpawn=false

	Pingtext.Name="Pingtext"
	Pingtext.Parent=Ping
	Pingtext.BackgroundColor3=Color3.fromRGB(12,4,20)
	Pingtext.BackgroundTransparency=0.140
	Pingtext.Position=UDim2.new(0,0,0,48)
	Pingtext.Size=UDim2.new(0,201,0,35)
	Pingtext.Font=Enum.Font.SourceSans
	Pingtext.Text="FPS:"
	Pingtext.TextColor3=Color3.fromRGB(255,255,255)
	Pingtext.TextScaled=true
	Pingtext.TextSize=14.000
	Pingtext.TextWrapped=true

	UICorner.CornerRadius=UDim.new(1,0)
	UICorner.Parent=Pingtext

	UIAspectRatioConstraint.Parent=Pingtext
	UIAspectRatioConstraint.AspectRatio=5.743

	local RunService=SafeGetService("RunService")
	RunService.RenderStepped:Connect(function(ping) 
		Pingtext.Text=("Ping: " ..SafeGetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(math.round(2/ping)))--your ping
	end)
	gui.draggable(Pingtext)
end)

cmd.add({"fps"},{"fps","Shows your fps"},function()
	local Fps=Instance.new("ScreenGui")
	local Fpstext=Instance.new("TextLabel")
	local UICorner=Instance.new("UICorner")
	local UIAspectRatioConstraint=Instance.new("UIAspectRatioConstraint")

	Fps.Name="Fps"
	Fps.Parent=gethui()
	Fps.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
	Fps.ResetOnSpawn=false

	Fpstext.Name="Fpstext"
	Fpstext.Parent=Fps
	Fpstext.BackgroundColor3=Color3.fromRGB(12,4,20)
	Fpstext.BackgroundTransparency=0.140
	Fpstext.Position=UDim2.new(0,0,0,6)
	Fpstext.Size=UDim2.new(0,201,0,35)
	Fpstext.Font=Enum.Font.SourceSans
	Fpstext.Text="FPS:"
	Fpstext.TextColor3=Color3.fromRGB(255,255,255)
	Fpstext.TextScaled=true
	Fpstext.TextSize=14.000
	Fpstext.TextWrapped=true

	UICorner.CornerRadius=UDim.new(1,0)
	UICorner.Parent=Fpstext

	UIAspectRatioConstraint.Parent=Fpstext
	UIAspectRatioConstraint.AspectRatio=5.743

	local RunService=SafeGetService("RunService")
	RunService.RenderStepped:Connect(function(frame) 
		Fpstext.Text=("FPS: "..math.round(1/frame)) 
	end)
	gui.draggable(Fpstext)
end)

cmd.add({"commands","cmds"},{"commands (cmds)","Open the command list"},function()
	gui.commands()
end)

--[[cmd.add({"adonisfinder","adfind"},{"adonis finder (adfind)","Lets you see if the game has adonis admin"},function()
	loadstring(game:HttpGet("https://github.com/ltseverydayyou/Nameless-Admin/blob/main/AdonisScanner.lua?raw=adonfind"))()
end)]]
--Mobile Commands for the screen
if IsOnMobile then

	cmd.add({"SensorRotationScreen","SensorScreen","SenScreen"},{"SensorRotaionScreen (SensorScreen or SenScreen)","Changes ScreenOrientation to Sensor"},function()
		SafeGetService("Players").LocalPlayer.PlayerGui.ScreenOrientation=Enum.ScreenOrientation.Sensor
	end)

	cmd.add({"LandscapeRotationScreen","LandscapeScreen","LandScreen"},{"LandscapeRotaionScreen (LandscapeScreen or LandScreen)","Changes ScreenOrientation to Landscape Sensor"},function()
		SafeGetService("Players").LocalPlayer.PlayerGui.ScreenOrientation=Enum.ScreenOrientation.LandscapeSensor
	end)

	cmd.add({"PortraitRotationScreen","PortraitScreen","Portscreen"},{"PortraitRotaionScreen (PortraitScreen or Portscreen)","Changes ScreenOrientation to Portrait"},function()
		SafeGetService("Players").LocalPlayer.PlayerGui.ScreenOrientation=Enum.ScreenOrientation.Portrait
	end)

	cmd.add({"DefaultRotaionScreen","DefaultScreen","Defscreen"},{"DefaultRotaionScreen (DefaultScreen or Defscreen)","Changes ScreenOrientation to Portrait"},function()
		SafeGetService("Players").LocalPlayer.PlayerGui.ScreenOrientation=SafeGetService("StarterGui").ScreenOrientation 
	end)

end
cmd.add({"commandcount","cc"},{"commandcount (cc)","Counds how many commands NA has"},function()
	DoNotif(adminName.." currently has ".. commandcount.." commands",5)
end)

local hiddenfling=false
cmd.add({"walkfling","wfling"},{"walkfling (wfling) [THANKS TO X]","probably the best fling lol"},function()
	DoNotif("Walkfling enabled",5)
	if NA_storage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
		hiddenfling=true
	else
		hiddenfling=true
		detection=Instance.new("Decal")
		detection.Name="juisdfj0i32i0eidsuf0iok"
		detection.Parent=NA_storage
		function fling()
			local hrp,c,vel,movel=nil,nil,nil,0.1
			while true do
				RunService.Heartbeat:Wait()
				if hiddenfling then
					local lp=SafeGetService("Players").LocalPlayer
					while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
						RunService.Heartbeat:Wait()
						c=lp.Character
						hrp=c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
					end
					if hiddenfling then
						vel=hrp.Velocity
						hrp.Velocity=vel*10000+Vector3.new(0,10000,0)
						RunService.RenderStepped:Wait()
						if c and c.Parent and hrp and hrp.Parent then
							hrp.Velocity=vel
						end
						SafeGetService("RunService").Stepped:Wait()
						if c and c.Parent and hrp and hrp.Parent then
							hrp.Velocity=vel+Vector3.new(0,movel,0)
							movel=movel*-1
						end
					end
				end
			end
		end

		fling()
	end
end)

cmd.add({"unwalkfling","unwfling"},{"unwalkfling (unwfling)","stop the walkfling command"},function()
	DoNotif("Walkfling disabled",5)
	hiddenfling=false
end)

cmd.add({"fling3"},{"fling3 <player>","another variant of fling"},function(...)
	oldcframe=getRoot(Players.LocalPlayer.Character).CFrame

	User=(...)
	Target=getPlr(User)

	hiddenfling=true

	if NA_storage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
		hiddenfling=true
	else
		detection=Instance.new("Decal")
		detection.Name="juisdfj0i32i0eidsuf0iok"
		detection.Parent=NA_storage
		function fling()
			local hrp,c,vel,movel=nil,nil,nil,0.1
			while true do
				RunService.Heartbeat:Wait()
				if hiddenfling then
					local lp=SafeGetService("Players").LocalPlayer
					while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
						RunService.Heartbeat:Wait()
						c=lp.Character
						hrp=c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
					end
					if hiddenfling then
						vel=hrp.Velocity
						hrp.Velocity=vel*10000+Vector3.new(0,10000,0)
						RunService.RenderStepped:Wait()
						if c and c.Parent and hrp and hrp.Parent then
							hrp.Velocity=vel
						end
						SafeGetService("RunService").Stepped:Wait()
						if c and c.Parent and hrp and hrp.Parent then
							hrp.Velocity=vel+Vector3.new(0,movel,0)
							movel=movel*-1
						end
					end
				end
			end
		end
		fling()
	end
	Player.Character.Humanoid:SetStateEnabled("Seated",false)
	Player.Character.Humanoid.Sit=true
	if User=="all" or User=="others" then
		for _,x in next,SafeGetService("Players"):GetPlayers() do
			for i=1,10 do
				wait(0.017)
				getRoot(getChar()).CFrame=getRoot(x.Character).CFrame*CFrame.new(0,0,4)
				wait(0.01)
				getRoot(getChar()).CFrame=getRoot(x.Character).CFrame*CFrame.new(0,0,-2)
				wait(0.01)
				getRoot(getChar()).CFrame=getRoot(x.Character).CFrame
				wait(0.01)
				getRoot(getChar()).CFrame=getRoot(x.Character).CFrame*CFrame.new(0,0,-3)
				wait(0.01)
				getRoot(getChar()).CFrame=getRoot(x.Character).CFrame*CFrame.new(0,0,2)
				wait(0.01)
				getRoot(getChar()).CFrame=getRoot(x.Character).CFrame
				wait(0.01)
				getRoot(getChar()).CFrame=getRoot(x.Character).CFrame*CFrame.new(0,0,-1)
				wait(0.01)
				getRoot(getChar()).CFrame=getRoot(x.Character).CFrame*CFrame.new(0,0,-1)
			end
		end
	else
		for i=1,10 do
			wait(0.017)
			getRoot(Players.LocalPlayer.Character).CFrame=getRoot(Target.Character).CFrame*CFrame.new(0,0,4)
			wait(0.01)
			getRoot(Players.LocalPlayer.Character).CFrame=getRoot(Target.Character).CFrame*CFrame.new(0,0,-2)
			wait(0.01)
			getRoot(Players.LocalPlayer.Character).CFrame=getRoot(Target.Character).CFrame
			wait(0.01)
			getRoot(Players.LocalPlayer.Character).CFrame=getRoot(Target.Character).CFrame*CFrame.new(0,0,-3)
			wait(0.01)
			getRoot(Players.LocalPlayer.Character).CFrame=getRoot(Target.Character).CFrame*CFrame.new(0,0,2)
			wait(0.01)
			getRoot(Players.LocalPlayer.Character).CFrame=getRoot(Target.Character).CFrame
			wait(0.01)
			getRoot(Players.LocalPlayer.Character).CFrame=getRoot(Target.Character).CFrame*CFrame.new(0,0,-1)
			wait(0.01)
			getRoot(Players.LocalPlayer.Character).CFrame=getRoot(Target.Character).CFrame*CFrame.new(0,0,-1)
		end
	end
	sFLY(true)
	speedofthevfly=1
	wait(0.3)
	getRoot(Players.LocalPlayer.Character).CFrame=oldcframe
	wait(0.13)
	Player.Character.Humanoid:SetStateEnabled("Seated",true)
	Player.Character.Humanoid.Sit=false
	FLYING=false
	getChar().Humanoid.PlatformStand=false
	hiddenfling=false
end)

cmd.add({"rjre","rejoinrefresh"},{"rjre (rejoinrefresh)","Rejoins and teleports you to the position where you were before"},function()
	if not DONE then
		DONE=true
		local qot=print("a")
		local hrp=getRoot(getChar())
		if hrp then
			--qot="task.spawn(function() end) repeat wait() until game and game:IsLoaded() local lp=game:GetService('Players').LocalPlayer local char=lp.Character or lp.CharacterAdded:Wait() repeat char:WaitForChild('HumanoidRootPart',5).CFrame=CFrame.new("..tostring(hrp.CFrame)..") wait() until (Vector3.new("..tostring(hrp.Position)..")-char:WaitForChild('HumanoidRootPart').Position).Magnitude<10"
			qot="pcall(function() repeat task.wait() until game:IsLoaded() lp=game:GetService('Players').LocalPlayer local char=lp.Character or lp.CharacterAdded:Wait() local humRP=char:WaitForChild('HumanoidRootPart',5) repeat humRP.CFrame=CFrame.new("..tostring(hrp.CFrame)..") wait() until (Vector3.new("..tostring(hrp.Position)..")-humRP.Position).Magnitude<10 end)"
		end
		queueteleport(qot)
		if #SafeGetService("Players"):GetPlayers() <=1 then
			SafeGetService("Players").LocalPlayer:Kick("Rejoining...")
			wait()
			SafeGetService("TeleportService"):TeleportCancel()
			SafeGetService("TeleportService"):TeleportToPlaceInstance(PlaceId,JobId,SafeGetService("Players").LocalPlayer)
		else
			SafeGetService("TeleportService"):TeleportCancel()
			SafeGetService("TeleportService"):TeleportToPlaceInstance(PlaceId,JobId,SafeGetService("Players").LocalPlayer)
		end
	end
end)

cmd.add({"rejoin","rj"},{"rejoin (rj)","Rejoin the game"},function()
	if #SafeGetService("Players"):GetPlayers() <=1 then
		SafeGetService("Players").LocalPlayer:Kick("Rejoining...")
		wait()
		SafeGetService("TeleportService"):TeleportCancel()
		SafeGetService("TeleportService"):Teleport(PlaceId)
	else
		SafeGetService("TeleportService"):TeleportCancel()
		SafeGetService("TeleportService"):TeleportToPlaceInstance(PlaceId,JobId,SafeGetService("Players").LocalPlayer)
	end



	wait();

	DoNotif("Rejoining...",5)
end)

cmd.add({"teleporttoplace","toplace","ttp"},{"teleporttoplace (PlaceId) (toplace,ttp)","Teleports you using PlaceId"},function(...)
	args={...}
	pId=tonumber(args[1])
	SafeGetService("TeleportService"):Teleport(pId)
end)

--fixed-viper
cmd.add({"adonisbypass","bypassadonis","badonis","adonisb"},{"adonisbypass (bypassadonis,badonis,adonisb)","bypasses adonis admin detection"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/adonisbypass.lua"))()
end)

--[ LOCALPLAYER ]--
function respawn()
	cf=getRoot(getChar()).CFrame
	getChar().Humanoid.Health=0
	player.CharacterAdded:wait(1); wait(0.2);
	character:WaitForChild("HumanoidRootPart").CFrame=cf
end

function refresh()
	cf=getRoot(getChar()).CFrame
	getChar().Humanoid.Health=0
	player.CharacterAdded:wait(1); wait(0.2);
	character:WaitForChild("HumanoidRootPart").CFrame=cf
end

local abort=0
function getTools(amt)
	if not amt then amt=1 end
	local toolAmount,grabbed=0,{}
	local lastCF=character.PrimaryPart.CFrame
	local ab=abort

	for i,v in pairs(localPlayer:FindFirstChildWhichIsA("Backpack"):GetChildren()) do
		if v:IsA("BackpackItem") then
			toolAmount=toolAmount+1
		end
	end
	if toolAmount >=amt then return localPlayer:FindFirstChildWhichIsA("Backpack"):GetChildren() end
	if not localPlayer:FindFirstChildWhichIsA("Backpack"):FindFirstChildWhichIsA("BackpackItem") then return end

	repeat
		repeat wait() until localPlayer:FindFirstChildWhichIsA("Backpack") or ab~=abort
		backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
		wrap(function()
			repeat wait() until backpack:FindFirstChildWhichIsA("BackpackItem")
			for _,tool in pairs(backpack:GetChildren()) do
				if #grabbed >=amt or ab~=abort then break end
				if tool:IsA("BackpackItem") then
					tool.Parent=localPlayer
					table.insert(grabbed,tool)
				end
			end
		end)

		respawn()
		wait(.1)
	until
	#grabbed >=amt or ab~=abort

	repeat wait() until localPlayer.Character and tostring(localPlayer.Character)~="respawn_" and localPlayer.Character==character
	wait(.2)

	repeat wait() until localPlayer:FindFirstChildWhichIsA("Backpack") or ab~=abort
	local backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
	for _,tool in pairs(grabbed) do
		if tool:IsA("BackpackItem") then
			tool.Parent=backpack
		end
	end
	wrap(function()
		repeat wait() until character.PrimaryPart
		wait(.2)
		character:SetPrimaryPartCFrame(lastCF)
	end)
	wait(.2)
	return grabbed
end



cmd.add({"joke"},{"joke","Random joke generator"},function()
	coroutine.wrap(function()
		local HttpService=SafeGetService('HttpService')
		local check="https://official-joke-api.appspot.com/jokes/programming/random"
		local final1=game:HttpGet(check)
		local final=string.gsub(final1,"[%[%]]","")
		local decoded=HttpService:JSONDecode(final)
		lib.LocalPlayerChat(decoded.setup,'All')
		wait(2)
		lib.LocalPlayerChat(decoded.punchline,'All')
	end)()

end)
cmd.add({"idiot"},{"idiot <player>","Tell someone that they are an idiot"},function(...)
	local old=getRoot(getChar()).CFrame

	Username=(...)

	Players=SafeGetService("Players")
	HRP=getRoot(getChar()).Anchored


	target=getPlr(Username)

	getRoot(getChar()).CFrame=target.Character.Humanoid.RootPart.CFrame*CFrame.new(0,1,4)
	local message="Hey "..target.Name..""
	lib.LocalPlayerChat(message,'All')
	wait(1)
	lib.LocalPlayerChat('Sorry to tell you this,but..','All')
	wait(1)
	lib.LocalPlayerChat('You are an idiot!','All')
	wait(1)
	lib.LocalPlayerChat('HAHAHA!','All')
	wait(1)
	getChar():WaitForChild("HumanoidRootPart").CFrame=old


end)

cmd.add({"accountage","accage"},{"accountage <player> (accage)","Tells the account age of a player in the server"},function(...)
	Username=(...)

	target=getPlr(Username)
	teller=target.AccountAge
	accountage="The account age of "..target.Name.." is "..teller

	wait();

	DoNotif(accountage)
end)

cmd.add({"notoolscripts","nts"},{"notoolscripts (nts)","Destroy all scripts in backpack"},function()
	print("test")
	local bp=player:FindFirstChildWhichIsA("Backpack")
	for _,item in pairs(bp:GetChildren()) do
		for _,obj in pairs(item:GetDescendants()) do
			if obj:IsA("LocalScript") or obj:IsA("Script") then
				obj.Disabled=true
				obj:Destroy()
			end
		end
	end
end)

cmd.add({"spblockspam","starterblockscam"},{"spblockspam (starterblockspam)","Spam blocks in any game that has the starter place"},function()
	anniblockspam=true
end)

cmd.add({"febtools"},{"febtools","Move parts that are your hats"},function()
	--[[ THANKS TO ROUXHAVER FOR THIS ]]--
	--check out his github-https://github.com/rouxhaver
	local Players=SafeGetService("Players")
	local RunService=SafeGetService("RunService")
	local LocalPlayer=Players.LocalPlayer

	if not getgenv().Network then
		getgenv().Network={
			BaseParts={};
			FakeConnections={};
			Connections={};
			Output={
				Enabled=true;
				Prefix="[NETWORK] ";
				Send=function(Type,Output,BypassOutput)
					if typeof(Type)=="function" and (Type==print or Type==warn or Type==error) and typeof(Output)=="string" and (typeof(BypassOutput)=="nil" or typeof(BypassOutput)=="boolean") then
						if Network["Output"].Enabled==true or BypassOutput==true then
							Type(Network["Output"].Prefix..Output);
						end;
					elseif Network["Output"].Enabled==true then
						error(Network["Output"].Prefix.."Output Send Error : Invalid syntax.");
					end;
				end;
			};
			CharacterRelative=false;
		}

		Network["Output"].Send(print,": Loading.")
		Network["Velocity"]=Vector3.new(14.46262424,14.46262424,14.46262424);--exactly 25.1 magnitude
		Network["RetainPart"]=function(Part,ReturnFakePart)--function for retaining ownership of unanchored parts
			assert(typeof(Part)=="Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(workspace),Network["Output"].Prefix.."RetainPart Error : Invalid syntax: Arg1 (Part) must be a BasePart which is a descendant of workspace.")
			assert(typeof(ReturnFakePart)=="boolean" or typeof(ReturnFakePart)=="nil",Network["Output"].Prefix.."RetainPart Error : Invalid syntax: Arg2 (ReturnFakePart) must be a boolean or nil.")
			if not table.find(Network["BaseParts"],Part) then
				if Network.CharacterRelative==true then
					local Character=LocalPlayer.Character
					if Character and Character.PrimaryPart then
						local Distance=(Character.PrimaryPart.Position-Part.Position).Magnitude
						if Distance>1000 then
							Network["Output"].Send(warn,"RetainPart Warning : PartOwnership not applied to BasePart "..Part:GetFullName()..",as it is more than "..gethiddenproperty(LocalPlayer,"MaximumSimulationRadius").." studs away.")
							return false
						end
					else
						Network["Output"].Send(warn,"RetainPart Warning : PartOwnership not applied to BasePart "..Part:GetFullName()..",as the LocalPlayer Character's PrimaryPart does not exist.")
						return false
					end
				end
				table.insert(Network["BaseParts"],Part)
				Part.CustomPhysicalProperties=PhysicalProperties.new(0,0,0,0,0)
				Network["Output"].Send(print,"PartOwnership Output : PartOwnership applied to BasePart "..Part:GetFullName()..".")
				if ReturnFakePart==true then
					return FakePart
				end
			else
				Network["Output"].Send(warn,"RetainPart Warning : PartOwnership not applied to BasePart "..Part:GetFullName()..",as it already active.")
				return false
			end
		end

		Network["RemovePart"]=function(Part)--function for removing ownership of unanchored part
			assert(typeof(Part)=="Instance" and Part:IsA("BasePart"),Network["Output"].Prefix.."RemovePart Error : Invalid syntax: Arg1 (Part) must be a BasePart.")
			local Index=table.find(Network["BaseParts"],Part)
			if Index then
				table.remove(Network["BaseParts"],Index)
				Network["Output"].Send(print,"RemovePart Output: PartOwnership removed from BasePart "..Part:GetFullName()..".")
			else
				Network["Output"].Send(warn,"RemovePart Warning : BasePart "..Part:GetFullName().." not found in BaseParts table.")
			end
		end

		Network["SuperStepper"]=Instance.new("BindableEvent")--make super fast event to connect to
		for _,Event in pairs({RunService.Stepped,RunService.Heartbeat}) do
			Event:Connect(function()
				return Network["SuperStepper"]:Fire(Network["SuperStepper"],tick())
			end)
		end

		Network["PartOwnership"]={};
		Network["PartOwnership"]["PreMethodSettings"]={};
		Network["PartOwnership"]["Enabled"]=false;
		Network["PartOwnership"]["Enable"]=coroutine.create(function()--creating a thread for network stuff
			if Network["PartOwnership"]["Enabled"]==false then
				Network["PartOwnership"]["Enabled"]=true--do cool network stuff before doing more cool network stuff
				Network["PartOwnership"]["PreMethodSettings"].ReplicationFocus=LocalPlayer.ReplicationFocus
				LocalPlayer.ReplicationFocus=SafeGetService("Workspace")
				Network["PartOwnership"]["PreMethodSettings"].SimulationRadius=gethiddenproperty(LocalPlayer,"SimulationRadius")
				Network["PartOwnership"]["Connection"]=Network["SuperStepper"].Event:Connect(function()--super fast asynchronous loop
					sethiddenproperty(LocalPlayer,"SimulationRadius",1/0)
					for _,Part in pairs(Network["BaseParts"]) do--loop through parts and do network stuff
						coroutine.wrap(function()
							if Part:IsDescendantOf(workspace) then
								if Network.CharacterRelative==true then
									local Character=LocalPlayer.Character;
									if Character and Character.PrimaryPart then
										local Distance=(Character.PrimaryPart.Position-Part.Position).Magnitude
										if Distance>1000 then
											Network["Output"].Send(warn,"PartOwnership Warning : PartOwnership not applied to BasePart "..Part:GetFullName()..",as it is more than "..gethiddenproperty(LocalPlayer,"MaximumSimulationRadius").." studs away.")
											Lost=true;
											Network["RemovePart"](Part)
										end
									else
										Network["Output"].Send(warn,"PartOwnership Warning : PartOwnership not applied to BasePart "..Part:GetFullName()..",as the LocalPlayer Character's PrimaryPart does not exist.")
									end
								end
								Part.Velocity=Network["Velocity"]+Vector3.new(0,math.cos(tick()*10)/100,0)--keep network by sending physics packets of 30 magnitude+an everchanging addition in the y level so roblox doesnt get triggered and fuck your ownership
							else
								Network["RemovePart"](Part)
							end
						end)()
					end
				end)
				Network["Output"].Send(print,"PartOwnership Output : PartOwnership enabled.")
			else
				Network["Output"].Send(warn,"PartOwnership Output : PartOwnership already enabled.")
			end
		end)
		Network["PartOwnership"]["Disable"]=coroutine.create(function()
			if Network["PartOwnership"]["Connection"] then
				Network["PartOwnership"]["Connection"]:Disconnect()
				LocalPlayer.ReplicationFocus=Network["PartOwnership"]["PreMethodSettings"].ReplicationFocus
				sethiddenproperty(LocalPlayer,"SimulationRadius",Network["PartOwnership"]["PreMethodSettings"].SimulationRadius)
				Network["PartOwnership"]["PreMethodSettings"]={}
				for _,Part in pairs(Network["BaseParts"]) do
					Network["RemovePart"](Part)
				end
				Network["PartOwnership"]["Enabled"]=false
				Network["Output"].Send(print,"PartOwnership Output : PartOwnership disabled.")
			else
				Network["Output"].Send(warn,"PartOwnership Output : PartOwnership already disabled.")
			end
		end)
		Network["Output"].Send(print,": Loaded.")
	end

	coroutine.resume(Network["PartOwnership"]["Enable"])



	local lp=SafeGetService("Players").LocalPlayer--local player var
	local char=lp.Character--char var

	lp.Character=nil--nil character for pdeath
	lp.Character=char--newvar

	local hrp=char:FindFirstChild("HumanoidRootPart")--hrp check
	if hrp==nil then return end--return if no hrp

	wait(SafeGetService("Players").RespawnTime+.3)--nil wait

	hrp:Destroy()--rip hrp
	char.Torso:Destroy()--rip torso
	local clone=char["Body Colors"]:Clone()--body colors clone
	char["Body Colors"]:Destroy()--delete any instances from char that replicates deletion
	clone.Parent=char--parent back in clone in case some script uses it




	player=SafeGetService("Players").LocalPlayer
	Gui=player.PlayerGui
	Backpack=player.Backpack
	Mouse=player:GetMouse()

	Parts_Folder=Instance.new("Folder",workspace)

	for i,v in pairs(player.Character:GetChildren()) do
		if v:IsA("Accessory") then
			local Part=Instance.new("Part",Parts_Folder)
			Part.Name=v.Name
			Part.Anchored=true
			Part.Size=v.Handle.Size-Vector3.new(0.001,0.001,0.001)
			Part.Position=player.Character.Head.Position+Vector3.new(math.random(-5,5),math.random(-1,1),math.random(-5,5))
			Part:SetAttribute("Moveable",true)
			Part.Material=Enum.Material.SmoothPlastic
			Part.CanCollide=false
			Part.Color=Color3.new(1,0,0)

			local Hat=v.Handle
			local vbreak=false
			Network.RetainPart(Hat)
			Hat.CustomPhysicalProperties=PhysicalProperties.new(0,0,0,0,0)
			coroutine.wrap(function()
				while task.wait() do
					if vbreak==true then break end
					Hat.CFrame=Part.CFrame
				end
			end)()
			Hat:FindFirstChildWhichIsA("SpecialMesh"):Destroy()
		end
	end


	Move_Tool=Instance.new("Tool",Backpack)
	Rotate_Tool=Instance.new("Tool",Backpack)
	MHandle=Instance.new("Part",Move_Tool)
	RHandle=Instance.new("Part",Rotate_Tool)
	Mgrabs=Instance.new("Handles",Gui)
	Rgrabs=Instance.new("ArcHandles",Gui)
	Outline=Instance.new("Highlight")

	Move_Tool.Name="Move"
	Move_Tool.CanBeDropped=false

	Rotate_Tool.Name="Rotate"
	Rotate_Tool.CanBeDropped=false

	MHandle.Name="Handle"
	MHandle.Transparency=1

	RHandle.Name="Handle"
	RHandle.Transparency=1

	Mgrabs.Visible=false
	Mgrabs.Color3=Color3.new(1,0.8,0)
	Mgrabs.Style="Movement"

	Rgrabs.Visible=false

	Outline.FillTransparency=1
	Outline.OutlineTransparency=0
	Outline.OutlineColor=Color3.new(1,0.8,0)

	Active_Part=nil

	Move_Tool.AncestryChanged:Connect(function()
		if Move_Tool.Parent==char and Active_Part~=nil then
			Mgrabs.Visible=true
			Mgrabs.Adornee=Active_Part
		end
	end)

	Move_Tool.AncestryChanged:Connect(function()
		if Move_Tool.Parent~=char then
			Mgrabs.Visible=false
			Mgrabs.Adornee=nil
		end
	end)

	Mouse.Button1Down:Connect(function()
		if Move_Tool.Parent==char and Mouse.Target:GetAttribute("Moveable") then
			Active_Part=Mouse.Target
			Mgrabs.Visible=true
			Mgrabs.Adornee=Active_Part
			Outline.Parent=Active_Part
		end
		if Rotate_Tool.Parent==char and Mouse.Target:GetAttribute("Moveable") then
			Active_Part=Mouse.Target
			Rgrabs.Visible=true
			Rgrabs.Adornee=Active_Part
			Outline.Parent=Active_Part
		end
	end)

	Rotate_Tool.AncestryChanged:Connect(function()
		if Rotate_Tool.Parent==char and Active_Part~=nil then
			Rgrabs.Visible=true
			Rgrabs.Adornee=Active_Part
		end
	end)

	Rotate_Tool.AncestryChanged:Connect(function()
		if Rotate_Tool.Parent~=char then
			Rgrabs.Visible=false
			Rgrabs.Adornee=nil
		end
	end)

	MOGCFrame=CFrame.new()

	Mgrabs.MouseButton1Down:Connect(function()
		MOGCFrame=Active_Part.CFrame
	end)

	Mgrabs.MouseDrag:Connect(function(knob,pos)
		if knob==Enum.NormalId.Front then
			Active_Part.CFrame=MOGCFrame+MOGCFrame.LookVector*pos
		end
		if knob==Enum.NormalId.Back then
			Active_Part.CFrame=MOGCFrame+MOGCFrame.LookVector*-pos
		end
		if knob==Enum.NormalId.Top then
			Active_Part.CFrame=MOGCFrame+MOGCFrame.UpVector*pos
		end
		if knob==Enum.NormalId.Bottom then
			Active_Part.CFrame=MOGCFrame+MOGCFrame.UpVector*-pos
		end
		if knob==Enum.NormalId.Left then
			Active_Part.CFrame=MOGCFrame+MOGCFrame.RightVector*-pos
		end
		if knob==Enum.NormalId.Right then
			Active_Part.CFrame=MOGCFrame+MOGCFrame.RightVector*pos
		end
	end)

	ROGCFrame=CFrame.new()

	Rgrabs.MouseButton1Down:Connect(function()
		ROGCFrame=Active_Part.CFrame
	end)

	Rgrabs.MouseDrag:Connect(function(knob,angle)
		if knob==Enum.Axis.Y then
			Active_Part.CFrame=ROGCFrame*CFrame.Angles(0,angle,0)
		end
		if knob==Enum.Axis.X then
			Active_Part.CFrame=ROGCFrame*CFrame.Angles(angle,0,0)
		end
		if knob==Enum.Axis.Z then
			Active_Part.CFrame=ROGCFrame*CFrame.Angles(0,0,angle)
		end
	end)



	Mouse.TargetFilter=player.Character



	camera=SafeGetService("Workspace").CurrentCamera
	input=SafeGetService("UserInputService")

	Camera_Part=Instance.new("Part",workspace)
	Camera_Part.Anchored=true
	Camera_Part.Transparency=0.85
	Camera_Part.Shape=Enum.PartType.Ball
	Camera_Part.Size=Vector3.new(0.5,0.5,0.5)
	Camera_Part.Material=Enum.Material.SmoothPlastic

	current_position=char.Head.Position

	camera.CameraSubject=Camera_Part



	for i,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") and v.Parent:IsA("Accessory")==false then
			v:Destroy()
		end
	end


	while wait() do
		if vbreak==true then
			break
		end
		if input:IsKeyDown(Enum.KeyCode.D) then
			current_position+=camera.CFrame.RightVector*speed
		end
		if input:IsKeyDown(Enum.KeyCode.A) then
			current_position+=camera.CFrame.RightVector*-speed
		end
		if input:IsKeyDown(Enum.KeyCode.W) then
			current_position+=camera.CFrame.LookVector*speed
		end
		if input:IsKeyDown(Enum.KeyCode.S) then
			current_position+=camera.CFrame.LookVector*-speed
		end
		if input:IsKeyDown(Enum.KeyCode.E) then
			current_position+=camera.CFrame.UpVector*speed
		end
		if input:IsKeyDown(Enum.KeyCode.Q) then
			current_position+=camera.CFrame.UpVector*-speed
		end
		if input:IsKeyDown(Enum.KeyCode.LeftShift) then do
				speed=1.5
			end else
			speed=0.75
		end
		Camera_Part.Position=current_position
	end
end)

cmd.add({"unspblockspam","unstarterblockscam"},{"unspblockspam (unstarterblockspam)","Stops the starterblockspam command"},function()
	anniblockspam=false
end)

cmd.add({"blockspam"},{"blockspam [amount]","Spawn blocks by the given amount"},function(amt)
	amt=tonumber(amt) or 1
	local hatAmount,grabbed=0,{}
	local lastCF=character.PrimaryPart.CFrame
	character:ClearAllChildren()
	respawn()
	repeat
		if character.Name~="respawn_" then
			local c=character
			repeat wait() until c:FindFirstChildWhichIsA("Accoutrement")
			c:MoveTo(lastCF.p)
			wait(1)
			for i,v in pairs(c:GetChildren()) do
				if v:IsA("Accoutrement") then
					v:WaitForChild("Handle")
					v.Handle.CanCollide=true
					if v:FindFirstChildWhichIsA("DataModelMesh",true) then
						v:FindFirstChildWhichIsA("DataModelMesh",true):Destroy()
					end
					v.Parent=SafeGetService("Workspace")
					table.insert(grabbed,v)
				end
			end
			hatAmount=hatAmount+1
		end
		character:ClearAllChildren()
		respawn()
		wait()
	until
	hatAmount >=amt

	repeat wait() until tostring(localPlayer.Character)~="respawn_" and localPlayer.Character
	wait(0.5)

	spawn(function()
		repeat wait() until character.PrimaryPart
		wait(0.2)
		character:SetPrimaryPartCFrame(lastCF)

		for _,item in pairs(grabbed) do
			if item:IsA("Accoutrement") and item:FindFirstChild("Handle") then
				item.Parent=SafeGetService("Workspace")
				wait()
			end
		end
	end)
end)

cmd.add({"hitboxes"},{"hitboxes","shows all the hitboxes"},function()
	settings():GetService("RenderSettings").ShowBoundingBoxes=true
end)

cmd.add({"unhitboxes"},{"unhitboxes","removes the hitboxes outline"},function()
	settings():GetService("RenderSettings").ShowBoundingBoxes=false
end)

cmd.add({"punch"},{"punch","punch tool that flings"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/punch.lua",true))()
end)

cmd.add({"vfly","vehiclefly"},{"vehiclefly (vfly)","be able to fly vehicles"},function(...)
	if IsOnMobile then
		DoNotif("command not supported for mobile :(")
	else
		FLYING=false
		cmdlp.Character.Humanoid.PlatformStand=false
		wait()



		wait();

		DoNotif("Vehicle fly enabled")
		sFLY(true)
		speedofthevfly=(...)
		if (...)==nil then
			speedofthevfly=2
		end
	end
end)

cmd.add({"unvfly","unvehiclefly"},{"unvehiclefly (unvfly)","disable vehicle fly"},function()



	wait();

	DoNotif("Vehicle fly disabled")
	FLYING=false
	cmdlp.Character.Humanoid.PlatformStand=false
end)

cmd.add({"toolblockspam"},{"toolblockspam [amount]","Spawn blocks by the given amount"},function(amt)
	if not amt then amt=1 end
	amt=tonumber(amt)
	local tools=getTools(amt)
	for i,tool in pairs(tools) do
		wait()
		spawn(function()
			wait(0.1)
			tool.Parent=character
			tool.CanBeDropped=true
			wait(0.1)
			for _,mesh in pairs(tool:GetDescendants()) do
				if mesh:IsA("DataModelMesh") then
					mesh:Destroy()
				end
			end
			for _,weld in pairs(character:GetDescendants()) do
				if weld.Name=="RightGrip" then
					weld:Destroy()
				end
			end
			wait(0.1)
			tool.Parent=SafeGetService("Workspace")
			wait(0.1)
			local cf,p=CFrame.new(),character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
			if p then
				cf=p.CFrame
			end
			respawn()
			player.CharacterAdded:wait(1); wait(0.2);
			character:WaitForChild("HumanoidRootPart").CFrame=cf
		end)
	end
end)

cmd.add({"equiptools","equipall"},{"equiptools","Equip all of your tools"},function()
	local backpack=getBp()
	if backpack then
		for _,tool in pairs(backpack:GetChildren()) do
			if tool:IsA("Tool") then
				tool.Parent=character
			end
		end
	end
end)

cmd.add({"tweento","tweengoto"},{"tweengoto (tweento)","Teleportation method that bypassses some anticheats"},function(...)
	local Username=(...)


	char=SafeGetService("Players").LocalPlayer

	TweenService=SafeGetService("TweenService")

	speaker=SafeGetService("Players").LocalPlayer
	Players=SafeGetService("Players")

	local players=getPlr(Username)
	TweenService:Create(getRoot(speaker.Character),TweenInfo.new(2,Enum.EasingStyle.Linear),{CFrame=getRoot(players.Character).CFrame+Vector3.new(3,1,0)}):Play()

end)

cmd.add({"reach"},{"reach {number}","Sword reach"},function(reachsize)
	local reachsize=reachsize or 25
	local Tool=getChar():FindFirstChildOfClass("Tool") or getBp():FindFirstChildOfClass("Tool")
	if Tool:FindFirstChild("OGSize3") then
		Tool.Handle.Size=Tool.OGSize3.Value
		Tool.OGSize3:Destroy()
		Tool.Handle.FunTIMES:Destroy()
	end
	local val=Instance.new("Vector3Value",Tool)
	val.Name="OGSize3"
	val.Value=Tool.Handle.Size
	local sb=Instance.new("SelectionBox")
	sb.Adornee=Tool.Handle
	sb.Name="FunTIMES"
	sb.Parent=Tool.Handle
	Tool.Handle.Massless=true
	Tool.Handle.Size=Vector3.new(Tool.Handle.Size.X,Tool.Handle.Size.Y,reachsize)
end)

cmd.add({"boxreach", "aura"},{"boxreach {number} (aura)","Increases the hitbox of your held tool in a box shape"},function(reachsize)
	local reachsize=reachsize or 25
	local Tool=getChar():FindFirstChildOfClass("Tool") or getBp():FindFirstChildOfClass("Tool")
	if Tool:FindFirstChild("OGSize3") then
		Tool.Handle.Size=Tool.OGSize3.Value
		Tool.OGSize3:Destroy()
		Tool.Handle.FunTIMES:Destroy()
	end
	local val=Instance.new("Vector3Value",Tool)
	val.Name="OGSize3"
	val.Value=Tool.Handle.Size
	local sb=Instance.new("SelectionBox")
	sb.Adornee=Tool.Handle
	sb.Name="FunTIMES"
	sb.Parent=Tool.Handle
	Tool.Handle.Massless=true
	Tool.Handle.Size=Vector3.new(reachsize,reachsize,reachsize)
end)

AntiVoidConnect = nil

cmd.add({"antivoid"},{"antivoid","Prevents you from falling into the void by launching you upwards"},function(reachsize)
	wait()
	if AntiVoidConnect then AntiVoidConnect:Disconnect() AntiVoidConnect=nil end
	AntiVoidConnect = RunService.Stepped:Connect(function()
		local root = getRoot(LocalPlayer.Character)
		if root and root.Position.Y <= OrgDestroyHeight + 25 then
			root.Velocity = root.Velocity + Vector3.new(0, 250, 0)
		end
	end)
	DoNotif("Enabled",3,"antivoid")
end)

cmd.add({"unantivoid"},{"unantivoid","Disables antivoid"},function(reachsize)
	if AntiVoidConnect then AntiVoidConnect:Disconnect() AntiVoidConnect=nil end
	DoNotif("Disabled",3,"antivoid")
end)

cmd.add({"droptools"},{"dropalltools","Drop all of your tools"},function()
	local backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
	if backpack then
		for _,tool in pairs(backpack:GetChildren()) do
			if tool:IsA("Tool") then
				tool.Parent=character
			end
		end
	end
	wait()
	for _,tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			tool.Parent=SafeGetService("Workspace")
		end
	end
end)

cmd.add({"notools"},{"notools","Remove your tools"},function()
	for _,tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			tool:Destroy()
		end
	end
	for _,tool in pairs(localPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			tool:Destroy()
		end
	end
end)

cmd.add({"breaklayeredclothing","blc"},{"breaklayeredclothing (blc)","Streches your layered clothing"},function()
	--its literally just leg resize with swim
	wait();

	DoNotif("Break layered clothing executed,if you havent already equip shirt,jacket,pants and shoes (Layered Clothing ones)")
	local swimming=false
	local RunService=SafeGetService("RunService")
	oldgrav=SafeGetService("Workspace").Gravity
	SafeGetService("Workspace").Gravity=0
	local char=getChar()
	local swimDied=function()
		SafeGetService("Workspace").Gravity=oldgrav
		swimming=false
	end
	local Humanoid=char:FindFirstChildWhichIsA("Humanoid")
	gravReset=Humanoid.Died:Connect(swimDied)
	local enums=Enum.HumanoidStateType:GetEnumItems()
	table.remove(enums,table.find(enums,Enum.HumanoidStateType.None))
	for i,v in pairs(enums) do
		Humanoid:SetStateEnabled(v,false)
	end
	Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	swimbeat=RunService.Heartbeat:Connect(function()
		pcall(function()
			getRoot(char).Velocity=((Humanoid.MoveDirection~=Vector3.new() or UserInputService:IsKeyDown(Enum.KeyCode.Space)) and getRoot(char).Velocity or Vector3.new())
		end)
	end)
	swimming=true
	local Clip=false
	wait(0.1)
	function NoclipLoop()
		if Clip==false and char~=nil then
			for _,child in pairs(char:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide==true then
					child.CanCollide=false
				end
			end
		end
	end
	Noclipping=RunService.Stepped:Connect(NoclipLoop)
	loadstring(game:HttpGet('https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/legresize.lua'))()
end)


cmd.add({"fpsbooster","lowgraphics","boostfps","lowg"},{"fpsbooster (lowgraphics,boostfps,lowg)","Low graphics mode if the game is laggy"},function()
	local decalsyeeted=true
	local g=game
	local w=g:GetService("Workspace")
	local l=g.Lighting
	local t=w.Terrain
	sethiddenproperty(l,"Technology",2)
	sethiddenproperty(t,"Decoration",false)
	t.WaterWaveSize=0
	t.WaterWaveSpeed=0
	t.WaterReflectance=0
	t.WaterTransparency=0
	l.GlobalShadows=0
	l.FogEnd=9e9
	l.Brightness=0
	settings().Rendering.QualityLevel="Level01"
	for i,v in pairs(w:GetDescendants()) do
		if v:IsA("BasePart") and not v:IsA("MeshPart") then
			v.Material="Plastic"
			v.Reflectance=0
		elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
			v.Transparency=1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime=NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure=1
			v.BlastRadius=1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled=false
		elseif v:IsA("MeshPart") and decalsyeeted then
			v.Material="Plastic"
			v.Reflectance=0
			v.TextureID=10385902758728957
		elseif v:IsA("SpecialMesh") and decalsyeeted  then
			v.TextureId=0
		elseif v:IsA("ShirtGraphic") and decalsyeeted then
			v.Graphic=0
		elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
			v[v.ClassName.."Template"]=0
		end
	end
	for i=1,#l:GetChildren() do
		e=l:GetChildren()[i]
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled=false
		end
	end
	w.DescendantAdded:Connect(function(v)
		wait()--prevent errors and shit
		if v:IsA("BasePart") and not v:IsA("MeshPart") then
			v.Material="Plastic"
			v.Reflectance=0
		elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
			v.Transparency=1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime=NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure=1
			v.BlastRadius=1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled=false
		elseif v:IsA("MeshPart") and decalsyeeted then
			v.Material="Plastic"
			v.Reflectance=0
			v.TextureID=10385902758728957
		elseif v:IsA("SpecialMesh") and decalsyeeted then
			v.TextureId=0
		elseif v:IsA("ShirtGraphic") and decalsyeeted then
			v.ShirtGraphic=0
		elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
			v[v.ClassName.."Template"]=0
		end
	end)
end)

	--[[cmd.add({"vr","clovr","vrscript","fevr"},{"vr (clovr,vrscript,fevr)","FE VR SCRIPT AKA CLOVR"},function()
		--should be patched--
	 loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/CloVR"))();
	 end)]]

cmd.add({"antilag","boostfps"},{"antilag (boostfps)","Low Graphics"},function()
	_G.Settings={
		Players={
			["Ignore Me"]=true,
			["Ignore Others"]=true
		},
		Meshes={
			Destroy=false,
			LowDetail=true
		},
		Images={
			Invisible=true,
			LowDetail=true,
			Destroy=true,
		},
		Other={
			["No Particles"]=true,
			["No Camera Effects"]=true,
			["No Explosions"]=true,
			["No Clothes"]=true,
			["Low Water Graphics"]=true,
			["No Shadows"]=true,
			["Low Rendering"]=true,
			["Low Quality Parts"]=true
		}
	}
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/low%20detail"))()
end)

local annoyloop=false
cmd.add({"annoy"},{"annoy <player>","Annoys the given player"},function(...)
	annoyloop=true
	User=(...)
	Target=getPlr(User)
	local SaveCFrame=getRoot(getChar()).CFrame
	repeat wait()
		getRoot(getChar()).CFrame=getRoot(Target.Character).CFrame+Vector3.new(math.random(-2,2),math.random(0,2),math.random(-2,2))
		SafeGetService('RunService').RenderStepped:Wait()
		wait(.1)
	until annoyloop==false
	getRoot(getChar()).CFrame=SaveCFrame

end)

cmd.add({"unannoy"},{"unannoy","Stops the annoy command"},function()
	annoyloop=false
end)

cmd.add({"deleteinvisparts","deleteinvisibleparts","dip"},{"deleteinvisparts (deleteinvisibleparts,dip)","Deletes invisible parts"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency==1 and v.CanCollide then
			v:Destroy()
		end
	end
end)

local shownParts={}

cmd.add({"invisibleparts","invisparts"},{"invisibleparts (invisparts)","Shows invisible parts"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency==1 then
			if not table.find(shownParts,v) then
				table.insert(shownParts,v)
			end
			v.Transparency=0
		end
	end
end)

cmd.add({"uninvisibleparts","uninvisparts"},{"uninvisibleparts (uninvisparts)","Makes parts affected by invisparts return to normal"},function()
	for i,v in pairs(shownParts) do
		v.Transparency=1
	end
	shownParts={}
end)

cmd.add({"replicationlag","backtrack"},{"replicationlag (backtrack)","Set IncomingReplicationLag"},function(...)
	local t={...}
	local args=t[1]

	if tonumber(args) then
		settings():GetService("NetworkSettings").IncomingReplicationLag=args
	end
end)

cmd.add({"norender"},{"norender","Disable 3d Rendering to decrease the amount of CPU the client uses"},function(...)
	RunService:Set3dRenderingEnabled(false)
end)

cmd.add({"render"},{"render","Enable 3d Rendering"},function(...)
	RunService:Set3dRenderingEnabled(true)
end)

oofing=false

cmd.add({"loopoof"},{"loopoof","Loops everyones character sounds (everyone can hear)"},function(...)
	oofing=true
	repeat wait(0.1)
		for i,v in pairs(Players:GetPlayers()) do
			if v.Character~=nil and v.Character:FindFirstChild'Head' then
				for _,x in pairs(v.Character.Head:GetChildren()) do
					if x:IsA'Sound' then x.Playing=true end
				end
			end
		end
	until oofing==false
end)

cmd.add({"unloopoof"},{"unloopoof","Stops the oof chaos"},function(...)
	oofing=false
end)

cmd.add({"strengthen"},{"strengthen","Makes your character more dense (CustomPhysicalProperties)"},function(...)
	local args={...}
	for _,child in pairs(Player.Character:GetDescendants()) do
		if child.ClassName=="Part" then
			if args[1] then
				child.CustomPhysicalProperties=PhysicalProperties.new(args[1],0.3,0.5)
			else
				child.CustomPhysicalProperties=PhysicalProperties.new(100,0.3,0.5)
			end
		end
	end
end)

cmd.add({"unweaken","unstrengthen"},{"unweaken (unstrengthen)","Sets your characters CustomPhysicalProperties to default"},function(...)
	for _,child in pairs(Player.Character:GetDescendants()) do
		if child.ClassName=="Part" then
			child.CustomPhysicalProperties=PhysicalProperties.new(0.7,0.3,0.5)
		end
	end
end)

cmd.add({"weaken"},{"weaken","Makes your character less dense"},function(...)
	local args={...}
	for _,child in pairs(Player.Character:GetDescendants()) do
		if child.ClassName=="Part" then
			if args[1] then
				child.CustomPhysicalProperties=PhysicalProperties.new(-args[1],0.3,0.5)
			else
				child.CustomPhysicalProperties=PhysicalProperties.new(0,0.3,0.5)
			end
		end
	end
end)

cmd.add({"seat"},{"seat","Finds a seat and automatically sits on it"},function()
	local seats={}
	for i,v in next,game:GetDescendants() do
		if v:IsA'Seat' then
			table.insert(seats,v)
		end
	end
	wait(0.07)
	for i=1,8 do
		seats[math.random(1,#seats)]:Sit(getChar().Humanoid)
	end
end)

local massplay=false
cmd.add({"sync"},{"sync","Syncs all in-game audios"},function()
	massplay=true
	if SafeGetService("SoundService").RespectFilteringEnabled==false then
		repeat wait() do 
				for _,sound in next,SafeGetService("Workspace"):GetDescendants() do
					if sound:IsA("Sound") then
						sound.Volume=10
						sound:Play()
					end
				end
			end
		until massplay==false
	else
		DoNotif("Sorry,wont replicate for this game,try another game.")
	end
end)

cmd.add({"unsync"},{"unsync","Unsyncs all in-game audios"},function()
	massplay=false
end)

cmd.add({"enableinventory","enableinv"},{"enableinv (enableinventory)","Lets you see what you have in your inventory since some games hide it"},function(...)
	SafeGetService("StarterGui"):SetCoreGuiEnabled(2,true)
end)

cmd.add({"copytools","ctools"},{"copytools <player> (ctools)","Copies the tools the given player has"},function(...)
	PLAYERNAMEHERE=(...)
	Target=getPlr(PLAYERNAMEHERE)
	for i,v in pairs(Target.Backpack:GetChildren()) do
		if v:IsA("Tool") or v:IsA('HopperBin') then
			v:Clone().Parent=SafeGetService("Players").LocalPlayer:FindFirstChildOfClass("Backpack")
		end
	end
end)

cmd.add({"localtime","yourtime"},{"localtime (yourtime)","Shows your current time"},function()
	local hour=os.date("*t")['hour']
	if hour<10 then
		hour="0"..hour
	end
	local min=os.date("*t")['min']
	if min<10 then
		min="0"..min
	end
	local sec=os.date("*t")['sec']
	if sec<10 then
		sec="0"..sec
	end
	local clock=hour..":"..min..":"..sec

	DoNotif("Your Local Time Is: "..clock)
end)

cmd.add({"cartornado","ctornado"},{"cartornado (ctornado)","Tornados a car just sit in the car"},function(...)
	local SPart=Instance.new("Part");
	local Player=SafeGetService('Players').LocalPlayer;
	repeat SafeGetService('RunService').RenderStepped:Wait() until Player.Character;
	local Character=Player.Character;
	SPart.Anchored,SPart.CanCollide=true,true;
	SPart.Parent=SafeGetService("Workspace");
	SPart.Size=Vector3.new(1,100,1)
	SPart.Transparency=0.4
	RunService.Stepped:Connect(function()
		local Ray=Ray.new(Character.PrimaryPart.Position+Character.PrimaryPart.CFrame.LookVector*6,Vector3.new(0,-1,0)*4);
		local FPOR=SafeGetService("Workspace"):FindPartOnRayWithIgnoreList(Ray,{Character});
		if (FPOR) then
			SPart.CFrame=Character.PrimaryPart.CFrame+Character.PrimaryPart.CFrame.LookVector*6;
		end
		if SPart==nil then
			Ray:destroy()
			FPOR:destroy()
		end
	end)

	SPart.Touched:Connect(function(hit)
		if hit:IsA("Seat") then
			local IsFlying=False
			local flyv
			local flyg
			local Player=SafeGetService("Players").LocalPlayer
			local Speed=50
			local LastSpeed=Speed
			local maxspeed=100
			local IsRunning=false
			local f=0

			IsFlying=true
			flyv=Instance.new("BodyVelocity")

			flyv.Parent=Player.Character:FindFirstChild('Torso') or Player.Character:FindFirstChild('UpperTorso')
			flyv.MaxForce=Vector3.new(math.huge,math.huge,math.huge)

			flyg=Instance.new("BodyGyro")
			flyg.Parent=Player.Character:FindFirstChild('Torso') or Player.Character:FindFirstChild('UpperTorso')
			flyg.MaxTorque=Vector3.new(9e9,9e9,9e9)
			flyg.P=1000
			flyg.D=50

			Player.Character:WaitForChild('Humanoid').PlatformStand=true

			Player.Character.Humanoid.Changed:Connect(function(Prop)

				if Player.Character.Humanoid.MoveDirection==Vector3.new(0,0,0) then
					IsRunning=false
				else
					IsRunning=true
				end 
			end)

			spawn(function()
				while true do
					wait()
					if IsFlying then

						flyg.CFrame=SafeGetService("Workspace").CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad((f+0)*50*Speed/maxspeed),0,0) 
						flyv.Velocity=SafeGetService("Workspace").CurrentCamera.CoordinateFrame.LookVector*Speed
						wait(0.1)

						if Speed<0 then
							Speed=0
							f=0
						end
					end
					if IsRunning then
						Speed=LastSpeed
					else
						if not Speed==0 then
							LastSpeed=Speed
						end 
						Speed=0
					end
				end
			end)
			Speed=0.1
			wait(0.3)
			hit:Sit(getChar().Humanoid)
			SPart:Destroy()
			wait(0.3)
			local speaker=SafeGetService("Players").LocalPlayer
			local seat=speaker.Character:FindFirstChildOfClass('Humanoid').SeatPart
			local vehicleModel=seat.Parent
			repeat
				if vehicleModel.ClassName~="Model" then
					vehicleModel=vehicleModel.Parent
				end
			until vehicleModel.ClassName=="Model"
			wait(0.1)
			for i,v in pairs(vehicleModel:GetDescendants()) do
				if v:IsA("BasePart") and v.CanCollide then
					v.CanCollide=false
				end
			end

			wait(0.2)
			Speed=80
			local Spin=Instance.new("BodyAngularVelocity")
			Spin.Name="Spinning"
			Spin.Parent=getRoot(speaker.Character)
			Spin.MaxTorque=Vector3.new(0,math.huge,0) 
			Spin.AngularVelocity=Vector3.new(0,2000,0)
		end
	end)
end)

cmd.add({"unspam","unlag","unchatspam","unanimlag","unremotespam"},{"unspam","Stop all attempts to lag/spam"},function()
	lib.disconnect("spam")
end)

cmd.add({"UNCTest","UNC"},{"UNCTest (UNC)","Test how many functions your executor supports"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/UNC%20test"))()
end)

cmd.add({"vulnerabilitytest","vulntest"},{"vulnerabilitytest (vulntest)","Test if your executor is Vulnerable"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/VulnTest.lua"))()
end)

cmd.add({"respawn","re"},{"respawn","Respawn your character"},function()
	local old=getRoot(getChar()).CFrame
	respawn()
	wait()
	plr.CharacterAdded:Wait()
	getChar():WaitForChild("HumanoidRootPart").CFrame=old
end)

cmd.add({"seizure"},{"seizure","Gives you a seizure"},function()

	spawn(function()
		local Anim=Instance.new("Animation")
		if getChar():FindFirstChild("UpperTorso") then
			Anim.AnimationId="rbxassetid://507767968"
		else
			Anim.AnimationId="rbxassetid://180436148"
		end
		local k=getChar().Humanoid:LoadAnimation(Anim)
		getgenv().ssss=SafeGetService("Players").LocalPlayer:GetMouse()
		getgenv().Lzzz=false

		if Lzzz==false then
			getgenv().Lzzz=true
			if getChar():FindFirstChild("UpperTorso") then
				Anim.AnimationId="rbxassetid://507767968"
			else
				Anim.AnimationId="rbxassetid://180436148"
			end
			getgenv().currentnormal=SafeGetService("Workspace").Gravity
			SafeGetService("Workspace").Gravity=196.2
			getChar():PivotTo(getChar():GetPivot()*CFrame.Angles(2,0,0))
			wait(0.5)
			getChar().Humanoid.PlatformStand=true
			getChar().Animate.Disabled=true

			k:Play()
			k:AdjustSpeed(10)

			getChar().Animate.Disabled=true
		else
			getgenv().Lzzz=false
			if getChar():FindFirstChild("UpperTorso") then
				Anim.AnimationId="rbxassetid://507767968"
			else
				Anim.AnimationId="rbxassetid://180436148"
			end
			SafeGetService("Workspace").Gravity=currentnormal
			getChar().Humanoid.PlatformStand=false
			getChar().Humanoid.Jump=true
			k:Stop()

			getChar().Animate.Disabled=false
			SafeGetService'RunService'.Heartbeat:Wait()
			for i=1,10 do

				getRoot(getChar()).AssemblyLinearVelocity=Vector3.new(0,0,0)
				wait(0.1)
			end
		end
		RunService.RenderStepped:Connect(function()
			if Lzzz==true then
				getRoot(getChar()).CFrame=getRoot(getChar()).CFrame*CFrame.new(.075*math.sin(45*tick()),.075*math.sin(45*tick()),.075*math.sin(45*tick()))--angle*math.sin(velocity*tick())
			end
		end)
	end)

end)

cmd.add({"unseizure"},{"unseizure","Stops you from having a seizure not in real life noob"},function(n)

	spawn(function()
		local Anim=Instance.new("Animation")
		if getChar():FindFirstChild("UpperTorso") then
			Anim.AnimationId="rbxassetid://507767968"
		else
			Anim.AnimationId="rbxassetid://180436148"
		end
		local k=getChar().Humanoid:LoadAnimation(Anim)
		getgenv().ssss=SafeGetService("Players").LocalPlayer:GetMouse()
		getgenv().Lzzz=true

		if Lzzz==false then
			getgenv().Lzzz=true
			if getChar():FindFirstChild("UpperTorso") then
				Anim.AnimationId="rbxassetid://507767968"
			else
				Anim.AnimationId="rbxassetid://180436148"
			end
			getgenv().currentnormal=SafeGetService("Workspace").Gravity
			SafeGetService("Workspace").Gravity=196.2
			getChar():PivotTo(getChar():GetPivot()*CFrame.Angles(2,0,0))
			wait(0.5)
			getChar().Humanoid.PlatformStand=true
			getChar().Animate.Disabled=true

			k:Play()
			k:AdjustSpeed(10)

			getChar().Animate.Disabled=true
		else
			getgenv().Lzzz=false
			if getChar():FindFirstChild("UpperTorso") then
				Anim.AnimationId="rbxassetid://507767968"
			else
				Anim.AnimationId="rbxassetid://180436148"
			end
			SafeGetService("Workspace").Gravity=currentnormal
			getChar().Humanoid.PlatformStand=false
			getChar().Humanoid.Jump=true
			k:Stop()

			getChar().Animate.Disabled=false
			SafeGetService'RunService'.Heartbeat:Wait()
			for i=1,10 do

				getRoot(getChar()).AssemblyLinearVelocity=Vector3.new(0,0,0)
				wait(0.1)
			end
		end
		RunService.RenderStepped:Connect(function()
			if Lzzz==true then
				getRoot(getChar()).CFrame=getRoot(getChar()).CFrame*CFrame.new(.075*math.sin(45*tick()),.075*math.sin(45*tick()),.075*math.sin(45*tick()))--angle*math.sin(velocity*tick())
			end
		end)
	end)

end)

cmd.add({"antisit"},{"antisit","Antisit"},function()
	Player.Character.Humanoid:SetStateEnabled("Seated",false)
	Player.Character.Humanoid.Sit=true



	wait();

	DoNotif("Anti sit enabled")
end)

cmd.add({"unantisit"},{"unantisit","Disable antisit command"},function()
	Player.Character.Humanoid:SetStateEnabled("Seated",true)
	Player.Character.Humanoid.Sit=false



	wait();

	DoNotif("Anti sit disabled")
end)

cmd.add({"antikick","nokick","bypasskick","bk"},{"antikick (nokick,bypasskick,bk)","Bypass Kick on Most Games"},function()
	--loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/btrAntiKick.lua"))()--Better Version
	local getrawmt = (debug and debug.getmetatable) or getrawmetatable
	local setReadOnly = setreadonly
		or (
			make_writeable
			and function(table, readonly)
				if readonly then
					make_readonly(table)
				else
					make_writeable(table)
				end
			end
		)
	local meta = getrawmt(game)
	local namecall = meta.__namecall
	setReadOnly(meta, false)
	meta.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		if method == "Kick" then
			return DoNotif("A kick was prevented from running.")
		end
		return namecall(self, ...)
	end)
	setReadOnly(meta, true)

	DoNotif("Anti Kick Enabled.")
end)

cmd.add({"bypassteleport","btp"},{"bypassteleport (btp)","Bypass Teleportation on Most Games"},function()
	local getrawmt = (debug and debug.getmetatable) or getrawmetatable
	local setReadOnly = setreadonly
		or (
			make_writeable
			and function(table, readonly)
				if readonly then
					make_readonly(table)
				else
					make_writeable(table)
				end
			end
		)
	local lp = game:GetService("Players").LocalPlayer
	local meta = getrawmt(game)
	local caller = checkcaller or is_protosmasher_caller
	local index = meta.__index
	local newindex = meta.__newindex
	local namecall = meta.__namecall
	setReadOnly(meta, false)
	meta.__newindex = newcclosure(function(self, meme, value)
		if caller() then
			return newindex(self, meme, value)
		end
		if
			tostring(self) == "HumanoidRootPart"
			or tostring(self) == "Torso"
			or tostring(self) == "UpperTorso"
		then
			if meme == "CFrame" or meme == "Position" then
				return true
			end
		end
		return newindex(self, meme, value)
	end)
	setReadOnly(meta, true)

	DoNotif("teleport bypass enabled.")
end)

cmd.add({"anticframeteleport","acframetp","acftp"},{"anticframeteleport (acframetp,acftp)","If a script tries to teleport you somewhere,it shouldn't work"},function()
	local allow,Old=nil,nil
	getgenv().acftp=true

	wait();

	DoNotif("nothing should be able to teleport you now")

	root=getRoot(plr.Character)

	con(root:GetPropertyChangedSignal("CFrame"),function() 
		if getgenv().acftp then
			allow=true
			root.CFrame=Old
			Wait();
			allow=false
		end
	end)

	repeat wait() Old=root.CFrame until not root
end)

cmd.add({"unanticframeteleport","unacframetp","unacftp"},{"unanticframeteleport (unacframetp,unacftp)","Stops the Anti CFrame Teleport"},function()
	getgenv().acftp=false

	wait();

	DoNotif("Anti CFrame Teleport disabled")
end)

cmd.add({"lay"},{"lay","zzzzzzzz"},function()
	local Human=getHum()
	if not Human then return end
	Human.Sit=true
	task.wait(.1)
	Human.RootPart.CFrame=Human.RootPart.CFrame*CFrame.Angles(math.pi*.5,0,0)
	for _,v in ipairs(Human:GetPlayingAnimationTracks()) do
		v:Stop()
	end
end)

cmd.add({"trip"},{"trip","get up NOW"},function()
	getChar():FindFirstChildOfClass("Humanoid"):ChangeState(0)
	getChar():FindFirstChild("HumanoidRootPart").Velocity=getChar():FindFirstChild("HumanoidRootPart").CFrame.LookVector*25
end)

cmd.add({"checkrfe"},{"checkrfe","Checks if the game has respect filtering enabled off"},function()
	if SafeGetService("SoundService").RespectFilteringEnabled==true then
		DoNotif("Respect Filtering Enabled is on")
	else
		DoNotif("Respect Filtering Enabled is off")
	end
end)

cmd.add({"sit"},{"sit","Sit your player"},function()
	local hum=character:FindFirstChildWhichIsA("Humanoid")
	if hum then
		hum.Sit=true
	end
end)

cmd.add({"spin"},{"spin","Spin yourself at the speed you want"},function(d)
	local spinSpeed=tonumber(d)
	if d and isNumber(d) then
		spinSpeed=(d)
	end
	for i,v in pairs(getRoot(getChar()):GetChildren()) do
		if v.Name=="Spinning" then
			v:Destroy()
		end
	end
	local Spin=Instance.new("BodyAngularVelocity")
	Spin.Name="Spinning"
	Spin.Parent=getRoot(speaker.Character)
	Spin.MaxTorque=Vector3.new(0,math.huge,0)
	Spin.AngularVelocity=Vector3.new(0,spinSpeed,0)
end)

cmd.add({"oldroblox"},{"oldroblox","Old skybox and studs"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("BasePart") then
			local dec=Instance.new("Texture",v)
			dec.Texture="rbxassetid://48715260"
			dec.Face="Top"
			dec.StudsPerTileU="1"
			dec.StudsPerTileV="1"
			dec.Transparency=v.Transparency
			v.Material="Plastic"
			local dec2=Instance.new("Texture",v)
			dec2.Texture="rbxassetid://20299774"
			dec2.Face="Bottom"
			dec2.StudsPerTileU="1"
			dec2.StudsPerTileV="1"
			dec2.Transparency=v.Transparency
			v.Material="Plastic"
		end
	end
	SafeGetService("Lighting").ClockTime=12
	SafeGetService("Lighting").GlobalShadows=false
	SafeGetService("Lighting").Outlines=false
	for i,v in pairs(SafeGetService("Lighting"):GetDescendants()) do
		if v:IsA("Sky") then
			v:Destroy()
		end
	end
	local sky=Instance.new("Sky",SafeGetService("Lighting"))
	sky.SkyboxBk="rbxassetid://161781263"
	sky.SkyboxDn="rbxassetid://161781258"
	sky.SkyboxFt="rbxassetid://161781261"
	sky.SkyboxLf="rbxassetid://161781267"
	sky.SkyboxRt="rbxassetid://161781268"
	sky.SkyboxUp="rbxassetid://161781260"
end)

cmd.add({"f3x","fex"},{"f3x","F3X for client"},function()
	loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)

cmd.add({"dupetools"},{"dupetools [amount]","Probably the fastest tool duping method"},function(...)
	_G.ammount=(...)
	for i=1,_G.ammount do
		loadstring(game:HttpGet("https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/dupetools.lua",true))()
	end
end)

cmd.add({"triggerbot","tbot"},{"triggerbot (tbot)","Executes a script that automatically clicks the mouse when the mouse is on a player"},function()
	local ToggleKey=Enum.KeyCode.Q


	local Player=SafeGetService("Players").LocalPlayer
	local Char=Player.Character or player.CharacterAdded:wait(1)
	local Root=getRoot(Char) or Char:WaitForChild("HumanoidRootPart")
	local Camera=SafeGetService("Workspace").CurrentCamera
	local Mouse=Player:GetMouse()
	local PlayerTeam=Player.Team
	local Neutral=Player.Neutral
	local UIS=SafeGetService("UserInputService")
	local Toggled=false

	---==GUI==---
	local GUI=Instance.new("ScreenGui")
	local On=Instance.new("TextLabel")
	local uicorner=Instance.new("UICorner")
	GUI.Name="GUI"
	GUI.Parent=COREGUI
	On.Name="On"
	On.Parent=GUI
	On.BackgroundColor3=Color3.fromRGB(12,4,20)
	On.BackgroundTransparency=0.14
	On.BorderSizePixel=0
	On.Position=UDim2.new(0.880059958,0,0.328616381,0)
	On.Size=UDim2.new(0,160,0,20)
	On.Font=Enum.Font.SourceSans
	On.Text="TriggerBot On: false"
	On.TextColor3=Color3.new(1,1,1)
	On.TextScaled=true
	On.TextSize=14
	On.TextWrapped=true
	uicorner.Parent=On
	---End Gui--

	local FindTeams=function()
		local CC1=false
		local CC2=false

		if PlayerTeam~=nil and Neutral==false then
			if #SafeGetService("Teams"):GetTeams()>0 then
				CC1=true
				for i,v in pairs(SafeGetService("Teams"):GetTeams()) do
					if #v:GetPlayers()>0 and v~=PlayerTeam and CC1==true then
						CC2=true
					elseif #v:GetPlayers() <=0 and CC1==true then
						return "FFA"
					end
				end
			elseif #SafeGetService("Teams"):GetTeams() <=0 then
				return "FFA"
			end
		elseif Neutral==true then
			return "FFA"	
		elseif PlayerTeam==nil then
			return "FFA"
		end
		if CC1==true and CC2==true then
			return "TEAMS"
		end
	end
	--{[/| Functions |\]}--

	function Click()
		mouse1click()
		--print("Tripped")
	end
	function CastRay(Mode)
		local RaySPTR=Camera:ScreenPointToRay(Mouse.X,Mouse.Y)--Hence the var name,the magnitude of this is 1.
		local NewRay=Ray.new(RaySPTR.Origin,RaySPTR.Direction*9999)
		local Target,Position=SafeGetService("Workspace"):FindPartOnRayWithIgnoreList(NewRay,{Char,SafeGetService("Workspace").CurrentCamera})
		if Target and Position and SafeGetService("Players"):GetPlayerFromCharacter(Target.Parent) and Target.Parent.Humanoid.Health>0 or Target and Position and SafeGetService("Players"):GetPlayerFromCharacter(Target.Parent.Parent) and Target.Parent.Parent.Humanoid.Health>0 then
			local TPlayer=SafeGetService("Players"):GetPlayerFromCharacter(Target.Parent) or SafeGetService("Players"):GetPlayerFromCharacter(Target.Parent.Parent)
			if TPlayer.Team~=PlayerTeam and Mode~="FFA" and TPlayer~=Player then
				Click()
			elseif TPlayer.Team==PlayerTeam and TPlayer~=Player then
				if Mode=="FFA" then
					Click()
				end
			end
		end
	end
	--End Functions--
	UIS.InputBegan:Connect(function(Input)
		if Input.KeyCode==ToggleKey then
			Toggled=not Toggled
			On.Text="Trigger Bot On: ".. tostring(Toggled)
		end
	end)

	local PreMode=FindTeams()
	local O=false
	SafeGetService("RunService").Stepped:Connect(function()
		local Mode=FindTeams()
		if O==false then
			O=true
			print(Mode)
		end
		if Mode~=PreMode then
			PreMode=Mode
			print(Mode)
		end
		if Toggled==true then

			CastRay(Mode)
		end
	end)

	print("BrokenCoding's Trigger Bot V4 Loaded")
	spawn(function()
		wait(2)
		Loaded:Destroy()
	end)



	wait();

	DoNotif("Keybind: Q")
end)


cmd.add({"nofog"},{"nofog","Removes all fog from the game"},function()
	local Lighting=SafeGetService("Lighting")
	Lighting.FogEnd=100000
	for i,v in pairs(Lighting:GetDescendants()) do
		if v:IsA("Atmosphere") then
			v:Destroy()
		end
	end
end)
local ANTIAFK=nil
cmd.add({"antiafk","noafk"},{"antiafk (noafk)","Makes you not be kicked for being afk for 20 mins"},function()
	if not ANTIAFK then
		ANTIAFK=SafeGetService("Players").LocalPlayer.Idled:connect(function()
			SafeGetService("VirtualUser"):Button2Down(Vector2.new(0,0),SafeGetService("Workspace").CurrentCamera.CFrame)
			task.wait(1)
			SafeGetService("VirtualUser"):Button2Up(Vector2.new(0,0),SafeGetService("Workspace").CurrentCamera.CFrame)
		end)

		wait();

		DoNotif("Anti AFK has been enabled")
	else
		DoNotif("Anti AFK is already enabled")
	end
end)


cmd.add({"antiattach","noattach"},{"antiattach (noattach)","Makes you not be able to be attached by using a item"},function()
	local Tools={}
	for i,v in pairs(getChar():GetChildren()) do
		if v:IsA("Tool") then
			table.insert(Tools,v:GetDebugId())
		end
	end
	for i,v in pairs(SafeGetService("Players").LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(Tools,v:GetDebugId())
		end
	end
	AAttach=getChar().ChildAdded:Connect(function(instance)
		if instance:IsA("Tool") and not table.find(Tools,instance:GetDebugId()) then
			task.wait()
			instance.Parent=nil
		end
	end)



	wait();

	DoNotif("Anti attach enabled")
end)

cmd.add({"unantiattach","unnoattach"},{"unantiattach (unnoattach)","Makes you to be able for others to attach you"},function()
	if AAttach then
		AAttach:Disconnect()



		wait();

		DoNotif("Anti attach disabled")
	else



		wait();

		DoNotif("Anti attach already disabled")
	end
end)

cmd.add({"setspawn","spawnpoint","ss"},{"setspawn (spawnpoint,ss)","Makes your spawn point be in the place where your character is"},function()



	wait();

	DoNotif("Spawn has been set")
	local stationaryrespawn=true
	local needsrespawning=false
	local haspos=false
	local pos=CFrame.new()

	SafeGetService("UserInputService").InputBegan:connect(StatRespawn)

	RunService.Stepped:connect(function()

		if stationaryrespawn==true and getChar().Humanoid.Health==0 then
			if haspos==false then
				pos=getRoot(getChar()).CFrame
				haspos=true
			end
			needsrespawning=true
		end

		if needsrespawning==true then
			getRoot(getChar()).CFrame=pos
		end
	end)

	LocalPlayer.CharacterAdded:connect(function()
		wait(0.6)
		needsrespawning=false
		haspos=false
	end)
end)

cmd.add({"hamster"},{"hamster <number>","Hamster ball"},function(...)
	--[[ skidded ]]--
	local UserInputService=SafeGetService("UserInputService")
	local RunService=SafeGetService("RunService")
	local Camera=SafeGetService("Workspace").CurrentCamera

	local SPEED_MULTIPLIER=(...)
	local JUMP_POWER=60
	local JUMP_GAP=0.3

	if (...)==nil then
		SPEED_MULTIPLIER=30
	end

	local character=getChar()

	for i,v in ipairs(character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide=false
		end
	end

	local ball=getRoot(character)
	ball.Shape=Enum.PartType.Ball
	ball.Size=Vector3.new(5,5,5)
	local humanoid=character:WaitForChild("Humanoid")
	local params=RaycastParams.new()
	params.FilterType=Enum.RaycastFilterType.Blacklist
	params.FilterDescendantsInstances={character}

	local tc=RunService.RenderStepped:Connect(function(delta)
		ball.CanCollide=true
		humanoid.PlatformStand=true
		if UserInputService:GetFocusedTextBox() then return end
		if UserInputService:IsKeyDown("W") then
			ball.RotVelocity-=Camera.CFrame.RightVector*delta*SPEED_MULTIPLIER
		end
		if UserInputService:IsKeyDown("A") then
			ball.RotVelocity-=Camera.CFrame.LookVector*delta*SPEED_MULTIPLIER
		end
		if UserInputService:IsKeyDown("S") then
			ball.RotVelocity+=Camera.CFrame.RightVector*delta*SPEED_MULTIPLIER
		end
		if UserInputService:IsKeyDown("D") then
			ball.RotVelocity+=Camera.CFrame.LookVector*delta*SPEED_MULTIPLIER
		end
	end)

	UserInputService.JumpRequest:Connect(function()
		local result=SafeGetService("Workspace"):Raycast(
			ball.Position,
			Vector3.new(
				0,
				-((ball.Size.Y/2)+JUMP_GAP),
				0
			),
			params
		)
		if result then
			ball.Velocity=ball.Velocity+Vector3.new(0,JUMP_POWER,0)
		end
	end)

	Camera.CameraSubject=ball
	humanoid.Died:Connect(function() tc:Disconnect() end)
end)

cmd.add({"unantiafk","unnoafk"},{"unantiafk (unnoafk)","Makes you able to be kicked for being afk for 20 mins"},function()
	if ANTIAFK then
		ANTIAFK:Disconnect()
		ANTIAFK=nil
		wait();

		DoNotif("Anti AFK disabled")
	else 
		wait();

		DoNotif("Anti AFK already disabled")
	end
end)

cmd.add({"toolgui"},{"toolgui","cool tool ui aka replication ui made by 0866"},function()
	loadstring(game:HttpGet("https://pastebin.com/raw/vr2YVyF6"))();
	wait();

	DoNotif("For a better experience,use R6 if you want tools do ;dupetools 5")
end)

cmd.add({"clicktp","tptool"},{"clicktp (tptool)","Teleport where your mouse is"},function()
	mouse=SafeGetService("Players").LocalPlayer:GetMouse()
	tool=Instance.new("Tool")
	tool.RequiresHandle=false
	tool.Name="Click TP"
	tool.Activated:connect(function()
		local pos=mouse.Hit+Vector3.new(0,2.5,0)
		pos=CFrame.new(pos.X,pos.Y,pos.Z)
		getRoot(getChar()).CFrame=pos
	end)
	tool.Parent=getBp()
	wait(0.07)
	local TweenService=SafeGetService("TweenService")
	local UserInputService=SafeGetService("UserInputService")
	local Players=SafeGetService("Players")

	local tool=Instance.new("Tool")
	tool.RequiresHandle=false
	tool.Name="Tween Click TP"
	function onActivated()
		local mouse=Players.LocalPlayer:GetMouse()
		local pos=mouse.Hit+Vector3.new(0,2.5,0)
		local humanoidRootPart=getRoot(getChar())

		local tweenInfo=TweenInfo.new(
			1,
			Enum.EasingStyle.Quad,	
			Enum.EasingDirection.Out,
			0,
			false,
			0
		)

		local tween=TweenService:Create(humanoidRootPart,tweenInfo,{
			CFrame=CFrame.new(pos.X,pos.Y,pos.Z)
		})

		tween:Play()
	end

	tool.Activated:Connect(onActivated)
	tool.Parent=getBp()
end)

cmd.add({"dex"},{"dex","Using this you can see the parts / guis / scripts etc with this. A really good and helpful script."},function()
	if IsOnMobile then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/dexmobile.lua"))()
	else
		loadstring(game:HttpGet("https://raw.githubusercontent.com/valkryant/sentynel/refs/heads/main/dex.lua"))()
	end
end)

cmd.add({"Decompiler"},{"Decompiler","Allows you to decompile LocalScript/ModuleScript's"},function()
	task.spawn(function()
		assert(getscriptbytecode, "Exploit not supported.")

		local API: string = "http://api.plusgiant5.com/"

		local last_call = 0
		local function call(konstantType: string, scriptPath: Script | ModuleScript | LocalScript): string
			local success: boolean, bytecode: string = pcall(getscriptbytecode, scriptPath)

			if (not success) then
				return -- Failed to get script bytecode, error:\n\n--[[\n{bytecode}\n--]]
			end

			local time_elapsed = os.clock() - last_call
			if time_elapsed <= .5 then
				task.wait(.5 - time_elapsed)
			end
			local httpResult = request({
				Url = API .. konstantType,
				Body = bytecode,
				Method = "POST",
				Headers = {
					["Content-Type"] = "text/plain"
				},
			})
			last_call = os.clock()

			if (httpResult.StatusCode ~= 200) then
				return -- Error occured while requesting the API, error:\n\n--[[\n{httpResult.Body}\n--]]
			else
				return httpResult.Body
			end
		end

		local function decompile(scriptPath: Script | ModuleScript | LocalScript): string
			return call("/konstant/decompile", scriptPath)
		end

		local function disassemble(scriptPath: Script | ModuleScript | LocalScript): string
			return call("/konstant/disassemble", scriptPath)
		end

		getgenv().decompile = decompile
		getgenv().disassemble = disassemble

		-- by lovrewe
	end)
end)

cmd.add({"getidfromusername","gidu"},{"getidfromusername (gidu)","Copy a user's UserId by Username"}, function(thingy)
	local s,idd=pcall(function()
		return SafeGetService("Players"):GetUserIdFromNameAsync(tostring(thingy))
	end)

	if not s then return warn("err: "..tostring(idd)) end

	if not setclipboard then return print("no setclipboard") end
	setclipboard(tostring(idd))

	DoNotif("Copied "..tostring(thingy).."'s UserId: "..tostring(idd))
end)

cmd.add({"getuserfromid","guid"},{"getuserfromid (guid)","Copy a user's Username by ID"}, function(thingy)
	local s,naem=pcall(function()
		return SafeGetService("Players"):GetNameFromUserIdAsync(thingy)
	end)

	if not s then return warn("err: "..tostring(naem)) end

	if not setclipboard then return print("no setclipboard") end
	setclipboard(tostring(naem))

	DoNotif("Copied "..tostring(naem).."'s Username with ID of "..tostring(thingy))
end)

cmd.add({"synapsedex","sdex"},{"synapsedex (sdex)","Loads SynapseX's dex explorer"},function()
	local rng=Random.new()

	local charset={}
	for i=48,57 do table.insert(charset,string.char(i)) end
	for i=65,90 do table.insert(charset,string.char(i)) end
	for i=97,122 do table.insert(charset,string.char(i)) end
	function RandomCharacters(length)
		if length>0 then
			return RandomCharacters(length-1)..charset[rng:NextInteger(1,#charset)]
		else
			return ""
		end
	end

	local Dex=game:GetObjects("rbxassetid://9553291002")[1]
	Dex.Name=RandomCharacters(rng:NextInteger(5,20))
	Dex.Parent=COREGUI

	function Load(Obj,Url)
		function GiveOwnGlobals(Func,Script)
			local Fenv={}
			local RealFenv={script=Script}
			local FenvMt={}
			FenvMt.__index=function(a,b)
				if RealFenv[b]==nil then
					return getfenv()[b]
				else
					return RealFenv[b]
				end
			end
			FenvMt.__newindex=function(a,b,c)
				if RealFenv[b]==nil then
					getfenv()[b]=c
				else
					RealFenv[b]=c
				end
			end
			setmetatable(Fenv,FenvMt)
			setfenv(Func,Fenv)
			return Func
		end

		function LoadScripts(Script)
			if Script.ClassName=="Script" or Script.ClassName=="LocalScript" then
				spawn(function()
					GiveOwnGlobals(loadstring(Script.Source,"="..Script:GetFullName()),Script)()
				end)
			end
			for i,v in pairs(Script:GetChildren()) do
				LoadScripts(v)
			end
		end

		LoadScripts(Obj)
	end

	Load(Dex)
end)

cmd.add({"gayrate"},{"gayrate <player>","Gay scale of a player"},function(...)
	Username=(...)
	target=getPlr(Username)
	local coolPercentage=math.random(1,100)
	rate=target.Name..' is '..coolPercentage..'% gay'
	lib.LocalPlayerChat(rate,'All')
end)

cmd.add({"coolrate"},{"coolrate <player>","Cool scale of a player"},function(...)
	Username=(...)
	target=getPlr(Username)
	local coolPercentage=math.random(1,100)
	rate=target.Name..' is '..coolPercentage..'% cool'
	lib.LocalPlayerChat(rate,'All')
end)

cmd.add({"unantikill"},{"unantikill","Makes exploiters to be able to kill you"},function()
	Player.Character.Humanoid:SetStateEnabled("Seated",true)
	Player.Character.Humanoid.Sit=false



	wait();

	DoNotif("Anti kill disabled")
end)

local AntiFling=false
cmd.add({"antifling"},{"antifling","makes it so you cant collide with others"},function()
	AntiFling=true

	function NoCollision(PLR)
		if AntiFling and PLR.Character then
			for _,x in pairs(PLR.Character:GetDescendants()) do
				if x:IsA("BasePart") and x.CanCollide then
					x.CanCollide=false
				end
			end
		end
	end
	for _,v in pairs(SafeGetService("Players"):GetPlayers()) do
		if v~=SafeGetService("Players") then
			local antifling=RunService.Stepped:connect(function()
				NoCollision(v)
			end)
		end
	end
	SafeGetService("Players").PlayerAdded:Connect(function()
		if v~=SafeGetService("Players").LocalPlayer and antifling then
			local antifling=RunService.Stepped:connect(function()
				NoCollision(v)
			end)
		end
	end)

	wait();
	DoNotif("Anti fling enabled")
end)

cmd.add({"unantifling"},{"unantifling","removes antifling"},function()
	AntiFling=true

	wait();
	DoNotif("Anti fling disabled")

	for _,v in pairs(SafeGetService("Players"):GetPlayers()) do
		if v~=SafeGetService("Players") then
			char=v.Character
			for _,x in pairs(char:GetDescendants()) do
				if x:IsA("BasePart") then
					x.CanCollide=true
				end
			end
		end
	end
end)

cmd.add({"gravitygun"},{"gravitygun","Probably the best gravity gun script thats fe"},function()
	wait();
	DoNotif("Wait a few seconds for it to load")
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/gravity%20gun"))()
end)

cmd.add({"flingnpcs"},{"flingnpcs","Flings NPCs"},function()
	local npcs={}

	function disappear(hum)
		if hum:IsA("Humanoid") and not SafeGetService("Players"):GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			hum.HipHeight=1024
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"voidnpcs"},{"voidnpcs","Voids NPCs"},function()

	local npcs={}

	function disappear(hum)
		if hum:IsA("Humanoid") and not SafeGetService("Players"):GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			hum.HipHeight=-1024
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"npcfollow"},{"npcfollow","Makes NPCS follow you"},function()
	local npcs={}

	function disappear(hum)
		if hum:IsA("Humanoid") and not SafeGetService("Players"):GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			local rootPart=hum.Parent:FindFirstChild("HumanoidRootPart")
			local targetPos=getChar():FindFirstChild("HumanoidRootPart").Position
			hum:MoveTo(targetPos)
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

local npcfollowloop=false
cmd.add({"loopnpcfollow"},{"loopnpcfollow","Makes NPCS follow you in a loop"},function()
	npcfollowloop=true

	repeat wait(0.1)
		local npcs={}

		function disappear(hum)
			if hum:IsA("Humanoid") and not SafeGetService("Players"):GetPlayerFromCharacter(hum.Parent) then
				table.insert(npcs,{hum,hum.HipHeight})
				local rootPart=hum.Parent:FindFirstChild("HumanoidRootPart")
				local targetPos=getChar():FindFirstChild("HumanoidRootPart").Position
				hum:MoveTo(targetPos)
			end
		end
		for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
			disappear(hum)
		end
	until npcfollowloop==false
end)

cmd.add({"unloopnpcfollow"},{"unloopnpcfollow","Makes NPCS not follow you in a loop"},function()
	npcfollowloop=false
end)

cmd.add({"lockws","lockworkspace"},{"lockws (lockworkspace)","Locks the whole workspace"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v.Locked==true or v.Locked==false then
			v.Locked=true
		end
	end
end)

cmd.add({"unlockws","unlockworkspace"},{"unlockws (unlockworkspace)","Unlocks the whole workspace"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v.Locked==true or v.Locked==false then
			v.Locked=false
		end
	end
end)

cmd.add({"sitnpcs"},{"sitnpcs","Makes NPCS sit"},function()
	local npcs={}

	function disappear(hum)
		if hum:IsA("Humanoid") and not SafeGetService("Players"):GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			local rootPart=hum.Parent:FindFirstChild("HumanoidRootPart")
			if rootPart then
				hum.Sit=true
			end      
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"unsitnpcs"},{"unsitnpcs","Makes NPCS unsit"},function()
	local npcs={}

	function disappear(hum)
		if hum:IsA("Humanoid") and not SafeGetService("Players"):GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			local rootPart=hum.Parent:FindFirstChild("HumanoidRootPart")
			if rootPart then
				hum.Sit=true
			end      
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"vehiclespeed","vspeed"},{"vehiclespeed <amount> (vspeed)","Change the vehicle speed"},function(...)
	if vehicleloopspeed then
		vehicleloopspeed:Disconnect()
	end
	local UserInputService=SafeGetService("UserInputService")
	local GuiService=SafeGetService("GuiService")
	local LocalPlayer=SafeGetService("Players").LocalPlayer

	local intens=(...)

	vehicleloopspeed=SafeGetService("RunService").Stepped:Connect(function()
		local Humanoid=SafeGetService("Workspace").CurrentCamera.CameraSubject;
		if Humanoid:IsA("Humanoid") then
			Humanoid.SeatPart:ApplyImpulse(Humanoid.SeatPart.CFrame.LookVector*Vector3.new(intens,intens,intens))
		elseif Humanoid:IsA("BasePart") then
			Humanoid:ApplyImpulse(Humanoid.CFrame.LookVector*Vector3.new(intens,intens,intens))
		end
	end)
end)

cmd.add({"unvehiclespeed","unvspeed"},{"unvehiclespeed (unvspeed)","Stops the vehiclespeed command"},function()
	vehicleloopspeed=vehicleloopspeed:Disconnect()
end)

cmd.add({"killnpcs"},{"killnpcs","Kills NPCs"},function()
	local npcs={}

	function disappear(hum)
		if hum:IsA("Humanoid") and not SafeGetService("Players"):GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			local rootPart=hum.Parent:FindFirstChild("HumanoidRootPart")
			if rootPart then
				hum.Health=0
			end      
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"bringnpcs"},{"bringnpcs","Brings NPCs"},function()
	local npcs={}

	function disappear(hum)
		if hum:IsA("Humanoid") and not SafeGetService("Players"):GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			local rootPart=hum.Parent:FindFirstChild("HumanoidRootPart")
			if rootPart then
				rootPart.CFrame=getRoot(getChar()).CFrame
			end      
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"controlnpcs","cnpcs"},{"controlnpcs (cnpcs)","Keybind: CTRL+LEFTCLICK"},function()



	wait();

	DoNotif("ControlNPCs executed,CTRL+Click on an NPC")
	---made by joshclark756#7155
	local mouse=SafeGetService("Players").LocalPlayer:GetMouse()
	local uis=SafeGetService("UserInputService")
	mouse.Button1Down:Connect(function()
		if mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
			local npc=mouse.target.Parent
			local npcRootPart=getRoot(npc)
			local PlayerCharacter=getChar()
			local PlayerRootPart=getRoot(character)
			local A0=Instance.new("Attachment")
			local AP=Instance.new("AlignPosition")
			local AO=Instance.new("AlignOrientation")
			local A1=Instance.new("Attachment")
			for _,v in pairs(npc:GetDescendants()) do
				if v:IsA("BasePart") then
					SafeGetService("RunService").Stepped:Connect(function()
						v.CanCollide=false
					end)
				end
			end
			PlayerRootPart:BreakJoints()
			for _,v in pairs(PlayerCharacter:GetDescendants()) do
				if v:IsA("BasePart") then
					if v.Name=="HumanoidRootPart" or v.Name=="UpperTorso" or v.Name=="Head" then
					else
						v:Destroy()
					end
				end
			end
			PlayerRootPart.Position=PlayerRootPart.Position+Vector3.new(5,0,0)
			PlayerCharacter.Head.Anchored=true
			PlayerCharacter.UpperTorso.Anchored=true
			A0.Parent=npcRootPart
			AP.Parent=npcRootPart
			AO.Parent=npcRootPart
			AP.Responsiveness=200
			AP.MaxForce=math.huge
			AO.MaxTorque=math.huge
			AO.Responsiveness=200
			AP.Attachment0=A0
			AP.Attachment1=A1
			AO.Attachment1=A1
			AO.Attachment0=A0
			A1.Parent=PlayerRootPart
		end
	end)
end)

cmd.add({"attachpart"},{"attachpart","Keybind: CTRL+LEFTCLICK"},function()

	wait();

	DoNotif("AttachPart executed,CTRL+Click on a part")
	--made by joshclark756#7155
	--Variables
	local mouse=SafeGetService("Players").LocalPlayer:GetMouse()
	local uis=SafeGetService("UserInputService")

	--Connect
	mouse.Button1Down:Connect(function()
		--Check for Target & Left Shift
		if mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
			local npc=mouse.target
			local npcparts=mouse.target.Parent
			local PlayerCharacter=getChar()
			local PlayerRootPart=getRoot(character)
			local A0=Instance.new("Attachment")
			local AP=Instance.new("AlignPosition")
			local AO=Instance.new("AlignOrientation")
			local A1=Instance.new("Attachment")
			for _,v in pairs(npcparts:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("Part") and v.Name~="HumanoidRootPart" then
					do
						v.CanCollide=false

					end
				end
			end
			--Variables
			local mouse=SafeGetService("Players").LocalPlayer:GetMouse()
			local uis=SafeGetService("UserInputService")

			--Connect
			mouse.Button1Down:Connect(function()
				if mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
					local npc=mouse.target
					local npcparts=mouse.target.Parent
					local PlayerCharacter=getChar()
					local PlayerRootPart=getRoot(character)
					local A0=Instance.new("Attachment")
					local AP=Instance.new("AlignPosition")
					local AO=Instance.new("AlignOrientation")
					local A1=Instance.new("Attachment")
					for _,v in pairs(npcparts:GetDescendants()) do
						if v:IsA("BasePart") or v:IsA("Part") and v.Name~="HumanoidRootPart" then
							do
								v.CanCollide=false

								wait(0)
								local player=SafeGetService("Players").LocalPlayer
								local mouse=player:GetMouse()
								bind="e"--has to be lowercase
								mouse.KeyDown:connect(function(key)
									if key==bind then do
											v.CanCollide=true
										end
									end
								end)
							end
						end
					end
					for _,v in pairs(PlayerCharacter:GetDescendants()) do
						if v:IsA("BasePart") then
							if v.Name=="HumanoidRootPart" or v.Name=="UpperTorso" or v.Name=="Head" then

							end
						end
					end
					PlayerRootPart.Position=PlayerRootPart.Position+Vector3.new(0,0,0)
					PlayerCharacter.Head.Anchored=false
					PlayerCharacter.Torso.Anchored=false
					A0.Parent=npc
					AP.Parent=npc
					AO.Parent=npc
					AP.Responsiveness=200
					AP.MaxForce=math.huge
					AO.MaxTorque=math.huge
					AO.Responsiveness=200
					AP.Attachment0=A0
					AP.Attachment1=A1
					AO.Attachment1=A1
					AO.Attachment0=A0
					A1.Parent=PlayerRootPart
				end
			end)
			for _,v in pairs(PlayerCharacter:GetDescendants()) do
				if v:IsA("BasePart") then
					if v.Name=="HumanoidRootPart" or v.Name=="UpperTorso" or v.Name=="Head" then

					end
				end
			end
			PlayerRootPart.Position=PlayerRootPart.Position+Vector3.new(0,0,0)
			PlayerCharacter.Head.Anchored=false
			PlayerCharacter.Torso.Anchored=false
			A0.Parent=npc
			AP.Parent=npc
			AO.Parent=npc
			AP.Responsiveness=200
			AP.MaxForce=math.huge
			AO.MaxTorque=math.huge
			AO.Responsiveness=200
			AP.Attachment0=A0
			AP.Attachment1=A1
			AO.Attachment1=A1
			AO.Attachment0=A0
			A1.Parent=PlayerRootPart
		end
	end)
end)

local active=false
local MobileCameraFramework={}
local players=SafeGetService("Players")
local runservice=SafeGetService("RunService")
local CAS=SafeGetService("ContextActionService")
local camera=SafeGetService("Workspace").CurrentCamera

local uis=SafeGetService("UserInputService")
local ismobile=uis.TouchEnabled

local MAX_LENGTH=900000
local active=false
local ENABLED_OFFSET=CFrame.new(1.7,0,0)
local DISABLED_OFFSET=CFrame.new(-1.7,0,0)
function UpdateAutoRotate(BOOL)
	humanoid.AutoRotate=BOOL
end
function GetUpdatedCameraCFrame(ROOT,CAMERA)
	return CFrame.new(root.Position,Vector3.new(CAMERA.CFrame.LookVector.X*MAX_LENGTH,root.Position.Y,CAMERA.CFrame.LookVector.Z*MAX_LENGTH))
end
function EnableShiftlock()
	local player=players.LocalPlayer
	local character=player.Character or player.CharacterAdded:Wait()
	local root=character:WaitForChild("HumanoidRootPart")
	local humanoid=character.Humanoid
	UpdateAutoRotate(false)
	root.CFrame=GetUpdatedCameraCFrame(root,camera)
	camera.CFrame=camera.CFrame*ENABLED_OFFSET
end
function DisableShiftlock()
	local player=players.LocalPlayer
	local character=player.Character or player.CharacterAdded:Wait()
	local root=character:WaitForChild("HumanoidRootPart")
	local humanoid=character.Humanoid
	UpdateAutoRotate(true)
	camera.CFrame=camera.CFrame*DISABLED_OFFSET
	pcall(function()
		active:Disconnect()
		active=nil
	end)
end
active=false
function ShiftLock()
	local player=players.LocalPlayer
	local character=player.Character or player.CharacterAdded:Wait()
	local root=character:WaitForChild("HumanoidRootPart")
	local humanoid=character.Humanoid
	if not active then
		active=runservice.RenderStepped:Connect(function()
			EnableShiftlock()
		end)
	else
		DisableShiftlock()
	end
end
cmd.add({"shiftlock","sl"},{"shiftlock (sl)","Enables shiftlock"},function()
	if IsOnMobile then
		gui.ShiftlockVis()
	else
		EnableShiftlock()
	end
end)

cmd.add({"unshiftlock","unsl"},{"unshiftlock (unsl)","Disables shiftlock"},function()
	if IsOnMobile then
		gui.ShiftlockInvis()
	else
		DisableShiftlock()
	end
end)

cmd.add({"ctrlshiftlock","ctrlsl"},{"ctrlshiftlock (ctrlsl)","Enables shift lock if you press Control"},function()
	SafeGetService("Players").LocalPlayer.PlayerScripts.PlayerModule.CameraModule.MouseLockController.BoundKeys.Value="LeftControl,RightControl"
end)

cmd.add({"esp"},{"esp","locate where the players are"},function()
	ESPenabled=true
	for _,v in pairs(Players:GetPlayers()) do
		if v.Name~=Players.LocalPlayer.Name then
			ESP(v)
		end
	end
end)

cmd.add({"locate"},{"locate <username>","locate where the players are"},function(...)
	Username=(...)
	local target=getPlr(Username)
	ESP(target)
end)

cmd.add({"unesp","unlocate"},{"unesp (unlocate)","Disables esp"},function()
	ESPenabled=false
	removeESP()
end)

cmd.add({"crash"},{"crash","crashes ur client lol"},function()
	while true do end
end)

cmd.add({"creep","ctp","scare"},{"ctp <player> (creep,scare)","Teleports from a player behind them and under the floor to the top"},function(...)
	Players=SafeGetService("Players")
	HRP=getRoot(getChar()).Anchored

	Username=(...)

	local target=getPlr(Username)

	getRoot(getChar()).CFrame=target.Character.Humanoid.RootPart.CFrame*CFrame.new(0,-10,4)
	wait()
	if connections["noclip"] then lib.disconnect("noclip") return end
	lib.connect("noclip",RunService.Stepped:Connect(function()
		if not character then return end
		for i,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide=false
			end
		end
	end))
	wait()
	getRoot(getChar()).Anchored=true
	wait()
	tweenService,tweenInfo=SafeGetService("TweenService"),TweenInfo.new(1000,Enum.EasingStyle.Linear)

	tween=tweenService:Create(getRoot(getChar()),tweenInfo,{CFrame=CFrame.new(0,10000,0)})
	tween:Play()
	wait(1.5)
	tween:Pause()
	getRoot(getChar()).Anchored=false
	wait()
	lib.disconnect("noclip")

end)

cmd.add({"netless","net"},{"netless (net)","Executes netless which makes scripts more stable"},function()
	for i,v in next,getChar():GetDescendants() do
		if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then 
			RunService.Heartbeat:connect(function()
				v.Velocity=Vector3.new(-30,0,0)
			end)
		end
	end

	wait();

	DoNotif("Netless has been activated,re-run this script if you die")
end)

cmd.add({"hatsleash","hl"},{"hatsleash","Makes you be able to carry your hats"},function()
	--[[ PROBABLY PATCHED ]]--
	for _,v in pairs(getChar():getChildren()) do
		if v.ClassName=="Accessory" then
			for i,k in pairs(v:GetDescendants()) do
				if k.ClassName=="Attachment" then
					s=Instance.new("RopeConstraint")
					k.Parent.CanCollide=true
					s.Parent=getRoot(getChar())
					s.Attachment1=k
					s.Attachment0=getChar().Head.FaceCenterAttachment
					s.Visible=true
					s.Length=10
					v.Handle.AccessoryWeld:Destroy()
				end
			end
		end
	end
end)

cmd.add({"toolleash","tl"},{"toolleash","Makes you be able to carry your tools"},function()
	--[[ PROBABLY PATCHED ]]--
	for _,v in pairs(SafeGetService("Players").LocalPlayer.Backpack:GetChildren()) do
		v.Parent=getChar()
	end

	for _,v in pairs(getChar():GetChildren()) do
		if v.ClassName=="Tool" then
			x=Instance.new("Attachment")
			s=Instance.new("RopeConstraint")
			v.Handle.CanCollide=true
			x.Parent=v.Handle
			s.Parent=getRoot(getChar())
			s.Attachment1=getChar()["Right Arm"].RightGripAttachment
			s.Attachment0=v.Handle.Attachment
			s.Length=100
			s.Visible=true
			wait()
		end
	end
	for _,v in pairs(getChar():GetDescendants()) do
		if v.Name=="RightGrip" then
			v:Destroy()
		end
	end

	while wait() do
		for _,v in pairs(getChar():GetChildren()) do
			if v.ClassName=="Tool" then
				v.Handle.Velocity=Vector3.new(math.random(-100,100),5,math.random(-100,100))
			end
		end
	end
end)

cmd.add({"reset","die"},{"reset (die)","Makes your health be 0"},function()
	Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
	Player.Character:FindFirstChildOfClass("Humanoid").Health=0
end)

local hastheyfixedit=nil

cmd.add({"saveinstance","savegame"},{"saveinstance (savegame)","if it bugs out try removing stuff from your AutoExec folder"},function()
	--saveinstance({})
	hastheyfixedit=loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Fluxus/SaveInstanceFix.lua?raw=thiswillreturnfalseuntilltheyfixit"))();

	local Params={
		RepoURL="https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
		SSI="saveinstance",
	}
	local synsaveinstance=loadstring(game:HttpGet(Params.RepoURL..Params.SSI..".luau",true),Params.SSI)()
	local Options={}	
	if identifyexecutor()=="Fluxus" and not hastheyfixedit then
		Options={ IgnoreSpecialProperties=true }
	end
	synsaveinstance(Options)
end)

cmd.add({"admin"},{"admin","whitelist someone to allow them to use commands"},function(...)
	function ChatMessage(Message,Whisper)	lib.LocalPlayerChat(Message,Whisper or "All")
	end
	local Player=getPlr(...)
	if Player~=nil and not Admin[Player.UserId] then
		Admin[Player.UserId]={Player=Player}
		ChatMessage("[0x4] You've got admin. Prefix: ';'",Player.Name)
		wait(0.2)
		ChatMessage("[0x4 Commands] glue,unglue,fling,fling2,spinfling,unspinfling,fcd,fti,fpp,fireremotes,holdhat",Player.Name)
		ChatMessage("reset,commitoof,seizure,unseizure,toolorbit,lay,fall,toolspin,hatspin,sit,joke,kanye",Player.Name)
		DoNotif(Player.Name.." has now been whitelisted to use commands",15)
	else
		DoNotif("No player found",15)
	end
end)

cmd.add({"unadmin"},{"unadmin <player>","removes someone from being admin"},function(...)
	function ChatMessage(Message,Whisper)	SafeGetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Message,Whisper or "All")
	end
	local Player=getPlr(...)
	if Player~=nil and Admin[Player.UserId] then
		Admin[Player.UserId]=nil
		ChatMessage("/w "..Player.Name.." You can no longer use commands")
		DoNotif(Player.Name.." is no longer an admin",15)
	else
		DoNotif("Player not found",15)
	end
end)

cmd.add({"2016"},{"2016","2016 CORE GUI"},function()
	--[[ PLAYERBOARD IS BUGGED BUT WILL TRY TO FIX. ]]--
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/2016%20mode"))()
end)

cmd.add({"removedn","nodn","nodpn"},{"removedn (nodn,nodpn)","Removes all display names"},function()

	--[[ IM NOT SURE WHO MADE THIS ]]--

	wait();
	DoNotif("Display names successfully removed")

	local Players=SafeGetService("Players")
	require(SafeGetService("Chat"):WaitForChild("ClientChatModules").ChatSettings).PlayerDisplayNamesEnabled=false
	function rename(character,name)
		repeat task.wait() until character:FindFirstChildWhichIsA("Humanoid")
		character:FindFirstChildWhichIsA("Humanoid").DisplayName=name
	end
	for i,v in next,Players:GetPlayers() do
		if v.Character then
			v.DisplayName=v.Name
			rename(v.Character,v.Name)
		end
		v.CharacterAdded:Connect(function(char)
			rename(char,v.Name)
		end)
	end
	Players.PlayerAdded:Connect(function(plr)
		plr.DisplayName=plr.Name
		plr.CharacterAdded:Connect(function(char)
			rename(char,plr.Name)
		end)
	end)
end)

cmd.add({"partname","partpath","partgrabber"},{"partname (partpath,partgrabber)","gives a ui and allows you click on a part to grab it's path"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/PartGrabber.lua"))()
end)

-- patched (womp)
--[[cmd.add({"backdoor","backdoorscan"},{"backdoor (backdoorscan)","Scans for any backdoors using FraktureSS"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/Frakture"))()
end)]]

cmd.add({"jobid"},{"jobid","Copies your job id"},function()
	local jobId='Roblox.GameLauncher.joinGameInstance('..PlaceId..',"'..JobId..'")'
	if setclipboard then
		setclipboard(tostring(jobId))
		wait();

		DoNotif("Copied your jobid ("..jobId..")")
	else
		DoNotif("Your executor does not support setclipboard")
	end
end)

cmd.add({"joinjobid","joinjid","jjobid","jjid"},{"joinjobid <jobid> (joinjid,jjobid,jjid)","Joins the job id you put in"},function(...)
	zeId={...}
	id=zeId[1]
	TeleportService:TeleportToPlaceInstance(PlaceId,id)
end)

cmd.add({"serverhop","shop"},{"serverhop (shop)","serverhop"},function()
	wait();

	DoNotif("Searching")
	local Number=0
	local SomeSRVS={}
	local found=0
	for _,v in ipairs(SafeGetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v)=="table" and v.maxPlayers>v.playing and v.id~=JobId then
			if v.playing>Number then
				Number=v.playing
				SomeSRVS[1]=v.id
				found=v.playing
			end
		end
	end
	if #SomeSRVS>0 then
		DoNotif("serverhopping | Player Count: "..found)
		SafeGetService("TeleportService"):TeleportToPlaceInstance(PlaceId,SomeSRVS[1])
	end
end)

cmd.add({"smallserverhop","sshop"},{"smallserverhop (sshop)","serverhop to a small server"},function()
	wait();

	DoNotif("Searching")

	local Number=math.huge
	local SomeSRVS={}
	local found=0

	for _,v in ipairs(SafeGetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v)=="table" and v.maxPlayers>v.playing and v.id~=JobId then
			if v.playing<Number then
				Number=v.playing
				SomeSRVS[1]=v.id
				found=v.playing
			end
		end
	end

	if #SomeSRVS>0 then
		DoNotif("serverhopping | Player Count: "..found)
		SafeGetService("TeleportService"):TeleportToPlaceInstance(PlaceId,SomeSRVS[1])
	end
end)

cmd.add({"pingserverhop","pshop"},{"pingserverhop (pshop)","serverhop to a server with the best ping"},function()
	wait();

	DoNotif("Searching")

	local Servers=JSONDecode(HttpService,game:HttpGetAsync("https://games.roblox.com/v1/games/".. PlaceId .."/servers/Public?sortOrder=Asc&limit=100")).data
	local Ping=math.huge
	local Jobid=nil

	if Servers and #Servers>1 then
		for Index,Server in next,Servers do
			local ping=Server.ping
			if (ping<Ping) then
				Ping=ping
				Jobid=Server.id
			end
		end
	end

	if Jobid then
		DoNotif(string.format("Serverhopping,ping: %s",tostring(Ping)))
		TeleportService:TeleportToPlaceInstance(PlaceId,Jobid)
	end
end)

local autorjthingy=nil

cmd.add({"autorejoin","autorj"},{"autorejoin","Rejoins the server if you get kicked / disconnected"},function()

	if autorjthingy then autorjthingy:Disconnect() autorjthingy=nil end

	autorjthingy=game.CoreGui:FindFirstChild("RobloxPromptGui"):FindFirstChild("promptOverlay").DescendantAdded:Connect(function(Err)
		if Err.Name=="ErrorTitle" then
			if Err.Text:sub(0,12)=="Disconnected" then
				if #Players:GetPlayers() <=1 then
					SafeGetService("Players").LocalPlayer:Kick("Rejoining...")
					wait()
					SafeGetService("TeleportService"):Teleport(PlaceId,SafeGetService("Players").LocalPlayer)
				else
					SafeGetService("TeleportService"):TeleportToPlaceInstance(PlaceId,JobId,SafeGetService("Players").LocalPlayer)
				end
			end
			Err:GetPropertyChangedSignal("Text"):Connect(function()
				if Err.Text:sub(0,12)=="Disconnected" then
					if #Players:GetPlayers() <=1 then
						SafeGetService("Players").LocalPlayer:Kick("Rejoining...")
						wait()
						SafeGetService("TeleportService"):Teleport(PlaceId,SafeGetService("Players").LocalPlayer)
					else
						SafeGetService("TeleportService"):TeleportToPlaceInstance(PlaceId,JobId,SafeGetService("Players").LocalPlayer)
					end
				end
			end)
		end
	end)

	DoNotif("Auto Rejoin is now on!")
end)

cmd.add({"unautorejoin","unautorj"},{"unautorejoin (unautorj)","disables auto rejoin command"},function()

	if autorjthingy then
		autorjthingy:Disconnect()
		autorjthingy=nil 

		DoNotif("Auto Rejoin is now disabled!")
	else
		DoNotif("Auto Rejoin is already disabled")
	end
end)

cmd.add({"functionspy"},{"functionspy","Check console"},function()
	local toLog={
		debug.getconstants;
		getconstants;
		debug.getconstant;
		getconstant;
		debug.setconstant;
		setconstant;
		debug.getupvalues;
		debug.getupvalue;
		getupvalues;
		getupvalue;
		debug.setupvalue;
		setupvalue;
		getsenv;
		getreg;
		getgc;
		getconnections;
		firesignal;
		fireclickdetector;
		fireproximityprompt;
		firetouchinterest;
		gethiddenproperty;
		sethiddenproperty;
		hookmetamethod;
		setnamecallmethod;
		getrawmetatable;
		setrawmetatable;
		setreadonly;
		isreadonly;
		debug.setmetatable;
	}

	functionSpy=Instance.new("ScreenGui")
	local Main=Instance.new("Frame")
	local LeftPanel=Instance.new("ScrollingFrame")
	local UIListLayout=Instance.new("UIListLayout")
	local example=Instance.new("TextButton")
	local name=Instance.new("TextLabel")
	local UIPadding=Instance.new("UIPadding")
	local FakeTitle=Instance.new("TextButton")
	local Title=Instance.new("TextLabel")
	local clear=Instance.new("ImageButton")
	local RightPanel=Instance.new("ScrollingFrame")
	local output=Instance.new("TextLabel")
	local clear_2=Instance.new("TextButton")
	local copy=Instance.new("TextButton")

	FunctionSpy.Name="FunctionSpy"
	FunctionSpy.Parent=COREGUI
	FunctionSpy.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

	Main.Name="Main"
	Main.Parent=FunctionSpy
	Main.BackgroundColor3=Color3.fromRGB(33,33,33)
	Main.BorderSizePixel=0
	Main.Position=UDim2.new(0,10,0,36)
	Main.Size=UDim2.new(0,536,0,328)

	LeftPanel.Name="LeftPanel"
	LeftPanel.Parent=Main
	LeftPanel.Active=true
	LeftPanel.BackgroundColor3=Color3.fromRGB(45,45,45)
	LeftPanel.BorderSizePixel=0
	LeftPanel.Size=UDim2.new(0.349999994,0,1,0)
	LeftPanel.CanvasSize=UDim2.new(0,0,0,0)
	LeftPanel.HorizontalScrollBarInset=Enum.ScrollBarInset.ScrollBar
	LeftPanel.ScrollBarThickness=3

	UIListLayout.Parent=LeftPanel
	UIListLayout.SortOrder=Enum.SortOrder.LayoutOrder
	UIListLayout.Padding=UDim.new(0,7)

	example.Name="example"
	example.Parent=LeftPanel
	example.BackgroundColor3=Color3.fromRGB(31,31,31)
	example.BorderSizePixel=0
	example.Position=UDim2.new(4.39481269e-08,0,0,0)
	example.Size=UDim2.new(0,163,0,19)
	example.Visible=false
	example.Font=Enum.Font.SourceSans
	example.Text=""
	example.TextColor3=Color3.fromRGB(0,0,0)
	example.TextSize=14.000
	example.TextXAlignment=Enum.TextXAlignment.Left

	name.Name="name"
	name.Parent=example
	name.BackgroundColor3=Color3.fromRGB(255,255,255)
	name.BackgroundTransparency=1.000
	name.BorderSizePixel=0
	name.Position=UDim2.new(0,10,0,0)
	name.Size=UDim2.new(1,-10,1,0)
	name.Font=Enum.Font.SourceSans
	name.TextColor3=Color3.fromRGB(255,255,255)
	name.TextSize=14.000
	name.TextXAlignment=Enum.TextXAlignment.Left

	UIPadding.Parent=LeftPanel
	UIPadding.PaddingBottom=UDim.new(0,7)
	UIPadding.PaddingLeft=UDim.new(0,7)
	UIPadding.PaddingRight=UDim.new(0,7)
	UIPadding.PaddingTop=UDim.new(0,7)

	FakeTitle.Name="FakeTitle"
	FakeTitle.Parent=Main
	FakeTitle.BackgroundColor3=Color3.fromRGB(40,40,40)
	FakeTitle.BorderSizePixel=0
	FakeTitle.Position=UDim2.new(0,225,0,-26)
	FakeTitle.Size=UDim2.new(0.166044772,0,0,26)
	FakeTitle.Font=Enum.Font.GothamMedium
	FakeTitle.Text="FunctionSpy"
	FakeTitle.TextColor3=Color3.fromRGB(255,255,255)
	FakeTitle.TextSize=14.000

	Title.Name="Title"
	Title.Parent=Main
	Title.BackgroundColor3=Color3.fromRGB(40,40,40)
	Title.BorderSizePixel=0
	Title.Position=UDim2.new(0,0,0,-26)
	Title.Size=UDim2.new(1,0,0,26)
	Title.Font=Enum.Font.GothamMedium
	Title.Text="FunctionSpy"
	Title.TextColor3=Color3.fromRGB(255,255,255)
	Title.TextSize=14.000
	Title.TextWrapped=true

	clear.Name="clear"
	clear.Parent=Title
	clear.BackgroundTransparency=1.000
	clear.Position=UDim2.new(1,-28,0,2)
	clear.Size=UDim2.new(0,24,0,24)
	clear.ZIndex=2
	clear.Image="rbxassetid://3926305904"
	clear.ImageRectOffset=Vector2.new(924,724)
	clear.ImageRectSize=Vector2.new(36,36)

	RightPanel.Name="RightPanel"
	RightPanel.Parent=Main
	RightPanel.Active=true
	RightPanel.BackgroundColor3=Color3.fromRGB(35,35,35)
	RightPanel.BorderSizePixel=0
	RightPanel.Position=UDim2.new(0.349999994,0,0,0)
	RightPanel.Size=UDim2.new(0.649999976,0,1,0)
	RightPanel.CanvasSize=UDim2.new(0,0,0,0)
	RightPanel.HorizontalScrollBarInset=Enum.ScrollBarInset.ScrollBar
	RightPanel.ScrollBarThickness=3

	output.Name="output"
	output.Parent=RightPanel
	output.BackgroundColor3=Color3.fromRGB(255,255,255)
	output.BackgroundTransparency=1.000
	output.BorderColor3=Color3.fromRGB(27,42,53)
	output.BorderSizePixel=0
	output.Position=UDim2.new(0,10,0,10)
	output.Size=UDim2.new(1,-10,0.75,-10)
	output.Font=Enum.Font.GothamMedium
	output.Text=""
	output.TextColor3=Color3.fromRGB(255,255,255)
	output.TextSize=14.000
	output.TextXAlignment=Enum.TextXAlignment.Left
	output.TextYAlignment=Enum.TextYAlignment.Top

	clear_2.Name="clear"
	clear_2.Parent=RightPanel
	clear_2.BackgroundColor3=Color3.fromRGB(30,30,30)
	clear_2.BorderSizePixel=0
	clear_2.Position=UDim2.new(0.0631457642,0,0.826219559,0)
	clear_2.Size=UDim2.new(0,140,0,33)
	clear_2.Font=Enum.Font.SourceSans
	clear_2.Text="Clear logs"
	clear_2.TextColor3=Color3.fromRGB(255,255,255)
	clear_2.TextSize=14.000

	copy.Name="copy"
	copy.Parent=RightPanel
	copy.BackgroundColor3=Color3.fromRGB(30,30,30)
	copy.BorderSizePixel=0
	copy.Position=UDim2.new(0.545350134,0,0.826219559,0)
	copy.Size=UDim2.new(0,140,0,33)
	copy.Font=Enum.Font.SourceSans
	copy.Text="Copy info"
	copy.TextColor3=Color3.fromRGB(255,255,255)
	copy.TextSize=14.000

	--Scripts:

	function AKIHDI_fake_script()
		_G.functionspy={
			instance=Main.Parent;
			logging=true;
			connections={};
		}

		_G.functionspy.shutdown=function()
			for i,v in pairs(_G.functionspy.connections) do
				v:Disconnect()
			end
			_G.functionspy.connections={}
			_G.functionspy=nil
			Main.Parent:Destroy()
		end

		local connections={}

		local currentInfo=nil

		function log(name,text)
			local btn=Main.LeftPanel.example:Clone()
			btn.Parent=Main.LeftPanel
			btn.Name=name
			btn.name.Text=name
			btn.Visible=true
			table.insert(connections,btn.MouseButton1Click:Connect(function()
				Main.RightPanel.output.Text=text
				currentInfo=text
			end))
		end

		Main.RightPanel.copy.MouseButton1Click:Connect(function()
			if currentInfo~=nil then
				setclipboard(tostring(currentInfo))
			end
		end)

		Main.RightPanel.clear.MouseButton1Click:Connect(function()
			for i,v in pairs(connections) do
				v:Disconnect()
			end
			for i,v in pairs(Main.LeftPanel:GetDescendants()) do
				if v:IsA("TextButton") and v.Visible==true then
					v:Destroy()
				end
			end
			Main.RightPanel.output.Text=""
			currentInfo=nil
		end)

		local hooked={}
		local Seralize=loadstring(game:HttpGet('https://api.irisapp.ca/Scripts/SeralizeTable.lua',true))()
		for i,v in next,toLog do
			if type(v)=="string" then
				local suc,err=pcall(function()
					local func=loadstring("return "..v)()
					hooked[i]=hookfunction(func,function(...)
						local args={...}
						if _G.functionspy then
							pcall(function() 
								out=""
								out=out..(v..",Args-> {")..("\n"):format()
								for l,k in pairs(args) do
									if type(k)=="function" then
										out=out..("    ["..tostring(l).."] "..tostring(k)..",Type-> "..type(k)..",Name-> "..getinfo(k).name)..("\n"):format()
									elseif type(k)=="table" then
										out=out..("    ["..tostring(l).."] "..tostring(k)..",Type-> "..type(k)..",Data-> "..Seralize(k))..("\n"):format()
									elseif type(k)=="boolean" then
										out=out..("    ["..tostring(l).."] Value-> "..tostring(k).."-> "..type(k))..("\n"):format()
									elseif type(k)=="nil" then
										out=out..("    ["..tostring(l).."] null")..("\n"):format()
									elseif type(k)=="number" then
										out=out..("    ["..tostring(l).."] Value-> "..tostring(k)..",Type-> "..type(k))..("\n"):format()
									else
										out=out..("    ["..tostring(l).."] Value-> "..tostring(k)..",Type-> "..type(k))..("\n"):format()
									end
								end
								out=out..("},Result-> "..tostring(nil))..("\n"):format()
								if _G.functionspy.logging==true then
									log(v,out)
								end
							end)
						end
						return hooked[i](...)
					end)
				end)
				if not suc then
					warn("Something went wrong while hooking "..v..". Error: "..err)
				end
			elseif type(v)=="function" then
				local suc,err=pcall(function()
					hooked[i]=hookfunction(v,function(...)
						local args={...}
						if _G.functionspy then
							pcall(function() 
								out=""
								out=out..(getinfo(v).name..",Args-> {")..("\n"):format()
								for l,k in pairs(args) do
									if type(k)=="function" then
										out=out..("    ["..tostring(l).."] "..tostring(k)..",Type-> "..type(k)..",Name-> "..getinfo(k).name)..("\n"):format()
									elseif type(k)=="table" then
										out=out..("    ["..tostring(l).."] "..tostring(k)..",Type-> "..type(k)..",Data-> "..Seralize(k))..("\n"):format()
									elseif type(k)=="boolean" then
										out=out..("    ["..tostring(l).."] Value-> "..tostring(k).."-> "..type(k))..("\n"):format()
									elseif type(k)=="nil" then
										out=out..("    ["..tostring(l).."] null")..("\n"):format()
									elseif type(k)=="number" then
										out=out..("    ["..tostring(l).."] Value-> "..tostring(k)..",Type-> "..type(k))..("\n"):format()
									else
										out=out..("    ["..tostring(l).."] Value-> "..tostring(k)..",Type-> "..type(k))..("\n"):format()
									end
								end
								out=out..("},Result-> "..tostring(nil))..("\n"):format()
								if _G.functionspy.logging==true then
									log(getinfo(v).name,out)
								end
							end)
						end
						return hooked[i](...)
					end)
				end)
				if not suc then
					warn("Something went wrong while hooking "..getinfo(v).name..". Error: "..err)
				end
			end
		end

	end
	coroutine.wrap(AKIHDI_fake_script)()
	function KVVJTK_fake_script()
		local UIS=SafeGetService('UserInputService')
		local frame=FakeTitle.Parent
		local dragToggle=nil
		local dragSpeed=0.25
		local dragStart=nil
		local startPos=nil

		function updateInput(input)
			local delta=input.Position-dragStart
			local position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,
				startPos.Y.Scale,startPos.Y.Offset+delta.Y)
			SafeGetService('TweenService'):Create(frame,TweenInfo.new(dragSpeed),{Position=position}):Play()
		end

		table.insert(_G.functionspy.connections,frame.Title.InputBegan:Connect(function(input)
			if (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch) then 
				dragToggle=true
				dragStart=input.Position
				startPos=frame.Position
				input.Changed:Connect(function()
					if input.UserInputState==Enum.UserInputState.End then
						dragToggle=false
					end
				end)
			end
		end))

		table.insert(_G.functionspy.connections,UIS.InputChanged:Connect(function(input)
			if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
				if dragToggle then
					updateInput(input)
				end
			end
		end))

	end
	coroutine.wrap(KVVJTK_fake_script)()
	function BIPVKVC_fake_script()
		local script=Instance.new('LocalScript',FakeTitle)

		table.insert(_G.functionspy.connections,FakeTitle.MouseEnter:Connect(function()
			if _G.functionspy.logging==true then
				SafeGetService("TweenService"):Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(0,1,0)}):Play()
			elseif _G.functionspy.logging==false then
				SafeGetService("TweenService"):Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,0,0)}):Play()
			end
		end))

		table.insert(_G.functionspy.connections,FakeTitle.MouseMoved:Connect(function()
			if _G.functionspy.logging==true then
				SafeGetService("TweenService"):Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(0,1,0)}):Play()
			elseif _G.functionspy.logging==false then
				SafeGetService("TweenService"):Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,0,0)}):Play()
			end
		end))

		table.insert(_G.functionspy.connections,FakeTitle.MouseButton1Click:Connect(function()
			_G.functionspy.logging=not _G.functionspy.logging
			if _G.functionspy.logging==true then
				SafeGetService("TweenService"):Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(0,1,0)}):Play()
			elseif _G.functionspy.logging==false then
				SafeGetService("TweenService"):Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,0,0)}):Play()
			end
		end))

		table.insert(_G.functionspy.connections,FakeTitle.MouseLeave:Connect(function()
			SafeGetService("TweenService"):Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,1,1)}):Play()
		end))
	end
	coroutine.wrap(BIPVKVC_fake_script)()
	function PRML_fake_script()
		clear.MouseButton1Click:Connect(function()
			_G.functionspy.shutdown()
		end)
	end
	coroutine.wrap(PRML_fake_script)()
end)

local on=false
local rahh=nil

cmd.add({"fly"},{"fly [speed]","Enable flight"},function(...)
	speed=(...)

	if speed==nil then
		speed=50
	else
	end
	if IsOnMobile then 
		wait();
		DoNotif(adminName.." has detected you using mobile you now have a mfly button click it to enable / disable mobile flying (For easier use)")

		if rahh then rahh:Destroy() rahh=nil end

		rahh=Instance.new("ScreenGui")
		local TextButton=Instance.new("TextButton")
		local UICorner=Instance.new("UICorner")
		local UIAspectRatioConstraint=Instance.new("UIAspectRatioConstraint")

		rahh.Parent=COREGUI
		rahh.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
		rahh.ResetOnSpawn=false

		TextButton.Parent=rahh
		TextButton.BackgroundColor3=Color3.fromRGB(12,4,20)
		TextButton.BackgroundTransparency=0.140
		TextButton.Position=UDim2.new(0.933,0,0.621,0)
		TextButton.Size=UDim2.new(0.043,0,0.083,0)
		TextButton.Font=Enum.Font.SourceSansBold
		TextButton.Text="Fly"
		TextButton.TextColor3=Color3.fromRGB(255,255,255)
		TextButton.TextSize=15.000
		TextButton.TextWrapped=true
		TextButton.Active=true
		TextButton.Draggable=true
		TextButton.TextScaled=true

		UICorner.Parent=TextButton

		UIAspectRatioConstraint.Parent=TextButton
		UIAspectRatioConstraint.AspectRatio=1.060

		function FEPVI_fake_script()
			TextButton.MouseButton1Click:Connect(function()
				if on==false then
					on=true
					TextButton.Text="Unfly"
					mobilefly(speed)
				elseif on==true then
					on=false
					TextButton.Text="Fly"
					unmobilefly()
				end
			end)
		end
		coroutine.wrap(FEPVI_fake_script)()
		gui.draggable(TextButton)
	else
		FLYING=false
		cmdlp.Character.Humanoid.PlatformStand=false
		wait();

		DoNotif("Fly enabled")
		sFLY(true)
		speedofthevfly=(...)
		if (...)==nil then
			speedofthevfly=2
		end
	end
end)

TFlyEnabled = false
tflyCORE = nil

cmd.add({"tfly", "tweenfly"},{"tfly [speed] (tweenfly)","Basically smooth flying"},function(...)
	TFlyEnabled = true
	local speed=(...)
	if speed==nil then
		speed=2
	end
	local e1, e2
	local Hum, mouse = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"), LocalPlayer:GetMouse()
	tflyCORE = Instance.new("Part", workspace)
	tflyCORE:SetAttribute("tflyPart",true)
	tflyCORE.Size, tflyCORE.CanCollide = Vector3.new(0.05, 0.05, 0.05), false
	local Trs = tflyCORE

	local keys = { a = false, d = false, w = false, s = false }
	if IsOnPC then
		e1 = mouse.KeyDown:Connect(function(key)
			if not Trs or not Trs.Parent then
				e1:Disconnect()
				e2:Disconnect()
				return
			end
			if key == "w" then
				keys.w = true
			elseif key == "s" then
				keys.s = true
			elseif key == "a" then
				keys.a = true
			elseif key == "d" then
				keys.d = true
			end
		end)
		e2 = mouse.KeyUp:Connect(function(key)
			if key == "w" then
				keys.w = false
			elseif key == "s" then
				keys.s = false
			elseif key == "a" then
				keys.a = false
			elseif key == "d" then
				keys.d = false
			end
		end)
	end

	local Weld = Instance.new("Weld", tflyCORE)
	Weld.Part0, Weld.Part1, Weld.C0 = tflyCORE, Hum.RootPart, CFrame.new(0, 0, 0)

	local pos, gyro = Instance.new("BodyPosition", Trs), Instance.new("BodyGyro", Trs)
	pos.maxForce, pos.position = Vector3.new(math.huge, math.huge, math.huge), Trs.Position
	gyro.maxTorque, gyro.cframe = Vector3.new(9e9, 9e9, 9e9), Trs.CFrame

	repeat
		wait()
		Hum.PlatformStand = true
		local new = gyro.cframe - gyro.cframe.p + pos.position

		if IsOnPC then
			if keys.w then
				new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
			end
			if keys.s then
				new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
			end
			if keys.d then
				new = new * CFrame.new(speed, 0, 0)
			end
			if keys.a then
				new = new * CFrame.new(-speed, 0, 0)
			end
		elseif IsOnMobile then
			local ControlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
			local direction = ControlModule:GetMoveVector()
			if direction.Magnitude > 0 then
				new = new + (direction.X * workspace.CurrentCamera.CFrame.RightVector * speed)
				new = new - (direction.Z * workspace.CurrentCamera.CFrame.LookVector * speed)
			end
		end

		pos.position = new.p
		if keys.w then
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame
		elseif keys.s then
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame
		else
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame
		end
	until TFlyEnabled == false
	if gyro then
		gyro:Destroy()
	end
	if pos then
		pos:Destroy()
	end
	Hum.PlatformStand = false
	speed = 10
end)

cmd.add({"untfly","untweenfly"},{"untfly (untweenfly)","Disables tween fly"},function()
	TFlyEnabled = false
	for i, v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:GetAttribute("tflyPart") then
			v:Destroy()
		end
	end
	--if tflyCORE then tflyCORE:Destroy() end
end)

cmd.add({"unfly"},{"unfly","Disable flight"},function()

	wait();
	if IsOnMobile then
		DoNotif("Mobile Fly Disabled")
	else
		DoNotif("Not flying anymore")
		FLYING=false
		cmdlp.Character.Humanoid.PlatformStand=false
		if goofyFLY then goofyFLY:Destroy() end
	end
	unmobilefly()
	on=false
	if rahh then rahh:Destroy() rahh=nil end
end)

cmd.add({"mobilefly","mfly"},{"mobilefly [speed] (mfly)","nil"},function()
	DoNotif("moved into the (fly) command")
end)

cmd.add({"unmobilefly","unmfly"},{"unmobilefly (unmfly)","nil"},function()
	DoNotif("moved into the (unfly) command")
end)

cmd.add({"noclip","nclip","nc"},{"noclip","Disable your player's collision"},function()
	if connections["noclip"] then lib.disconnect("noclip") return end
	lib.connect("noclip",RunService.Stepped:Connect(function()
		if not character then return end
		for i,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide=false
			end
		end
	end))
end)

cmd.add({"clip","c"},{"clip","Enable your player's collision"},function()
	lib.disconnect("noclip")
end)

cmd.add({"freezewalk"},{"freezewalk","Freezes your character on the server but lets you walk on the client"},function()
	local Character=getChar()
	local Root=getRoot(Character)

	if r6(plr) then
		local Clone=Root:Clone()
		Root:Destroy()
		Clone.Parent=Character
	else
		Character.LowerTorso.Anchored=true
		Character.LowerTorso.Root:Destroy()
	end
	DoNotif("freezewalk is activated,reset to stop it")
end)

cmd.add({"r15"},{"r15","Prompts a message asking to make you R15"},function()
	local avs=SafeGetService("AvatarEditorService")
	avs:PromptSaveAvatar(getChar().Humanoid.HumanoidDescription,Enum.HumanoidRigType.R15)
	DoNotif("Press allow",3)
	local result=avs.PromptSaveAvatarCompleted:Wait()
	if result==Enum.AvatarPromptResult.Success
	then
		DoNotif("You are now R15",3)
		respawn()
	else
		DoNotif("An error has occured",3)
	end
end)

cmd.add({"r6"},{"r6","Prompts a message asking to make you R6"},function()
	local avs=SafeGetService("AvatarEditorService")
	avs:PromptSaveAvatar(getChar().Humanoid.HumanoidDescription,Enum.HumanoidRigType.R6)
	DoNotif("Press allow",3)
	local result=avs.PromptSaveAvatarCompleted:Wait()
	if result==Enum.AvatarPromptResult.Success
	then
		DoNotif("You are now R6",3)
		respawn()
	else
		DoNotif("An error has occured",3)
	end
end)

local fcpro=nil

cmd.add({"freecam","fc","fcam"},{"freecam [speed] (fc,fcam)","Enable free camera"},function(speed)
	if not speed then speed=5 end
	if connections["freecam"] then lib.disconnect("freecam") camera.CameraSubject=character 	wrap(function() character.PrimaryPart.Anchored=false end) end
	local dir={w=false,a=false,s=false,d=false}
	local cf=Instance.new("CFrameValue")
	local camPart=Instance.new("Part")
	camPart.Transparency=1
	camPart.Anchored=true
	camPart.CFrame=camera.CFrame
	wrap(function()
		character.PrimaryPart.Anchored=true
	end)

	lib.connect("freecam",RunService.RenderStepped:Connect(function()
		local primaryPart=camPart
		camera.CameraSubject=primaryPart

		local x,y,z=0,0,0
		if dir.w then z=-1*speed end
		if dir.a then x=-1*speed end
		if dir.s then z=1*speed end
		if dir.d then x=1*speed end
		if dir.q then y=1*speed end
		if dir.e then y=-1*speed end

		primaryPart.CFrame=CFrame.new(
			primaryPart.CFrame.p,
			(camera.CFrame*CFrame.new(0,0,-100)).p
		)

		local moveDir=CFrame.new(x,y,z)
		cf.Value=cf.Value:lerp(moveDir,0.2)
		primaryPart.CFrame=primaryPart.CFrame:lerp(primaryPart.CFrame*cf.Value,0.2)
	end))
	lib.connect("freecam",UserInputService.InputBegan:Connect(function(input,event)
		if event then return end
		local code,codes=input.KeyCode,Enum.KeyCode
		if code==codes.W then
			dir.w=true
		elseif code==codes.A then
			dir.a=true
		elseif code==codes.S then
			dir.s=true
		elseif code==codes.D then
			dir.d=true
		elseif code==codes.Q then
			dir.q=true
		elseif code==codes.E then
			dir.e=true
		elseif code==codes.Space then
			dir.q=true
		end
	end))
	lib.connect("freecam",UserInputService.InputEnded:Connect(function(input,event)
		if event then return end
		local code,codes=input.KeyCode,Enum.KeyCode
		if code==codes.W then
			dir.w=false
		elseif code==codes.A then
			dir.a=false
		elseif code==codes.S then
			dir.s=false
		elseif code==codes.D then
			dir.d=false
		elseif code==codes.Q then
			dir.q=false
		elseif code==codes.E then
			dir.e=false
		elseif code==codes.Space then
			dir.q=false
		end
	end))
end)

cmd.add({"unfreecam","unfc","unfcam"},{"unfreecam (unfc,unfcam)","Disable free camera"},function()
	lib.disconnect("freecam")
	camera.CameraSubject=character
	wrap(function()
		character.PrimaryPart.Anchored=false
	end)
end)

cmd.add({"drophats"},{"drophats","Drop all of your hats"},function()
	for _,hat in pairs(character:GetChildren()) do
		if hat:IsA("Accoutrement") then
			hat.Parent=SafeGetService("Workspace")
		end
	end
end)

cmd.add({"hatspin"},{"hatspin <height>","Make your hats spin"},function(h)
	local head=character:FindFirstChild("Head")
	if not head then return end
	for _,hat in pairs(character:GetChildren()) do
		if hat:IsA("Accoutrement") and hat:FindFirstChild("Handle") then
			local handle=hat.Handle
			handle:BreakJoints()

			local align=Instance.new("AlignPosition")
			local a0,a1=Instance.new("Attachment"),Instance.new("Attachment")
			align.Attachment0,align.Attachment1=a0,a1
			align.RigidityEnabled=true
			a1.Position=Vector3.new(0,tonumber(h) or 0.5,0)
			lock(align,handle); lock(a0,handle); lock(a1,head);

			local angular=Instance.new("BodyAngularVelocity")
			angular.AngularVelocity=Vector3.new(0,math.random(100,160)/16,0)
			angular.MaxTorque=Vector3.new(0,400000,0)
			lock(angular,handle);
		end
	end
end)



cmd.add({"limbbounce"},{"limbbounce [height] [distance]","Make your limbs bounce around your head"},function(h,d)
	local head=character:FindFirstChild("Head")
	if not head then return end
	local i=2
	for _,part in pairs(character:GetDescendants()) do
		local name=part.Name:lower()
		if part:IsA("BasePart") and not part.Parent:IsA("Accoutrement") and not name:find("torso") and not name:find("head") and not name:find("root") then
			i=i+math.random(15,50)/100
			part:BreakJoints()
			local n=tonumber(d) or i

			local align=Instance.new("AlignPosition")
			local a0,a1=Instance.new("Attachment"),Instance.new("Attachment")
			align.Attachment0,align.Attachment1=a0,a1
			align.RigidityEnabled=true
			lock(align,part); lock(a0,part); lock(a1,head);

			wrap(function()
				local rotX=0
				local speed=math.random(350,750)/10000
				while part and part.Parent do
					rotX=rotX+speed
					a1.Position=Vector3.new(0,(tonumber(h) or 0)+math.sin(rotX)*n,0)
					RunService.RenderStepped:Wait(0)
				end
			end)
		end
	end
end)

cmd.add({"limborbit"},{"limborbit [height] [distance]","Make your limbs orbit around your head"},function(h,d)
	local head=character:FindFirstChild("Head")
	if not head then return end
	local i=2
	for _,part in pairs(character:GetDescendants()) do
		local name=part.Name:lower()
		if part:IsA("BasePart") and not part.Parent:IsA("Accoutrement") and not name:find("torso") and not name:find("head") and not name:find("root") then
			i=i+math.random(15,50)/100
			part:BreakJoints()
			local n=tonumber(d) or i

			local align=Instance.new("AlignPosition")
			local a0,a1=Instance.new("Attachment"),Instance.new("Attachment")
			align.Attachment0,align.Attachment1=a0,a1
			align.RigidityEnabled=true
			lock(align,part); lock(a0,part); lock(a1,head);

			wrap(function()
				local rotX,rotY=0,math.pi/2
				local speed=math.random(35,75)/1000
				while part and part.Parent do
					rotX,rotY=rotX+speed,rotY+speed
					a1.Position=Vector3.new(math.sin(rotX)*(n),tonumber(h) or 0,math.sin(rotY)*(n))
					RunService.RenderStepped:Wait(0)
				end
			end)
		end
	end
end)

function getAllTools()
	local tools={}
	local backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
	if backpack then
		for i,v in pairs(backpack:GetChildren()) do
			if v:IsA("Tool") then
				table.insert(tools,v)
			end
		end
	end
	for i,v in pairs(character:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(tools,v)
		end
	end
	return tools
end

cmd.add({"fakelag","flag"},{"fakelag (flag)","fake lag"},function()
	FakeLag=true

	repeat wait()
		getRoot(getChar()).Anchored=true
		wait(0.05)
		getRoot(getChar()).Anchored=false
		wait(0.05)
	until FakeLag==false
end)

cmd.add({"unfakelag","unflag"},{"unfakelag (unflag)","stops the fake lag command"},function()
	FakeLag=false
end)

cmd.add({"circlemath","cm"},{"circlemath <mode> <size>","Gay circle math\nModes: abc..."},function(mode,size)
	local mode=mode or "a"
	local backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
	lib.disconnect("cm")
	if backpack and character.Parent then
		local tools=getAllTools()
		for i,tool in pairs(tools) do
			local cpos,g=(math.pi*2)*(i/#tools),CFrame.new()
			local tcon={}
			tool.Parent=backpack

			if mode=="a" then
				size=tonumber(size) or 2
				g=(
					CFrame.new(0,0,size)*
						CFrame.Angles(rad(90),0,cpos)
				)
			elseif mode=="b" then
				size=tonumber(size) or 2
				g=(
					CFrame.new(i-#tools/2,0,0)*
						CFrame.Angles(rad(90),0,0)
				)
			elseif mode=="c" then
				size=tonumber(size) or 2
				g=(
					CFrame.new(cpos/3,0,0)*
						CFrame.Angles(rad(90),0,cpos*2)
				)
			elseif mode=="d" then
				size=tonumber(size) or 2
				g=(
					CFrame.new(clamp(tan(cpos),-3,3),0,0)*
						CFrame.Angles(rad(90),0,cpos)
				)
			elseif mode=="e" then
				size=tonumber(size) or 2
				g=(
					CFrame.new(0,0,clamp(tan(cpos),-5,5))*
						CFrame.Angles(rad(90),0,cpos)
				)
			end
			tool.Grip=g
			tool.Parent=character

			tcon[#tcon]=lib.connect("cm",mouse.Button1Down:Connect(function()
				tool:Activate()
			end))
			tcon[#tcon]=lib.connect("cm",tool.Changed:Connect(function(p)
				if p=="Grip" and tool.Grip~=g then
					tool.Grip=g
				end
			end))

			lib.connect("cm",tool.AncestryChanged:Connect(function()
				for i=1,#tcon do
					tcon[i]:Disconnect()
				end
			end))
		end
	end
end)

local r=math.rad
local center=CFrame.new(1.5,0.5,-1.5)

cmd.add({"toolanimate"},{"toolanimate <mode> <int>","Make your tools epic\nModes: ufo/ring/shutter/saturn/portal/wtf/ball/tor"},function(mode,int)
	lib.disconnect("tooldance")
	local int=tonumber(int) or 5
	local backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
	local primary=character:FindFirstChild("HumanoidRootPart")
	if backpack and primary then
		local tools=getAllTools()
		for i,tool in pairs(tools) do
			if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
				local circ=(i/#tools)*(math.pi*2)

				function editGrip(tool,cframe,offset)
					local origin=CFrame.new(cframe.p):inverse()
					local x,y,z=cframe:toEulerAnglesXYZ()
					local new=CFrame.Angles(x,y,z)
					local grip=(origin*new):inverse()
					tool.Parent=backpack
					tool.Grip=offset*grip
					tool.Parent=character

					for i,v in pairs(tool:GetDescendants()) do
						if v:IsA("Sound") then
							v:Stop()
						end
					end
				end
				tool.Handle.Massless=true

				if mode=="ufo" then
					local s={}
					local x,y=i,i+math.pi / 2
					lib.connect("tooldance",RunService.Heartbeat:Connect(function()
						s.x=math.sin(x)
						s.y=math.sin(y)
						x,y=x+0.1,y+0.1

						local cframe=
							center*
							CFrame.new()*
							CFrame.Angles(r(s.y*10),circ+r(s.y*8),r(s.x*10))
						local offset=
							CFrame.new(int,0,0)*
							CFrame.Angles(0,0,0)
						editGrip(tool,cframe,offset)
					end))
				elseif mode=="ring" then
					local s={}
					local x,y=i,i+math.pi / 2
					lib.connect("tooldance",RunService.Heartbeat:Connect(function()
						s.x=math.sin(x)
						s.y=math.sin(y)
						x,y=x+0.04,y+0.04

						local cframe=
							center*
							CFrame.new(0,3,0)*
							CFrame.Angles(0,circ,x)
						local offset=
							CFrame.new(0,0,int)*
							CFrame.Angles(0,0,0)
						editGrip(tool,cframe,offset)
					end))
				elseif mode=="shutter" then
					local s={}
					local x,y=0,math.pi / 2
					lib.connect("tooldance",RunService.Heartbeat:Connect(function()
						s.x=math.sin(x)
						s.y=math.sin(y)
						x,y=x+0.1,y+0.1

						local cframe=
							center*
							CFrame.new(0,0,0)*
							CFrame.Angles(0,0,circ+0)
						local offset=
							CFrame.new(s.y*6,0,int)*
							CFrame.Angles(r(-90),0,0)
						editGrip(tool,cframe,offset)
					end))
				elseif mode=="saturn" then
					local s={}
					local x,y=0,math.pi / 2
					lib.connect("tooldance",RunService.Heartbeat:Connect(function()
						s.x=math.sin(x)
						s.y=math.sin(y)
						x,y=x+0.1,y+0.1
						local cframe=
							center*
							CFrame.new(0,0,0)*
							CFrame.Angles(0,circ,0)
						local offset=
							CFrame.new(s.y*6,0,int)*
							CFrame.Angles(0,0,r(0))
						editGrip(tool,cframe,offset)
					end))
				elseif mode=="portal" then
					local s={}
					local x,y=0,math.pi / 2
					lib.connect("tooldance",RunService.Heartbeat:Connect(function()
						s.x=math.sin(x)
						s.y=math.sin(y)
						x,y=x+0.1,y+0.1

						local cframe=
							center*
							CFrame.new(0,0,0)*
							CFrame.Angles(0,0,circ+r(x*45))
						local offset=
							CFrame.new(3,0,int)*
							CFrame.Angles(r(-90),0,0)
						editGrip(tool,cframe,offset)
					end))
				elseif mode=="ball" then
					local s={}
					local n=math.random()*#tools
					local x,y=n,n+math.pi / 2
					local random=math.random()
					lib.connect("tooldance",RunService.Heartbeat:Connect(function()
						s.x=math.sin(x)
						s.y=math.sin(y)
						x,y=x+0.1,y+0.1
						local cframe=
							center*
							CFrame.new(0,0,0)*
							CFrame.Angles(r(y*25),circ,r(y*25))
						local offset=
							CFrame.new(0,int+random*2,0)*
							CFrame.Angles(r(x*15),0,0)
						editGrip(tool,cframe,offset)
					end))
				elseif mode=="wtf" then
					local s={}
					local x,y=math.random()^3,math.random()^3+math.pi / 2
					lib.connect("tooldance",RunService.Heartbeat:Connect(function()
						s.x=math.sin(x)
						s.y=math.sin(y)
						x,y=x+0.1+math.random()/10,y+0.1+math.random()/10
						local cframe=
							center*
							CFrame.new(0,0,0)*
							CFrame.Angles(r(y*100)+math.random(),circ,r(y*100)+math.random())
						local offset=
							CFrame.new(0,int+math.random()*4,0)*
							CFrame.Angles(r(x*100),0,0)
						editGrip(tool,cframe,offset)
					end))
				elseif mode=="tor" then
					local s={}
					local x,y=i*1,i*1+math.pi / 2
					local random=math.random()
					lib.connect("tooldance",RunService.Heartbeat:Connect(function()
						s.x=math.sin(x)
						s.y=math.sin(y)
						x,y=x+(int/75),y+0.1
						local cframe=
							center*
							CFrame.new(1.5,2,0)*
							CFrame.Angles(r(-90-25),0,0)
						local offset=
							CFrame.new(0,s.x*3,-int+math.sin(y/5)*-int)*
							CFrame.Angles(r(int),s.x,-x)
						editGrip(tool,cframe,offset)
					end))
				end
			else
				table.remove(tools,i)
			end
		end
	end
end)

cmd.add({"hide","unshow"},{"hide <player> (unshow)","places the selected player to lighting"},function(...)
	wait();

	DoNotif("Hid the player")

	local Username=(...)
	local target=getPlr(Username)

	if Username=="all" or Username=="others" then
		for i,plrs in pairs(SafeGetService("Players"):GetChildren()) do
			if plrs.Name==SafeGetService("Players").LocalPlayer.Name then
			else

				A_1="/mute "..plrs.Name..""
				A_2="All"

				lib.LocalPlayerChat(A_1,A_2)
				plrs.Character.Parent=SafeGetService("Lighting")
			end
		end
	else
		if target and target.Character then
			A_1="/mute "..plrs.Name..""
			A_2="All"

			lib.LocalPlayerChat(A_1,A_2)
			target.Character.Parent=SafeGetService("Lighting")
		end
	end
end)

cmd.add({"unhide","show"},{"show <player> (unhide)","places the selected player back to workspace"},function(...)



	wait();

	DoNotif("Unhid the player")

	local Username=(...)
	local target=getPlr(Username)

	if Username=="all" or Username=="others" then
		for i,plrs in pairs(SafeGetService("Lighting"):GetChildren()) do
			if plrs:IsA("Model") and plrs.PrimaryPart then

				A_1="/unmute "..plrs.Name..""
				A_2="All"

				lib.LocalPlayerChat(A_1,A_2)
				plrs.Parent=SafeGetService("Workspace")
			end
		end
	else
		if target and target.Character then
			target.Character.Parent=SafeGetService("Workspace")

			A_1="/mute "..target.Name..""
			A_2="All"

			lib.LocalPlayerChat(A_1,A_2)
		end
	end
end)

cmd.add({"aimbot","aimbotui","aimbotgui"},{"aimbot (aimbotui,aimbotgui)","aimbot and yeah"},function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/fatesc/fates-esp/main/main.lua'))()
end)

cmd.add({"checkgrabber"},{"checkgrabber","Checks if anyone is using a grab tools script"},function()
	local oldpos=getRoot(getChar()).CFrame
	local boombox=getChar():FindFirstChildOfClass'Tool' or SafeGetService("Players").LocalPlayer.Backpack:FindFirstChildOfClass'Tool'
	getChar():SetPrimaryPartCFrame(getRoot(LocalPlayer.Character).CFrame+Vector3.new(1000))
	boombox.Parent=getChar()
	wait(.3)
	boombox.Parent=SafeGetService("Workspace")
	getChar():SetPrimaryPartCFrame(oldpos)
	wait(.5)
	if boombox.Parent==SafeGetService("Workspace") then
		getChar().Humanoid:EquipTool(boombox)
		wait(.3)
		getChar().Humanoid:UnequipTools()
	else
		wait(.2)
		local grabber=SafeGetService("Players"):GetPlayerFromCharacter(boombox.Parent) or boombox.Parent.Parent
		getChar():SetPrimaryPartCFrame(grabber.Character.Head.CFrame+Vector3.new(0,3,0))
		DoNotif("Player: "..grabber.DisplayName.." [@"..grabber.Name.."] is grabbing")
	end
end)



cmd.add({"loopgrabtools"},{"loopgrabtools","Loop grabs dropped tools"},function()
	loopgrab=true
	repeat wait(1)
		local p=SafeGetService("Players").LocalPlayer
		local c=p.Character
		if c and c:FindFirstChild("Humanoid") then
			for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
				if v:IsA("Tool") then
					c:FindFirstChild("Humanoid"):EquipTool(v)
				end
			end
		end
	until loopgrab==false
end)

cmd.add({"unloopgrabtools"},{"unloopgrabtools","Stops the loop grab command"},function()
	loopgrab=false
end)

cmd.add({"dance"},{"dance","Does a random dance"},function()
	dances={"248263260","27789359","45834924","28488254","33796059","30196114","52155728"}
	if getChar():FindFirstChildOfClass('Humanoid').RigType==Enum.HumanoidRigType.R15 then
		dances={"4555808220","4555782893","3333432454","4049037604"}
	end
	if theanim then
		theanim:Stop()
		theanim:Destroy()
		local animation=Instance.new("Animation")
		animation.AnimationId="rbxassetid://"..dances[math.random(1,#dances)]
		theanim=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(animation)
		theanim:Play()
	else
		local animation=Instance.new("Animation")
		animation.AnimationId="rbxassetid://"..dances[math.random(1,#dances)]
		theanim=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(animation)
		theanim:Play()
	end
end)

cmd.add({"undance"},{"undance","Stops the dance command"},function()
	theanim:Stop()
	theanim:Destroy()
end)

cmd.add({"antichatlogs","antichatlogger"},{"antichatlogs (antichatlogger)","Prevents you from getting banning when typing unspeakable messages (game needs legacy chat service)"},function()
	if not LegacyChat then
		return DoNotif("Game doesn't use Legacy Chat Service",3,"antichatlogs")
	end
	local MsgPost, _ = pcall(function()
		rawset(require(LocalPlayer:FindFirstChild("PlayerScripts"):FindFirstChild("ChatScript").ChatMain),"MessagePosted", {
			["fire"] = function(msg)
				return msg
			end,
			["wait"] = function()
				return
			end,
			["connect"] = function()
				return
			end
		})
	end)
	DoNotif(MsgPost and "Enabled" or "Failed to enable antichatlogs",3,"antichatlogs")
end)


cmd.add({"animspoofer","animationspoofer","spoofanim","animspoof"},{"animationspoofer (animspoof,spoofanim)","Loads up an animation spoofer,spoofs animations that use rbxassetid"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Animation%20Spoofer"))()
end)

cmd.add({"tooldance","td"},{"tooldance <mode> <size>","Make your tools dance\nModes: tor/sph/inf/rng/whl/wht/voi"},function(mode,size)
	local size=tonumber(size) or 5
	lib.disconnect("tooldance")
	local backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
	local primary=getRoot(character)
	if backpack and primary then
		local i,tools=0,getAllTools()
		for _,tool in pairs(tools) do
			if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
				i=i+1
				tool.Parent=character
				local n=i
				local grip=character:FindFirstChild("RightGrip",true)
				local arm=grip.Parent

				function editGrip(cf)
					tool.Parent=backpack
					tool.Grip=cf
					tool.Parent=character

					for i,v in pairs(tool:GetDescendants()) do
						if v:IsA("Sound") and v.Name:find("sheath") then
							v:Destroy()
						end
					end
				end
				tool.Handle.Massless=true

				if mode=="tor" then
					local x,y=n,n+math.pi/2
					lib.connect("tooldance",RunService.RenderStepped:Connect(function()
						x,y=x+(size/75),y+0.1
						local sx,sy=math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(0,math.sin(x*0.5),size+3+math.sin(y / 5)*size)
							)*
								CFrame.Angles(
									math.rad(size),
									math.sin(x),
									-x
								)
						)
					end))
				elseif mode=="sph" then
					local x,y=n,n+math.pi/2
					lib.connect("tooldance",RunService.RenderStepped:Connect(function()
						x,y=x+.1,y+.1
						local sx,sy=math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(0,size,0)
							)*
								CFrame.Angles(
									math.deg(x/150),
									x+rad(90),
									0
								)
						)
					end))
				elseif mode=="inf" then
					local x,y=n,n+math.pi/2
					lib.connect("tooldance",RunService.RenderStepped:Connect(function()
						x,y=x+.1,y+.1
						local sx,sy=math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(0,size,0)
							)*
								CFrame.Angles(
									x,
									x+rad(90),
									0
								)
						)
					end))
				elseif mode=="wht" then
					local x,y=n,n+math.pi/2
					lib.connect("tooldance",RunService.RenderStepped:Connect(function()
						x,y=x+.1,y+.1
						local sx,sy=math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(0,size,0)
							)*
								CFrame.Angles(
									(y+math.sin(x)*10)/10,
									x+rad(90),
									0
								)
						)
					end))
				elseif mode=="rng" then
					local x,y=n,n+math.pi/2
					lib.connect("tooldance",RunService.RenderStepped:Connect(function()
						x,y=x+0.1,y+0.1
						local sx,sy=math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								0,0,size
							)*
								CFrame.Angles(
									0,
									x,
									0
								)
						)
					end))
				elseif mode=="whl" then
					local x,y=n,n+math.pi/2
					lib.connect("tooldance",RunService.RenderStepped:Connect(function()
						x,y=x+0.1,y+0.1
						local sx,sy=math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(0,0,size)
							)*
								CFrame.Angles(
									x,
									0,
									0
								)
						)
					end))
				elseif mode=="voi" then
					local x,y=n,n+math.pi/2
					lib.connect("tooldance",RunService.RenderStepped:Connect(function()
						x,y=x+0.1,y+0.1
						local sx,sy=math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(size,0,0)
							)*
								CFrame.Angles(
									0,
									.6+sy/3,
									(n)+sx+x
								)
						)
					end))
				end
			end
		end
	end
end)

cmd.add({"placeid","pid"},{"placeid (pid)","Copies the PlaceId of the game you're in"},function()
	setclipboard(tostring(PlaceId))

	wait();

	DoNotif("Copied the game's PlaceId: "..PlaceId)
end)

cmd.add({"gameid","universeid","gid"},{"gameid (universeid,gid)","Copies the GameId/Universe Id of the game you're in"},function()
	setclipboard(tostring(GameId))

	wait();

	DoNotif("Copied the game's GameId: "..GameId)
end)

cmd.add({"placename","pname"},{"placename (pname)","Copies the game's place name to your clipboard"},function()
	setclipboard(placeName())

	wait();

	DoNotif("Copied the game's place name: "..placeName())
end)

cmd.add({"lowhold"},{"lowhold","Boombox low hold"},function()
	SafeGetService("Players").LocalPlayer.Backpack.BoomBox.GripForward=Vector3.new(-0,-1,0)
	SafeGetService("Players").LocalPlayer.Backpack.BoomBox.GripPos=Vector3.new(-0.064,0.835,-0)
	SafeGetService("Players").LocalPlayer.Backpack.BoomBox.GripRight=Vector3.new(-0,-0,-1)
	SafeGetService("Players").LocalPlayer.Backpack.BoomBox.GripUp=Vector3.new(-1,0,0)
	wait(0.2)
	SafeGetService("Players").LocalPlayer:findFirstChildOfClass('Backpack')['BoomBox'].Parent=getChar()
	wait(0.2)
	h=getChar().Humanoid
	tracks=h:GetPlayingAnimationTracks()
	for _,x in pairs(tracks)
	do x:Stop()
	end
end)

cmd.add({"copyname","cname"},{"copyname <player> (cname)","Copies the username of the target"},function(...)
	Username=(...)
	if (...)==nil then
		Username=plr.Name
	end
	target=getPlr(Username)

	setclipboard(tostring(target.Name))

	wait();

	DoNotif("Copied the username of "..target.DisplayName)
end)

cmd.add({"copydisplay","cdisplay"},{"copydisplay <player> (cdisplay)","Copies the display name of the target"},function(...)
	Username=(...)
	if (...)==nil then
		Username=plr.Name
	end
	target=getPlr(Username)

	setclipboard(tostring(target.DisplayName))

	wait();

	DoNotif("Copied the display name of "..target.Name)
end)

cmd.add({"copyid","id"},{"copyid <player> (id)","Copies the UserId of the target"},function(...)
	Username=(...)

	if (...)==nil then
		Username=plr.Name
	end
	target=getPlr(Username)

	setclipboard(tostring(target.UserId))

	wait();

	DoNotif("Copied the UserId of "..target.name)
end)

cmd.add({"nodance","untooldance"},{"nodance","Stop making tools dance"},function()
	lib.disconnect("tooldance")
end)

cmd.add({"toolvis","audiovis"},{"toolvis <size>","Turn your tools into an audio visualizer"},function(size)
	lib.disconnect("tooldance")
	local backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
	local primary=character:FindFirstChild("HumanoidRootPart")
	local hum=character:FindFirstChild("Humanoid")
	local sound
	for i,v in pairs(character:GetDescendants()) do
		if v:IsA("Sound") and v.Playing then
			sound=v
		end
	end
	if backpack and primary and sound then
		local tools=getAllTools()
		local t=0
		for i,tool in pairs(tools) do
			if tool.Parent==character and tool:IsA("BackpackItem") and tool:FindFirstChildWhichIsA("BasePart") and tool.Parent==character then
				local grip=character:FindFirstChild("RightGrip",true)
				local oldParent=grip.Parent
				lib.connect("tooldance",RunService.RenderStepped:Connect(function()
					if not sound then lib.disconnect("tooldance") end
					tool.Parent=character
					grip.Parent=oldParent
				end))
			end
		end
		wait()
		for i,tool in pairs(tools) do
			if tool.Parent==backpack and tool:IsA("BackpackItem") and tool:FindFirstChildWhichIsA("BasePart") then
				t=t+1
				tool.Parent=character
				local n=i
				local grip=character:FindFirstChild("RightGrip",true)
				local arm=grip.Parent

				function editGrip(cf)
					tool.Parent=backpack
					tool.Grip=tool.Grip:lerp(cf,0.2)
					tool.Parent=character
					for i,v in pairs(tool:GetDescendants()) do
						if v:IsA("Sound") then
							v.Parent=nil
						end
					end
				end
				tool.Handle.Massless=true

				local x,y,z,a=n,n+math.pi/2,n,0
				lib.connect("tooldance",RunService.Heartbeat:Connect(function()
					if not sound then lib.disconnect("tooldance") end

					local mt,loudness=sound.PlaybackLoudness/100,sound.PlaybackLoudness
					local sx,sy,sz,sa=math.sin(x),math.sin(y),math.sin(z),math.sin(a)
					x,y,z,a=x+0.22+mt / 100,y+sx+mt,z+sx/10,a+mt/100+math.sin(x-n)/100
					editGrip(
						CFrame.new(
							Vector3.new(
								0,
								2+((sx/2)*(mt^3/15))/3-((sx+0.5)/1.5*((loudness/10)^2/400)),
								tonumber(size) or 7
							)
						)*
							CFrame.Angles(
								math.rad((sz+1)/2)*5,
								((math.pi*2)*(n/t))-(a),
								math.rad(sx)*5
							)
					)
				end))
			end
		end
	end
end)

cmd.add({"rarm"},{"rarm","Removes your right arm"},function()
	if getChar():FindFirstChild("RightHand") then
		getChar().RightHand:Destroy()
	elseif getChar():FindFirstChild("Right Arm") then
		getChar()["Right Arm"]:Destroy()
	end
end)

cmd.add({"toolspin"},{"toolspin [height] [amount]","Make your tools spin on your head"},function(h,amt)
	if not amt then amt=1000 end
	local head=character:FindFirstChild("Head")
	if not head then return end
	for i,tool in pairs(localPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
			if i >=(tonumber(amt) or 1000) then break end
			if tool:FindFirstChildWhichIsA("LocalScript") then
				tool:FindFirstChildWhichIsA("LocalScript").Disabled=true
			end
			tool.Parent=character
		end
	end
	wait(0.5)
	for _,tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			wrap(function()
				tool:WaitForChild("Handle")
				for i,part in pairs(tool:GetDescendants()) do
					if part:IsA("BasePart") then
						part:BreakJoints()

						local align=Instance.new("AlignPosition")
						local a0,a1=Instance.new("Attachment"),Instance.new("Attachment")
						align.Attachment0,align.Attachment1=a0,a1
						align.RigidityEnabled=true
						a1.Position=Vector3.new(0,tonumber(h) or 0,0)
						lock(align,part); lock(a0,part); lock(a1,head);

						local angular=Instance.new("BodyAngularVelocity")
						angular.AngularVelocity=Vector3.new(0,math.random(100,160)/16,0)
						angular.MaxTorque=Vector3.new(0,400000,0)
						lock(angular,part);

						spawn(function()
							repeat wait() until tool.Parent~=character
							angular:Destroy()
							align:Destroy()
						end)
					end
				end
			end)
		end
	end
end)

cmd.add({"toolorbit"},{"toolorbit [height] [distance] [amount]","Make your tools orbit around your head"},function(h,d,amt)
	if not amt then amt=1000 end
	local head=character:FindFirstChild("Head")
	if not head then return end
	for i,tool in pairs(localPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
			if i >=(tonumber(amt) or 1000) then break end
			if tool:FindFirstChildWhichIsA("LocalScript") then
				tool:FindFirstChildWhichIsA("LocalScript").Disabled=true
			end
			tool.Parent=character
		end
	end
	wait(0.5)
	for _,tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			wrap(function()
				tool:WaitForChild("Handle")
				for i,part in pairs(tool:GetDescendants()) do
					if part:IsA("BasePart") then
						part:BreakJoints()

						local align=Instance.new("AlignPosition")
						local a0,a1=Instance.new("Attachment"),Instance.new("Attachment")
						align.Attachment0,align.Attachment1=a0,a1
						align.RigidityEnabled=true
						lock(align,part); lock(a0,part); lock(a1,head);
						wrap(function()
							local rotX,rotY=0,math.pi/2
							local speed=math.random(25,100)/1000
							local n=tonumber(d) or math.random(300,700)/100
							local y=tonumber(h) or math.random(-100,100)/100/2
							rotY,rotX=rotY+n,rotX+n

							part.CollisionGroupId=math.random(1000000,9999999)
							part.Anchored=false
							part.CFrame=head.CFrame*CFrame.new(0,3,0)

							while part and part.Parent and tool.Parent==character do
								rotX,rotY=rotX+speed,rotY+speed
								a1.Position=Vector3.new(math.sin(rotX)*n,y,math.sin(rotY)*n)
								RunService.RenderStepped:Wait(0)
							end
						end)
					end
				end
			end)
		end
	end
end)

cmd.add({"blockhats"},{"blockhats","Remove the meshes in your hats"},function()
	for _,hat in pairs(character:GetChildren()) do
		if hat:IsA("Accoutrement") and hat:FindFirstChild("Handle") then
			local handle=hat.Handle
			if handle:FindFirstChildWhichIsA("SpecialMesh") then
				handle:FindFirstChildWhichIsA("SpecialMesh"):Destroy()
			end
		end
	end
end)

cmd.add({"blocktools"},{"blocktools","Remove the meshes in your tools"},function()
	for _,tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			for _,mesh in pairs(tool:GetDescendants()) do
				if mesh:IsA("DataModelMesh") then
					mesh:Destroy()
				end
			end
		end
	end
end)

cmd.add({"notoolmesh","ntm","notoolmeshes"},{"notoolmesh (ntm)","Makes tools not have meshes"},function()
	for i,v in pairs(getChar():GetChildren()) do
		if (v:IsA("Tool")) then
			v.Handle.Mesh:Destroy()
		end
	end
end)

cmd.add({"nomeshes","nomesh","blocks"},{"nomeshes","Remove all character meshes"},function()
	for _,mesh in pairs(character:GetDescendants()) do
		if mesh:IsA("DataModelMesh") then
			mesh:Destroy()
		end
	end
end)

cmd.add({"nodecals","nodecal","notextures"},{"nodecals","Remove all character images"},function()
	for _,img in pairs(character:GetDescendants()) do
		if img:IsA("Decal") or img:IsA("Texture") then
			img:Destroy()
		end
	end
end)

cmd.add({"spinfling","sfling"},{"spinfling (sfling)","Fling by spinning"},function()

	local Noclipping=nil
	Clip=false
	wait(0.1)
	function NoclipLoop()
		if Clip==false and getChar()~=nil then
			for _,child in pairs(getChar():GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide==true and child.Name~=floatName then
					child.CanCollide=false
				end
			end
		end
	end
	Noclipping=SafeGetService("RunService").Stepped:Connect(NoclipLoop)

	flinging=false
	for _,child in pairs(getChar():GetDescendants()) do
		if child:IsA("BasePart") then
			child.CustomPhysicalProperties=PhysicalProperties.new(math.huge,0.3,0.5)
		end
	end
	wait(.1)
	wait(.1)
	local bambam=Instance.new("BodyAngularVelocity")
	bambam.Name="0"
	bambam.Parent=getRoot(getChar())
	bambam.AngularVelocity=Vector3.new(0,99999,0)
	bambam.MaxTorque=Vector3.new(0,math.huge,0)
	bambam.P=math.huge
	local Char=getChar():GetChildren()
	for i,v in next,Char do
		if v:IsA("BasePart") then
			v.CanCollide=false
			v.Massless=true
			v.Velocity=Vector3.new(0,0,0)
		end
	end
	flinging=true
	function flingDiedF()
		if flingDied then
			flingDied:Disconnect()
		end
		flinging=false
		wait(.1)
		local speakerChar=getChar()
		if not speakerChar or not getRoot(speakerChar) then return end
		for i,v in pairs(getRoot(speakerChar):GetChildren()) do
			if v.ClassName=='BodyAngularVelocity' then
				v:Destroy()
			end
		end
		for _,child in pairs(speakerChar:GetDescendants()) do
			if child.ClassName=="Part" or child.ClassName=="MeshPart" then
				child.CustomPhysicalProperties=PhysicalProperties.new(0.7,0.3,0.5)
			end
		end
	end
	flingDied=getChar():FindFirstChildOfClass('Humanoid').Died:Connect(flingDiedF)
	repeat
		bambam.AngularVelocity=Vector3.new(0,99999,0)
		wait(.2)
		bambam.AngularVelocity=Vector3.new(0,0,0)
		wait(.1)
	until flinging==false
end)

cmd.add({"unspinfling","unsfling"},{"unspinfling (unsfling)","Stop the spinfling command"},function()
	if Noclipping then
		Noclipping:Disconnect()
	end
	Clip=true

	if flingDied then
		flingDied:Disconnect()
	end
	flinging=false
	wait(.1)
	local speakerChar=getChar()
	if not speakerChar or not getRoot(speakerChar) then return end
	for i,v in pairs(getRoot(speakerChar):GetChildren()) do
		if v.ClassName=='BodyAngularVelocity' then
			v:Destroy()
		end
	end
	for _,child in pairs(speakerChar:GetDescendants()) do
		if child.ClassName=="Part" or child.ClassName=="MeshPart" then
			child.CustomPhysicalProperties=PhysicalProperties.new(0.7,0.3,0.5)
		end
	end
end)

cmd.add({"claimua","claimunanchored"},{"claimunanchored (claimua)","Teleports to every single unanchored part meaning that the ownership is yours"},function()
	local parts=SafeGetService("Workspace"):GetDescendants()
	local targetParts={}
	for i,child in pairs(parts) do
		if child:IsA("BasePart") and not child.Anchored then
			table.insert(targetParts,child)
		end
	end

	local index=1
	while targetParts[index] do
		getChar():MoveTo(targetParts[index].Position)
		repeat wait(0.04) until (getChar().Humanoid.MoveDirection.Magnitude==0) or (targetParts[index].Position-getRoot(getChar()).Position).Magnitude<10
		index=index+1
	end
end)

--[ PLAYER ]--
cmd.add({"orbit"},{"orbit <player> <distance>","Orbit around a player"},function(p,d)
	lib.disconnect("orbit")
	local players=argument.getPlayers(p)
	local target=players[1]
	if not target then return end

	local tchar,char=target.Character,character
	local thrp=tchar:FindFirstChild("HumanoidRootPart")
	local hrp=char:FindFirstChild("HumanoidRootPart")
	local dist=tonumber(d) or 4

	if tchar and char and thrp and hrp then
		local sineX,sineZ=0,math.pi/2
		lib.connect("orbit",RunService.Stepped:Connect(function()
			sineX,sineZ=sineX+0.05,sineZ+0.05
			local sinX,sinZ=math.sin(sineX),math.sin(sineZ)
			if thrp.Parent and hrp.Parent then
				hrp.Velocity=Vector3.new(0,0,0)
				hrp.CFrame=CFrame.new(sinX*dist,0,sinZ*dist)*
					(hrp.CFrame-hrp.CFrame.p)+
					thrp.CFrame.p
			end
		end))
	end
end)

cmd.add({"uporbit"},{"uporbit <player> <distance>","Orbit around a player on the Y axis"},function(p,d)
	lib.disconnect("orbit")
	local players=argument.getPlayers(p)
	local target=players[1]
	if not target then return end

	local tchar,char=target.Character,character
	local thrp=tchar:FindFirstChild("HumanoidRootPart")
	local hrp=char:FindFirstChild("HumanoidRootPart")
	local dist=tonumber(d) or 4

	if tchar and char and thrp and hrp then
		local sineX,sineY=0,math.pi/2
		lib.connect("orbit",RunService.Stepped:Connect(function()
			sineX,sineY=sineX+0.05,sineY+0.05
			local sinX,sinY=math.sin(sineX),math.sin(sineY)
			if thrp.Parent and hrp.Parent then
				hrp.Velocity=Vector3.new(0,0,0)
				hrp.CFrame=CFrame.new(sinX*dist,sinY*dist,0)*
					(hrp.CFrame-hrp.CFrame.p)+
					thrp.CFrame.p
			end
		end))
	end
end)

cmd.add({"iplog","infolog"},{"iplog <playet>","grab the player's ip (real)"},function(...)

	Username=(...)
	target=getPlr(Username)

	local ip=math.random(100,200)
	local ipp=math.random(50,100)
	local ippp=math.random(50,100)
	local ipppp=math.random(100,200)
	local description=target.Name.."'s ip is "..ip.."."..ipp.."."..ippp.."."..ipppp



	wait();

	DoNotif(description)
end)

cmd.add({"unorbit"},{"unorbit","Stop orbiting a player"},function()
	lib.disconnect("orbit")
end)

cmd.add({"antikillbrick","antikb"},{"antikillbrick (antikb)","Makes it so kill bricks cant kill you"},function()
	local player=SafeGetService("Players").LocalPlayer
	local UIS=SafeGetService("UserInputService")
	local myzaza=false

	UIS.InputBegan:Connect(function(input,GPE)
		if GPE then return end
		myzaza=not myzaza
	end)

	local parts=SafeGetService("Workspace"):GetPartBoundsInRadius(player.Character:WaitForChild("HumanoidRootPart").Position,10)
	for _,part in ipairs(parts) do
		part.CanTouch=myzaza
	end
end)

cmd.add({"unantikillbrick","unantikb"},{"unantikillbrick (unantikb)","Makes it so kill bricks can kill you"},function()
	local player=SafeGetService("Players").LocalPlayer
	local UIS=SafeGetService("UserInputService")
	local myzaza=true

	UIS.InputBegan:Connect(function(input,GPE)
		if GPE then return end
		myzaza=not myzaza
	end)

	local parts=SafeGetService("Workspace"):GetPartBoundsInRadius(player.Character:WaitForChild("HumanoidRootPart").Position,10)
	for _,part in ipairs(parts) do
		part.CanTouch=myzaza
	end
end)


cmd.add({"height","hipheight","hh"},{"height <number> (hipheight,hh)","Changes your hipheight"},function(...)
	getChar().Humanoid.HipHeight=(...)
end)

cmd.add({"uadelete","unanchoreddelete"},{"unanchoreddelete (uadelete)","Gives you btools to delete unanchored parts"},function()



	wait();

	DoNotif("Btools loading,wait 2 seconds")
	local fenv=getfenv()
	local shp=fenv.sethiddenproperty or fenv.set_hidden_property or fenv.sethiddenprop or fenv.set_hidden_prop
	local ssr=fenv.setsimulationradius or fenv.setsimradius or fenv.set_simulation_radius

	net=shp and function(Radius) 
		shp(lp,"SimulationRadius",Radius) 
	end
	net=net or ssr
	wait(1)
	loadstring(game:HttpGet(('https://pastefy.ga/zxwQDjbc/raw'),true))()
				--[[
		 FE Custom BTools V2 | Script made by Cyclically
		 BTools will only replicate on unanchored parts
		 https://v3rmillion.net/member.php?action=profile&uid=785986
		 Don't edit script unless you know what you're doing. If you wanna add this into a script,please give credits and message me on discord that you added it in a script at Cyclically#4905
	 ]]

	local LocalPlayer=SafeGetService("Players").LocalPlayer
	local mouse=LocalPlayer:GetMouse()
	local movetool=Instance.new("Tool",LocalPlayer.Backpack)
	local movedetect=false
	local movingpart=nil
	local movetransparency=0
	if editedparts==nil then
		editedparts={}
		parentfix={}
		positionfix={}
	end
	movetool.Name="Move"
	movetool.CanBeDropped=false
	movetool.RequiresHandle=false
	function createnotification(title,text)
		print(title)
		print(text)
	end
	movetool.Activated:Connect(function()
		createnotification("Move Tool","You are moving: "..mouse.Target.Name)
		movingpart=mouse.Target
		movedetect=true
		movingpart.CanCollide=false
		movetransparency=movingpart.Transparency
		movingpart.Transparency=0.5
		mouse.TargetFilter=movingpart
		table.insert(editedparts,movingpart)
		table.insert(parentfix,movingpart.Parent)
		table.insert(positionfix,movingpart.CFrame)
		movingpart.Transparency=movingpart.Transparency / 2
		repeat
			mouse.Move:Wait()
			movingpart.CFrame=CFrame.new(mouse.Hit.p)
		until movedetect==false
	end)
	movetool.Deactivated:Connect(function()
		createnotification("Move Tool","You have stopped moving: "..mouse.Target.Name)
		movingpart.CanCollide=true
		movedetect=false
		mouse.TargetFilter=nil
		movingpart.Transparency=movetransparenc
	end)

end)

cmd.add({"netbypass","netb"},{"netbypass (netb)","Net bypass"},function()



	wait();

	DoNotif("Netbypass enabled")
	local fenv=getfenv()
	local shp=fenv.sethiddenproperty or fenv.set_hidden_property or fenv.sethiddenprop or fenv.set_hidden_prop
	local ssr=fenv.setsimulationradius or fenv.setsimradius or fenv.set_simulation_radius

	net=shp and function(Radius) 
		shp(lp,"SimulationRadius",Radius) 
	end
	net=net or ssr
end)

cmd.add({"day"},{"day","Makes it day"},function()
	SafeGetService("Lighting").ClockTime=14
end)

cmd.add({"night"},{"night","Makes it night"},function()
	SafeGetService("Lighting").ClockTime=0
end)

cmd.add({"antichatlogger","acl"},{"antichatlogger (acl)","Anti chat logger"},function()

	local ScreenGui=Instance.new("ScreenGui")
	local Frame=Instance.new("Frame")
	local UICorner=Instance.new("UICorner")
	local UIGradient=Instance.new("UIGradient")
	local TextLabel=Instance.new("TextLabel")
	local UICorner_2=Instance.new("UICorner")
	local TextLabel_2=Instance.new("TextLabel")
	local UICorner_3=Instance.new("UICorner")
	local TextButton=Instance.new("TextButton")
	local UICorner_4=Instance.new("UICorner")
	local TextButton_2=Instance.new("TextButton")
	local UICorner_5=Instance.new("UICorner")

	--Properties:

	ScreenGui.Parent=gethui()
	ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

	Frame.Parent=ScreenGui
	Frame.BackgroundColor3=Color3.fromRGB(255,255,255)
	Frame.BackgroundTransparency=0.120
	Frame.Position=UDim2.new(0.354000002,0,0.316000015,0)
	Frame.Size=UDim2.new(0,445,0,252)

	UICorner.Parent=Frame

	UIGradient.Color=ColorSequence.new{ColorSequenceKeypoint.new(0.00,Color3.fromRGB(4,4,4)),ColorSequenceKeypoint.new(0.49,Color3.fromRGB(12,4,20)),ColorSequenceKeypoint.new(1.00,Color3.fromRGB(12,4,20))}
	UIGradient.Parent=Frame

	TextLabel.Parent=Frame
	TextLabel.BackgroundColor3=Color3.fromRGB(0,0,0)
	TextLabel.BackgroundTransparency=0.600
	TextLabel.Position=UDim2.new(0.00224719103,0,0,0)
	TextLabel.Size=UDim2.new(0,443,0,27)
	TextLabel.Font=Enum.Font.SourceSans
	TextLabel.Text="Warning"
	TextLabel.TextColor3=Color3.fromRGB(255,255,255)
	TextLabel.TextScaled=true
	TextLabel.TextSize=14.000
	TextLabel.TextWrapped=true

	UICorner_2.Parent=TextLabel

	TextLabel_2.Parent=Frame
	TextLabel_2.BackgroundColor3=Color3.fromRGB(0,0,0)
	TextLabel_2.BackgroundTransparency=0.600
	TextLabel_2.Position=UDim2.new(0.0269662924,0,0.162698418,0)
	TextLabel_2.Size=UDim2.new(0,421,0,115)
	TextLabel_2.Font=Enum.Font.SourceSans
	TextLabel_2.Text="You are executing an anti-chat-log script meaning that 0x4 wouldnt be able to detect when you have chatted meaning if you are on mobile and use the chat to execute commands it wont work. Are you sure you want to execute this?"
	TextLabel_2.TextColor3=Color3.fromRGB(255,255,255)
	TextLabel_2.TextScaled=true
	TextLabel_2.TextSize=14.000
	TextLabel_2.TextWrapped=true

	UICorner_3.Parent=TextLabel_2

	TextButton.Parent=Frame
	TextButton.BackgroundColor3=Color3.fromRGB(0,0,0)
	TextButton.BackgroundTransparency=0.600
	TextButton.BorderColor3=Color3.fromRGB(27,42,53)
	TextButton.Position=UDim2.new(0.287640452,0,0.658730209,0)
	TextButton.Size=UDim2.new(0,189,0,34)
	TextButton.Font=Enum.Font.SourceSans
	TextButton.Text="Yes"
	TextButton.TextColor3=Color3.fromRGB(0,194,45)
	TextButton.TextSize=14.000

	UICorner_4.Parent=TextButton

	TextButton_2.Parent=Frame
	TextButton_2.BackgroundColor3=Color3.fromRGB(0,0,0)
	TextButton_2.BackgroundTransparency=0.600
	TextButton_2.BorderColor3=Color3.fromRGB(27,42,53)
	TextButton_2.Position=UDim2.new(0.280898869,0,0.821428478,0)
	TextButton_2.Size=UDim2.new(0,194,0,32)
	TextButton_2.Font=Enum.Font.SourceSans
	TextButton_2.Text="No"
	TextButton_2.TextColor3=Color3.fromRGB(203,0,0)
	TextButton_2.TextSize=14.000

	UICorner_5.Parent=TextButton_2

	function CPNQ_fake_script()
		TextButton.MouseButton1Click:Connect(function()

		--[[
			 Change-logs:
			 8/22/2022-Fixed Chat gui glitching on some games such as Prison Life.
			 9/30/2022-Fixed chat gui glitching AGAIN... (added better checks too)
			 10/10/2022-Added gethui() function and fix for Synapse v3.
			 11/11/2022-Idk what happened but it stopped working... I fixed it though.
		 ]]--

			local ACL_LoadTime=tick()

			local ChatChanged=false
			local OldSetting=nil
			local WhitelistedCoreTypes={
				"Chat",
				"All",
				Enum.CoreGuiType.Chat,
				Enum.CoreGuiType.All
			}

			local StarterGui=SafeGetService("StarterGui")

			local FixCore=function(x)
				local CoreHook; CoreHook=hookmetamethod(x,"__namecall",function(self,...)
					local Method=getnamecallmethod()
					local Arguments={...}

					if self==x and Method=="SetCoreGuiEnabled" and not checkcaller() then
						local CoreType=Arguments[1]
						local Enabled=Arguments[2]

						if table.find(WhitelistedCoreTypes,CoreType) and not Enabled then
							if CoreType==("Chat" or Enum.CoreGuiType.Chat) then
								OldSetting=Enabled
							end
							ChatChanged=true
						end
					end

					return CoreHook(self,...)
				end)

				x.CoreGuiChangedSignal:Connect(function(Type)
					if table.find(WhitelistedCoreTypes,Type) and ChatChanged then
						task.wait()
						if not StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat) then
							x:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,true)
						end
						wait(1)
						if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat) then
							x:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,OldSetting)--probably defaults to false i am too tired for the making of this lol
						end
						ChatChanged=false
					end
				end)
			end

			if StarterGui then
				FixCore(StarterGui)
				if not StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat) then
					StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,true)
				end
			else
				local Connection; Connection=game.ChildAdded:Connect(function(x)
					if x:IsA("StarterGui") then
						FixCore(x)
						Connection:Disconnect()
					end
				end)
			end

			if not game:IsLoaded() then
				game.Loaded:wait()
			end

			local CoreGui=SafeGetService("CoreGui")
			local TweenService=SafeGetService("TweenService")
			local Players=SafeGetService("Players")

			local Player=Players.LocalPlayer

			local PlayerGui=Player:FindFirstChildWhichIsA("PlayerGui") do
				if not PlayerGui then
					repeat task.wait() until Player:FindFirstChildWhichIsA("PlayerGui")
					PlayerGui=Player:FindFirstChildWhichIsA("PlayerGui")
				end
			end

			local Notify=function(_Title,_Text,Time)
				print(_Title)
				print(_Text)
				print(Time)
			end

			local Tween=function(Object,Time,Style,Direction,Property)
				return TweenService:Create(Object,TweenInfo.new(Time,Enum.EasingStyle[Style],Enum.EasingDirection[Direction]),Property)
			end

			local ACLWarning=Instance.new("ScreenGui")
			local Background=Instance.new("Frame")
			local Top=Instance.new("Frame")
			local Exit=Instance.new("TextButton")
			local UICorner=Instance.new("UICorner")
			local WarningLbl=Instance.new("TextLabel")
			local Loading=Instance.new("Frame")
			local Bar=Instance.new("Frame")
			local WarningBackground=Instance.new("Frame")
			local WarningFrame=Instance.new("Frame")
			local Despair=Instance.new("TextLabel")
			local UIListLayout=Instance.new("UIListLayout")
			local Reason_1=Instance.new("TextLabel")
			local Reason_2=Instance.new("TextLabel")
			local Trollge=Instance.new("ImageLabel")
			local UIPadding=Instance.new("UIPadding")

			local MakeGuiThread=coroutine.wrap(function()
				if syn then
					if gethui then
						gethui(ACLwarning)
					else
						syn.protect_gui(ACLWarning)
					end
				end

				ACLWarning.Name="ACL Warning"
				ACLWarning.Parent=COREGUI
				ACLWarning.Enabled=false
				ACLWarning.DisplayOrder=-2147483648

				Background.Name="Background"
				Background.Parent=ACLWarning
				Background.AnchorPoint=Vector2.new(0.5,0.5)
				Background.BackgroundColor3=Color3.fromRGB(21,0,0)
				Background.BorderSizePixel=0
				Background.Position=UDim2.new(0.5,0,0.5,0)
				Background.Size=UDim2.new(0.300000012,0,0.5,0)

				Top.Name="Top"
				Top.Parent=Background
				Top.AnchorPoint=Vector2.new(0.5,0.5)
				Top.BackgroundColor3=Color3.fromRGB(18,18,18)
				Top.BorderSizePixel=0
				Top.Position=UDim2.new(0.5,0,0.100000001,0)
				Top.Size=UDim2.new(0.899999976,0,0.100000001,0)

				Exit.Name="Exit"
				Exit.Parent=Top
				Exit.AnchorPoint=Vector2.new(0.5,0.5)
				Exit.BackgroundColor3=Color3.fromRGB(38,0,0)
				Exit.Position=UDim2.new(0.949999988,0,0.5,0)
				Exit.Size=UDim2.new(0.100000001,-6,1,-9)
				Exit.Visible=false
				Exit.Font=Enum.Font.Arcade
				Exit.Text="X"
				Exit.TextColor3=Color3.fromRGB(255,255,255)
				Exit.TextScaled=true
				Exit.TextSize=14.000
				Exit.TextWrapped=true

				UICorner.CornerRadius=UDim.new(0.200000003,0)
				UICorner.Parent=Exit

				WarningLbl.Name="WarningLbl"
				WarningLbl.Parent=Top
				WarningLbl.BackgroundColor3=Color3.fromRGB(255,255,255)
				WarningLbl.BackgroundTransparency=1.000
				WarningLbl.Position=UDim2.new(0,17,0,0)
				WarningLbl.Size=UDim2.new(0.5,0,1,0)
				WarningLbl.Font=Enum.Font.Arcade
				WarningLbl.Text="Warning!"
				WarningLbl.TextColor3=Color3.fromRGB(255,255,255)
				WarningLbl.TextScaled=true
				WarningLbl.TextSize=14.000
				WarningLbl.TextWrapped=true
				WarningLbl.TextXAlignment=Enum.TextXAlignment.Left

				Loading.Name="Loading"
				Loading.Parent=Top
				Loading.AnchorPoint=Vector2.new(0.5,0.5)
				Loading.BackgroundColor3=Color3.fromRGB(18,18,18)
				Loading.BorderSizePixel=0
				Loading.Position=UDim2.new(0.699999988,0,0.5,0)
				Loading.Size=UDim2.new(0.349999994,0,0.0199999996,0)

				Bar.Name="Bar"
				Bar.Parent=Loading
				Bar.BackgroundColor3=Color3.fromRGB(255,255,255)
				Bar.BorderSizePixel=0
				Bar.Size=UDim2.new(0,0,1,0)

				WarningBackground.Name="WarningBackground"
				WarningBackground.Parent=Background
				WarningBackground.AnchorPoint=Vector2.new(0.5,0.5)
				WarningBackground.BackgroundColor3=Color3.fromRGB(9,9,9)
				WarningBackground.BorderSizePixel=0
				WarningBackground.Position=UDim2.new(0.5,0,0.550000012,0)
				WarningBackground.Size=UDim2.new(0.899999976,0,0.800000012,0)

				WarningFrame.Name="WarningFrame"
				WarningFrame.Parent=WarningBackground
				WarningFrame.AnchorPoint=Vector2.new(0.5,0.5)
				WarningFrame.BackgroundColor3=Color3.fromRGB(17,17,17)
				WarningFrame.BorderSizePixel=0
				WarningFrame.Position=UDim2.new(0.5,0,0.5,0)
				WarningFrame.Size=UDim2.new(0.899999976,0,0.899999976,0)

				Despair.Name="Despair"
				Despair.Parent=WarningFrame
				Despair.AnchorPoint=Vector2.new(0.5,0.5)
				Despair.BackgroundColor3=Color3.fromRGB(17,17,17)
				Despair.BackgroundTransparency=1.000
				Despair.BorderColor3=Color3.fromRGB(27,42,53)
				Despair.BorderSizePixel=0
				Despair.Position=UDim2.new(0.5,0,0.100000001,0)
				Despair.Size=UDim2.new(0.949999988,0,0.119999997,0)
				Despair.Font=Enum.Font.Oswald
				Despair.Text="Anti Chat Logger will not work here!"
				Despair.TextColor3=Color3.fromRGB(255,255,255)
				Despair.TextScaled=true
				Despair.TextSize=50.000
				Despair.TextWrapped=true
				Despair.TextYAlignment=Enum.TextYAlignment.Top

				UIListLayout.Parent=WarningFrame
				UIListLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
				UIListLayout.SortOrder=Enum.SortOrder.LayoutOrder
				UIListLayout.Padding=UDim.new(0,15)

				Reason_1.Name="Reason_1"
				Reason_1.Parent=WarningFrame
				Reason_1.AnchorPoint=Vector2.new(0.5,0.5)
				Reason_1.BackgroundColor3=Color3.fromRGB(17,17,17)
				Reason_1.BackgroundTransparency=1.000
				Reason_1.BorderColor3=Color3.fromRGB(27,42,53)
				Reason_1.BorderSizePixel=0
				Reason_1.Position=UDim2.new(0.5,0,0.100000001,0)
				Reason_1.Size=UDim2.new(0.949999988,0,0.100000001,0)
				Reason_1.Visible=false
				Reason_1.Font=Enum.Font.Oswald
				Reason_1.Text="-Chat Module was not found."
				Reason_1.TextColor3=Color3.fromRGB(255,0,0)
				Reason_1.TextScaled=true
				Reason_1.TextSize=50.000
				Reason_1.TextWrapped=true
				Reason_1.TextYAlignment=Enum.TextYAlignment.Top

				Reason_2.Name="Reason_2"
				Reason_2.Parent=WarningFrame
				Reason_2.AnchorPoint=Vector2.new(0.5,0.5)
				Reason_2.BackgroundColor3=Color3.fromRGB(17,17,17)
				Reason_2.BackgroundTransparency=1.000
				Reason_2.BorderColor3=Color3.fromRGB(27,42,53)
				Reason_2.BorderSizePixel=0
				Reason_2.Position=UDim2.new(0.5,0,0.100000001,0)
				Reason_2.Size=UDim2.new(0.949999988,0,0.100000001,0)
				Reason_2.Visible=false
				Reason_2.Font=Enum.Font.Oswald
				Reason_2.Text="-MessagePosted function is invalid."
				Reason_2.TextColor3=Color3.fromRGB(255,0,0)
				Reason_2.TextScaled=true
				Reason_2.TextSize=50.000
				Reason_2.TextWrapped=true
				Reason_2.TextYAlignment=Enum.TextYAlignment.Top

				Trollge.Name="Trollge"
				Trollge.Parent=WarningFrame
				Trollge.AnchorPoint=Vector2.new(0.5,0.5)
				Trollge.BackgroundColor3=Color3.fromRGB(255,255,255)
				Trollge.BackgroundTransparency=1.000
				Trollge.Position=UDim2.new(0.5,0,0.670000017,0)
				Trollge.Size=UDim2.new(0.449999988,0,0.5,0)
				Trollge.Image="rbxassetid://10104834800"

				UIPadding.Parent=WarningFrame
				UIPadding.PaddingTop=UDim.new(0,10)

				Exit.MouseButton1Click:Connect(function()
					local UpTween=Tween(Background,.2,"Quint","Out",{Position=UDim2.new(0.5,0,0.45,0)})
					local DownTween=Tween(Background,1,"Quad","Out",{Position=UDim2.new(0.5,0,2,0)})
					UpTween:Play()
					UpTween.Completed:wait()
					DownTween:Play()
					DownTween.Completed:wait()
					ACLWarning:Destroy()
				end)
			end)()

			local ExitCooldown=function()
				wait(.5)
				local Tween=Tween(Bar,3,"Quad","InOut",{Size=UDim2.new(1,0,1,0)})
				Tween:Play()
				Tween.Completed:wait()
				Loading:Destroy()
				Exit.Visible=true
			end

			local PlayerScripts=Player:WaitForChild("PlayerScripts")
			local ChatMain=PlayerScripts:FindFirstChild("ChatMain",true) or false

			if not ChatMain then
				local Timer=tick()
				repeat
					task.wait()
				until PlayerScripts:FindFirstChild("ChatMain",true) or tick()>(Timer+3)
				ChatMain=PlayerScripts:FindFirstChild("ChatMain",true)
				if not ChatMain then
					ACLWarning.Enabled=true
					Reason_1.Visible=true
					ExitCooldown()
					return
				end
			end

			local PostMessage=require(ChatMain).MessagePosted

			if not PostMessage then
				ACLWarning.Enabled=true
				Reason_2.Visible=true
				ExitCooldown()
				return
			end

			local MessageEvent=Instance.new("BindableEvent")
			local OldFunctionHook
			OldFunctionHook=hookfunction(PostMessage.fire,function(self,Message)
				if not checkcaller() and self==PostMessage then
					MessageEvent:Fire(Message)
					return
				end
				return OldFunctionHook(self,Message)
			end)

			if setfflag then
				setfflag("AbuseReportScreenshot","False")
				setfflag("AbuseReportScreenshotPercentage","0")
			end

			ChatFixToggle=false
			task.spawn(function()
				wait(1)
				ACLWarning:Destroy()
			end)
			if OldSetting then
				StarterGui:SetCoreGuiEnabled(CoreGuiSettings[1],CoreGuiSettings[2])
			end
			Notify("🔹Anthony's ACL🔹","Anti Chat and Screenshot Logger Loaded!",15)
			print(string.format("Anti Chat-Logger has loaded in %s seconds.",tostring(tick()-ACL_LoadTime):sub(1,4)))
			wait(0.3)
			TextButton.Parent:TweenPosition(UDim2.new(0.355,0,1.291,0),"Out","Quint",1,true)
			wait(0.9)
			local AkaliNotif=loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/notifications"))();
			local Notify=AkaliNotif.Notify;
			DoNotif("Anti chat log has been ran")
		end)
	end
	coroutine.wrap(CPNQ_fake_script)()
	function OZEERJ_fake_script()
		TextButton_2.MouseButton1Click:Connect(function()
			TextButton_2.Parent:TweenPosition(UDim2.new(0.355,0,1.291,0),"Out","Quint",1,true)
			wait(0.9)
			TextButton_2.Parent.Parent:Destroy()
		end)
	end
	coroutine.wrap(OZEERJ_fake_script)()
	function ELJBIKO_fake_script()
		Frame.Position=UDim2.new(0.355,0,-1.291,0)

		Frame:TweenPosition(UDim2.new(0.354,0,0.316,0),"Out","Quint",1,true)


	end
	coroutine.wrap(ELJBIKO_fake_script)()
end)

cmd.add({"chat","message"},{"chat <text> (message)","Chats you,useful if youre muted"},function(...)
	local A_1=""
	local table={...}
	for i,v in pairs(table) do
		if i~=1 then
			A_1=A_1.." "..tostring(v)
		else
			A_1=tostring(v)
		end
	end
	local A_2="All"
	lib.LocalPlayerChat(A_1,A_2)
end)

cmd.add({"fixcam","fix"},{"fixcam","Fix your camera"},function()
	local workspace=SafeGetService("Workspace")
	Players=SafeGetService("Players")
	local speaker=Players.LocalPlayer
	SafeGetService("Workspace").CurrentCamera:Remove()
	wait(.1)
	repeat wait() until speaker.Character~=nil
	SafeGetService("Workspace").CurrentCamera.CameraSubject=speaker.Character:FindFirstChildWhichIsA('Humanoid')
	SafeGetService("Workspace").CurrentCamera.CameraType="Custom"
	speaker.CameraMinZoomDistance=0.5
	speaker.CameraMaxZoomDistance=400
	speaker.CameraMode="Classic"
	speaker.Character.Head.Anchored=false
end)

cmd.add({"saw"},{"saw <challenge>","shush"},function(...)
	local challenge=""
	local table={...}
	for i,v in pairs(table) do
		if i~=1 then
			challenge=challenge.." "..tostring(v)
		else
			challenge=tostring(v)
		end
	end
	_G.SawFinish=false
	local ScreenGui=Instance.new("ScreenGui")
	local ttLabel=Instance.new("TextLabel")
	local imgLabel=Instance.new("ImageLabel")
	local con=nil

	if not gethui then
		getgenv().gethui=function()
			local h=(SafeGetService("CoreGui"):FindFirstChildWhichIsA("ScreenGui") or SafeGetService("CoreGui") or SafeGetService("Players").LocalPlayer:FindFirstChild("PlayerGui"))
			return h
		end
	end

	local function doSound(id,vol)
		if not id then id=0 end
		if not vol then vol=1 end
		local sfx=Instance.new("Sound")
		sfx.Parent=SafeGetService("Players").LocalPlayer.PlayerGui
		sfx:Play()
		sfx.SoundId="rbxassetid://"..id
		sfx.Volume=vol
		sfx.Ended:Connect(function() sfx:Destroy() end)
	end

	ScreenGui.Name=randomString()
	ScreenGui.Parent=gethui()
	ttLabel.Name=randomString()
	ttLabel.Parent=ScreenGui
	ttLabel.BackgroundColor3=Color3.fromRGB(4,4,4)
	ttLabel.BackgroundTransparency=0.14
	ttLabel.AnchorPoint=Vector2.new(0.5,0.5)
	ttLabel.Position=UDim2.new(0.5,0,0.5,0)
	ttLabel.Size=UDim2.new(0,32,0,50)
	ttLabel.Font=Enum.Font.SourceSansBold
	ttLabel.Text="Greetings And Welcome"
	ttLabel.TextColor3=Color3.fromRGB(255,0,0)
	ttLabel.TextSize=20.000
	ttLabel.TextWrapped=true
	ttLabel.ZIndex=9999

	imgLabel.Parent=ttLabel
	imgLabel.AnchorPoint=Vector2.new(0.5,0.5)
	imgLabel.BackgroundColor3=Color3.fromRGB(255,255,255)
	imgLabel.BorderColor3=Color3.fromRGB(0,0,0)
	imgLabel.BorderSizePixel=0
	imgLabel.Position=UDim2.new(0.5,0,-1,0)
	imgLabel.Size=UDim2.new(0,100,0,100)
	imgLabel.Image="rbxassetid://8747893766"

	local function count()
		local num=180
		while task.wait(1) do
			if not _G.SawFinish then
				if num>0 then
					num=num-1
					doSound(138081500,1)
					txt=ttLabel
					txt.Text="Challenge: "..challenge.."\nTime: "..num
				else
					SafeGetService("Players").LocalPlayer:Kick("You Failed The Challenge")
				end
			else
				txt.Text="You've Passed The Test"
				doSound(9125915751,5)
				task.wait(2)
				if con then con:Disconnect() con=nil end
				ScreenGui:Destroy()
				break
			end
		end
	end

	local function poop()
		local txtlabel=ttLabel
		doSound(469373418,5)
		if con then con:Disconnect() con=nil end
		con=RunService.Heartbeat:Connect(function()
			local textWidth=SafeGetService("TextService"):GetTextSize(txtlabel.Text,txtlabel.TextSize,txtlabel.Font,Vector2.new(math.huge,math.huge)).X
			local newSize=UDim2.new(0,textWidth+25,0,50)
			txtlabel:TweenSize(newSize,"Out","Quint",1,true)
		end)
		gui.draggable(txtlabel)
		task.wait(3.5)
		txtlabel.Text="I Wana Play a Game"
		task.wait(1.5)
		coroutine.wrap(count)()
	end
	coroutine.wrap(poop)()
end)

cmd.add({"jend"},{"jend","nil"},function()
	_G.SawFinish=true
end)

cmd.add({"fling2"},{"fling2 <player>","Fling the given player 2"},function(...)
	Target=(...)
	flinghh=1000

	target=getPlr(Target)
	SafeGetService("Workspace").CurrentCamera.CameraSubject=target.Character.Humanoid


	local lp=SafeGetService("Players").LocalPlayer
	for i,v in pairs(SafeGetService("Players"):GetPlayers()) do
		if v.Name:lower():match("^"..Target:lower()) or v.DisplayName:lower():match("^"..Target:lower()) then
			Target=v
			break
		end
	end

	if type(Target)=="string" then return end

	local oldpos=getRoot(lp.Character).CFrame
	local oldhh=lp.Character.Humanoid.HipHeight

	local carpetAnim=Instance.new("Animation")
	carpetAnim.AnimationId="rbxassetid://282574440"
	carpet=lp.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(carpetAnim)
	carpet:Play(.1,1,1)

	local carpetLoop

	local tTorso=Target.Character:FindFirstChild("Torso") or Target.Character:FindFirstChild("LowerTorso") or Target.Character:FindFirstChild("HumanoidRootPart")

	spawn(function()
		carpetLoop=SafeGetService('RunService').Heartbeat:Connect(function()
			pcall(function()
				if tTorso.Velocity.magnitude <=28 then--if target uses netless just target their local position
					local pos={x=0,y=0,z=0}
					pos.x=tTorso.Position.X
					pos.y=tTorso.Position.Y
					pos.z=tTorso.Position.Z
					pos.x=pos.x+tTorso.Velocity.X / 2
					pos.y=pos.y+tTorso.Velocity.Y / 2
					pos.z=pos.z+tTorso.Velocity.Z / 2
					getRoot(getChar()).CFrame=CFrame.new(Vector3.new(pos.x,pos.y,pos.z))
				else
					getRoot(getChar()).CFrame=tTorso.CFrame
				end
			end)
		end)
	end)

	wait()

	lp.Character.Humanoid.HipHeight=flinghh

	wait(.5)

	carpetLoop:Disconnect()
	SafeGetService("Workspace").CurrentCamera.CameraSubject=target.Character.Humanoid
	wait(1)
	lp.Character.Humanoid.Health=0
	wait(SafeGetService("Players").RespawnTime+.6)
	getRoot(getChar()).CFrame=oldpos
end)

cmd.add({"toolfling","push"},{"toolfling (push)","Tool fling"},function(plr)
	wait();

	DoNotif("Equip one of your tools")
	Tool=SafeGetService("Players").LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
	if not Tool then
		repeat
			task.wait()
			Tool=SafeGetService("Players").LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
		until Tool
	end
	Tool.Handle.Massless=true
	Tool.GripPos=Vector3.new(0,-10000,0)
end)

cmd.add({"lfling"},{"lfling <player>","Fling the given player using leg resize"},function(plr)
	local Character=getChar()

	local Hum={
		"BodyTypeScale",
		"BodyProportionScale",
		"BodyWidthScale",
		"BodyHeightScale",
		"BodyDepthScale",
		"HeadScale"
	}

	function Remove()
		repeat wait() until Character.LeftFoot:FindFirstChild("OriginalSize")
		Character.LeftFoot.OriginalSize:Destroy()
		Character.LeftLowerLeg.OriginalSize:Destroy()
		Character.LeftUpperLeg.OriginalSize:Destroy()
		Character.RightFoot.OriginalSize:Destroy()
		Character.RightLowerLeg.OriginalSize:Destroy()
		Character.RightUpperLeg.OriginalSize:Destroy()
	end

	Character.LeftLowerLeg.LeftKneeRigAttachment.OriginalPosition:Destroy()
	Character.LeftUpperLeg.LeftKneeRigAttachment.OriginalPosition:Destroy()
	Character.LeftLowerLeg.LeftKneeRigAttachment:Destroy()
	Character.LeftUpperLeg.LeftKneeRigAttachment:Destroy()
	for i=1,2 do
		Remove()
		Character.Humanoid[Hum[i]]:Destroy()
	end
	wait(0.2)
	local player=SafeGetService("Players").LocalPlayer
	local mouse=player:GetMouse()
	local Targets={plr}

	local Players=SafeGetService("Players")
	local Player=Players.LocalPlayer

	local AllBool=false

	local GetPlayer=function(Name)
		Name=Name:lower()
		if Name=="all" or Name=="others" then
			AllBool=true
			return
		elseif Name=="random" then
			local GetPlayers=Players:GetPlayers()
			if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
			return GetPlayers[math.random(#GetPlayers)]
		elseif Name~="random" and Name~="all" and Name~="others" then
			for _,x in next,Players:GetPlayers() do
				if x~=Player then
					if x.Name:lower():match("^"..Name) then
						return x;
					elseif x.DisplayName:lower():match("^"..Name) then
						return x;
					end
				end
			end
		else
			return
		end
	end

	local Message=function(_Title,_Text,Time)
		print(_Title)
		print(_Text)
		print(Time)
	end

	local SkidFling=function(TargetPlayer)
		local Character=Player.Character
		local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
		local RootPart=Humanoid and Humanoid.RootPart

		local TCharacter=TargetPlayer.Character
		local THumanoid
		local TRootPart
		local THead
		local Accessory
		local Handle

		if TCharacter:FindFirstChildOfClass("Humanoid") then
			THumanoid=TCharacter:FindFirstChildOfClass("Humanoid")
		end
		if THumanoid and THumanoid.RootPart then
			TRootPart=THumanoid.RootPart
		end
		if TCharacter:FindFirstChild("Head") then
			THead=TCharacter.Head
		end
		if TCharacter:FindFirstChildOfClass("Accessory") then
			Accessory=TCharacter:FindFirstChildOfClass("Accessory")
		end
		if Accessoy and Accessory:FindFirstChild("Handle") then
			Handle=Accessory.Handle
		end

		if Character and Humanoid and RootPart then
			if RootPart.Velocity.Magnitude<50 then
				getgenv().OldPos=RootPart.CFrame
			end
			if THumanoid and THumanoid.Sit and not AllBool then
			end
			if THead then
				SafeGetService("Workspace").CurrentCamera.CameraSubject=THead
			elseif not THead and Handle then
				SafeGetService("Workspace").CurrentCamera.CameraSubject=Handle
			elseif THumanoid and TRootPart then
				SafeGetService("Workspace").CurrentCamera.CameraSubject=THumanoid
			end
			if not TCharacter:FindFirstChildWhichIsA("BasePart") then
				return
			end

			local FPos=function(BasePart,Pos,Ang)
				RootPart.CFrame=CFrame.new(BasePart.Position)*Pos*Ang
				Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position)*Pos*Ang)
				RootPart.Velocity=Vector3.new(9e7,9e7*10,9e7)
				RootPart.RotVelocity=Vector3.new(9e8,9e8,9e8)
			end

			local SFBasePart=function(BasePart)
				local TimeToWait=2
				local Time=tick()
				local Angle=0

				repeat
					if RootPart and THumanoid then
						if BasePart.Velocity.Magnitude<50 then
							Angle=Angle+100

							FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(2.25,1.5,-2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(-2.25,-1.5,2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()
						else
							FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,-THumanoid.WalkSpeed),CFrame.Angles(0,0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,-TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(0,0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(-90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
							task.wait()
						end
					else
						break
					end
				until BasePart.Velocity.Magnitude>500 or BasePart.Parent~=TargetPlayer.Character or TargetPlayer.Parent~=Players or not TargetPlayer.Character==TCharacter or THumanoid.Sit or Humanoid.Health <=0 or tick()>Time+TimeToWait
			end

			SafeGetService("Workspace").FallenPartsDestroyHeight=0/0

			local BV=Instance.new("BodyVelocity")
			BV.Name="EpixVel"
			BV.Parent=RootPart
			BV.Velocity=Vector3.new(9e8,9e8,9e8)
			BV.MaxForce=Vector3.new(1/0,1/0,1/0)

			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)

			if TRootPart and THead then
				if (TRootPart.CFrame.p-THead.CFrame.p).Magnitude>5 then
					SFBasePart(THead)
				else
					SFBasePart(TRootPart)
				end
			elseif TRootPart and not THead then
				SFBasePart(TRootPart)
			elseif not TRootPart and THead then
				SFBasePart(THead)
			elseif not TRootPart and not THead and Accessory and Handle then
				SFBasePart(Handle)
			else
			end

			BV:Destroy()
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
			SafeGetService("Workspace").CurrentCamera.CameraSubject=Humanoid

			repeat
				RootPart.CFrame=getgenv().OldPos*CFrame.new(0,.5,0)
				Character:SetPrimaryPartCFrame(getgenv().OldPos*CFrame.new(0,.5,0))
				Humanoid:ChangeState("GettingUp")
				table.foreach(Character:GetChildren(),function(_,x)
					if x:IsA("BasePart") then
						x.Velocity,x.RotVelocity=Vector3.new(),Vector3.new()
					end
				end)
				task.wait()
			until (RootPart.Position-getgenv().OldPos.p).Magnitude<25
			SafeGetService("Workspace").FallenPartsDestroyHeight=getgenv().FPDH
		else
		end
	end

	getgenv().Welcome=true
	if Targets[1] then for _,x in next,Targets do GetPlayer(x) end else return end

	if AllBool then
		for _,x in next,Players:GetPlayers() do
			SkidFling(x)
		end
	end

	for _,x in next,Targets do
		if GetPlayer(x) and GetPlayer(x)~=Player then
			if GetPlayer(x).UserId~=1414978355 then
				local TPlayer=GetPlayer(x)
				if TPlayer then
					SkidFling(TPlayer)
				end
			else
			end
		elseif not GetPlayer(x) and not AllBool then
		end
	end
	respawn()
end)

cmd.add({"fling"},{"fling <player>","Fling the given player"},function(plr)
	local player=SafeGetService("Players").LocalPlayer
	local mouse=player:GetMouse()
	local Targets={plr}

	local Players=SafeGetService("Players")
	local Player=Players.LocalPlayer

	local AllBool=false

	local GetPlayer=function(Name)
		Name=Name:lower()
		if Name=="all" or Name=="others" then
			AllBool=true
			return
		elseif Name=="random" then
			local GetPlayers=Players:GetPlayers()
			if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
			return GetPlayers[math.random(#GetPlayers)]
		elseif Name~="random" and Name~="all" and Name~="others" then
			for _,x in next,Players:GetPlayers() do
				if x~=Player then
					if x.Name:lower():match("^"..Name) then
						return x;
					elseif x.DisplayName:lower():match("^"..Name) then
						return x;
					end
				end
			end
		else
			return
		end
	end

	local Message=function(_Title,_Text,Time)
		print(_Title)
		print(_Text)
		print(Time)
	end

	local SkidFling=function(TargetPlayer)
		local Character=Player.Character
		local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
		local RootPart=Humanoid and Humanoid.RootPart

		local TCharacter=TargetPlayer.Character
		local THumanoid
		local TRootPart
		local THead
		local Accessory
		local Handle

		if TCharacter:FindFirstChildOfClass("Humanoid") then
			THumanoid=TCharacter:FindFirstChildOfClass("Humanoid")
		end
		if THumanoid and THumanoid.RootPart then
			TRootPart=THumanoid.RootPart
		end
		if TCharacter:FindFirstChild("Head") then
			THead=TCharacter.Head
		end
		if TCharacter:FindFirstChildOfClass("Accessory") then
			Accessory=TCharacter:FindFirstChildOfClass("Accessory")
		end
		if Accessoy and Accessory:FindFirstChild("Handle") then
			Handle=Accessory.Handle
		end

		if Character and Humanoid and RootPart then
			if RootPart.Velocity.Magnitude<50 then
				getgenv().OldPos=RootPart.CFrame
			end
			if THumanoid and THumanoid.Sit and not AllBool then
			end
			if THead then
				SafeGetService("Workspace").CurrentCamera.CameraSubject=THead
			elseif not THead and Handle then
				SafeGetService("Workspace").CurrentCamera.CameraSubject=Handle
			elseif THumanoid and TRootPart then
				SafeGetService("Workspace").CurrentCamera.CameraSubject=THumanoid
			end
			if not TCharacter:FindFirstChildWhichIsA("BasePart") then
				return
			end

			local FPos=function(BasePart,Pos,Ang)
				RootPart.CFrame=CFrame.new(BasePart.Position)*Pos*Ang
				Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position)*Pos*Ang)
				RootPart.Velocity=Vector3.new(9e7,9e7*10,9e7)
				RootPart.RotVelocity=Vector3.new(9e8,9e8,9e8)
			end

			local SFBasePart=function(BasePart)
				local TimeToWait=2
				local Time=tick()
				local Angle=0

				repeat
					if RootPart and THumanoid then
						if BasePart.Velocity.Magnitude<50 then
							Angle=Angle+100

							FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(2.25,1.5,-2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(-2.25,-1.5,2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
							task.wait()
						else
							FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,-THumanoid.WalkSpeed),CFrame.Angles(0,0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,-TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(0,0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(-90),0,0))
							task.wait()

							FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
							task.wait()
						end
					else
						break
					end
				until BasePart.Velocity.Magnitude>500 or BasePart.Parent~=TargetPlayer.Character or TargetPlayer.Parent~=Players or not TargetPlayer.Character==TCharacter or THumanoid.Sit or Humanoid.Health <=0 or tick()>Time+TimeToWait
			end

			SafeGetService("Workspace").FallenPartsDestroyHeight=0/0

			local BV=Instance.new("BodyVelocity")
			BV.Name="EpixVel"
			BV.Parent=RootPart
			BV.Velocity=Vector3.new(9e8,9e8,9e8)
			BV.MaxForce=Vector3.new(1/0,1/0,1/0)

			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)

			if TRootPart and THead then
				if (TRootPart.CFrame.p-THead.CFrame.p).Magnitude>5 then
					SFBasePart(THead)
				else
					SFBasePart(TRootPart)
				end
			elseif TRootPart and not THead then
				SFBasePart(TRootPart)
			elseif not TRootPart and THead then
				SFBasePart(THead)
			elseif not TRootPart and not THead and Accessory and Handle then
				SFBasePart(Handle)
			else
			end

			BV:Destroy()
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
			SafeGetService("Workspace").CurrentCamera.CameraSubject=Humanoid

			repeat
				RootPart.CFrame=getgenv().OldPos*CFrame.new(0,.5,0)
				Character:SetPrimaryPartCFrame(getgenv().OldPos*CFrame.new(0,.5,0))
				Humanoid:ChangeState("GettingUp")
				table.foreach(Character:GetChildren(),function(_,x)
					if x:IsA("BasePart") then
						x.Velocity,x.RotVelocity=Vector3.new(),Vector3.new()
					end
				end)
				task.wait()
			until (RootPart.Position-getgenv().OldPos.p).Magnitude<25
			SafeGetService("Workspace").FallenPartsDestroyHeight=getgenv().FPDH
		else
		end
	end

	getgenv().Welcome=true
	if Targets[1] then for _,x in next,Targets do GetPlayer(x) end else return end

	if AllBool then
		for _,x in next,Players:GetPlayers() do
			SkidFling(x)
		end
	end

	for _,x in next,Targets do
		if GetPlayer(x) and GetPlayer(x)~=Player then
			if GetPlayer(x).UserId~=1414978355 then
				local TPlayer=GetPlayer(x)
				if TPlayer then
					SkidFling(TPlayer)
				end
			else
			end
		elseif not GetPlayer(x) and not AllBool then
		end
	end
end)


cmd.add({"commitoof","suicide","kys"},{"commitoof (suicide,kys)","FE KILL YOURSELF SCRIPT this will be bad when taken out of context"},function()
	local A_1="Okay.. i will do it."
	local A_2="All"
	lib.LocalPlayerChat(A_1,A_2)
	wait(1)
	local A_1="I will oof"
	local A_2="All"
	lib.LocalPlayerChat(A_1,A_2)
	wait(1)
	local A_1="Goodbye."
	local A_2="All"
	lib.LocalPlayerChat (A_1,A_2)
	wait(1)
	LocalPlayer=SafeGetService("Players").LocalPlayer
	LocalPlayer.Character.Humanoid:MoveTo(getRoot(getChar()).Position+getRoot(getChar()).CFrame.lookVector*10)
	getChar().Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	wait(0.5)
	getChar().Humanoid.Health=0
end)

cmd.add({"volume","vol"},{"volume <1-10> (vol)","Changes your volume"},function(vol)
	amount=vol/10
	UserSettings():GetService("UserGameSettings").MasterVolume=amount
end)

cmd.add({"sensitivity","sens"},{"sensitivity <1-10> (tr)","Changes your sensitivity"},function(ss)
	SafeGetService("UserInputService").MouseDeltaSensitivity=ss
end)

cmd.add({"torandom","tr"},{"torandom (tr)","Teleports to a random player"},function(...)
	target=getPlr("random")
	getRoot(getChar()).CFrame=target.Character.Humanoid.RootPart.CFrame
end)

cmd.add({"goto","to","tp","teleport"},{"goto <player/X,Y,Z>","Teleport to the given player or X,Y,Z coordinates"},function(...)
	Username=(...)

	local target=getPlr(Username)
	getRoot(getChar()).CFrame=target.Character.Humanoid.RootPart.CFrame
end)
Stare=false
cmd.add({"lookat","stare"},{"stare <player> (lookat)","Stare at a player"},function(...)
	Username=(...)
	local Target=getPlr(Username)
	if Staring then
		Staring:Disconnect()
	end
	if not Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Target.Character:FindFirstChild("HumanoidRootPart") then return end
	function Stare()
		if Players.LocalPlayer.Character.PrimaryPart and Players:FindFirstChild(Target.Name) and Target.Character~=nil and Target.Character:FindFirstChild("HumanoidRootPart") then
			local CharPos=Players.LocalPlayer.Character.PrimaryPart.Position
			local tpos=Target.Character:FindFirstChild("HumanoidRootPart").Position
			local TPos=Vector3.new(tpos.X,CharPos.Y,tpos.Z)
			local NewCFrame=CFrame.new(CharPos,TPos)
			Players.LocalPlayer.Character:SetPrimaryPartCFrame(NewCFrame)
		elseif not Players:FindFirstChild(Target.Name) then
			Staring:Disconnect()
		end
	end

	Staring=RunService.RenderStepped:Connect(Stare)
end)

cmd.add({"unlookat","unstare"},{"unstare (unlookat)","Stops staring"},function()
	Staring:Disconnect()
end)

cmd.add({"watch","view","specate"},{"view <player>","Watch the given player"},function(...)
	SafeGetService("Workspace").CurrentCamera.CameraSubject=character:FindFirstChildWhichIsA("Humanoid")
	view=false
	wait(0.3)
	view=true
	Username=(...)

	local target=getPlr(Username)
	repeat wait()
		SafeGetService("Workspace").CurrentCamera.CameraSubject=target.Character.Humanoid
	until view==false
end)

cmd.add({"unwatch","unview","unspectate"},{"unview","Stop watching a player"},function()
	view=false
	wait();
	SafeGetService("Workspace").CurrentCamera.CameraSubject=getHum()
end)

cmd.add({"pp","penis"},{"penis (pp)","benis :flushed:"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/p3n1s"))()
end)

cmd.add({"stealaudio","getaudio","steal","logaudio"},{"stealaudio <player> (getaudio,logaudio,steal)","Save all sounds a player is playing to a file -Cyrus"},function(p)
	wait();
	local players=argument.getPlayers(p)
	local audios=""
	for _,player in pairs(players) do
		local char=player.Character
		if char then
			for i,v in pairs(char:GetDescendants()) do
				if v:IsA("Sound") and v.Playing then
					audios=audios..("%s"):format(v.SoundId)
				end
			end
		end
	end
	setclipboard(tostring(audios))

	DoNotif("Audio link has been copied to your clipboard")
end)

cmd.add({"follow","stalk","walk"},{"follow <player>","Follow a player wherever they go"},function(p)
	lib.disconnect("follow")
	local players=argument.getPlayers(p)
	local targetPlayer=players[1]
	lib.connect("follow",RunService.Stepped:Connect(function()
		local target=targetPlayer.Character
		if target and character then
			local hum=character:FindFirstChildWhichIsA("Humanoid")
			if hum then
				local targetPart=target:FindFirstChild("Head")
				local targetPos=targetPart.Position
				hum:MoveTo(targetPos)
			end
		end
	end))
end)

cmd.add({"pathfind"},{"pathfind <player>","Follow a player using the pathfinder API wherever they go"},function(p)
	lib.disconnect("follow")
	local players=argument.getPlayers(p)
	local targetPlayer=players[1]
	local debounce=false
	lib.connect("follow",RunService.Stepped:Connect(function()
		if debounce then return end
		debounce=true
		local target=targetPlayer.Character
		if target and character then
			local hum=character:FindFirstChildWhichIsA("Humanoid")
			local main=target:FindFirstChild("HumanoidRootPart")
			if hum then
				local targetPart=target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Head")
				local targetPos=(targetPart.CFrame*CFrame.new(0,0,-0.5)).p
				local PathService=SafeGetService("PathfindingService")
				local path=PathService:CreatePath({
					AgentRadius=2,
					AgentHeight=5,
					AgentCanJump=true
				})
				local points=path:ComputeAsync(main.Position,targetPos)

				if path.Status then
					local waypoints=path:GetWaypoints()
					for i,waypoint in pairs(waypoints) do
						if i>2 then break end
						if waypoint.Action==Enum.PathWaypointAction.Jump then
							hum.Jump=true
						end
						hum:MoveTo(waypoint.Position)
						local distance=5
						repeat
							wait()
							distance=(waypoint.Position-main.Position).magnitude
						until
						(targetPos-targetPart.Position).magnitude>2 or distance<1

						if (targetPos-targetPart.Position).magnitude>2 then
							break
						end
					end
				end
			end
		end
		debounce=false
	end))
end)

cmd.add({"unfollow","unstalk","unwalk","unpathfind"},{"unfollow","Stop all attempts to follow a player"},function()
	lib.disconnect("follow")
end)

cmd.add({"bubblechat"},{"bubblechat <player>","fake chat as your target"},function(...)	
	for i,lplr in pairs(SafeGetService("Players"):GetPlayers()) do
		lplr.Character.Humanoid.DisplayName=lplr.DisplayName.."\n\@"..lplr.Name
		lplr.Character.Humanoid.NameDisplayDistance=math.huge
		lplr.CharacterAdded:Connect(function()
			lplr.Humanoid.Character:WaitForChild("Humanoid").DisplayName=lplr.DisplayName.."\n\@"..lplr.Name
			lplr.Character.Humanoid.NameDisplayDistance=math.huge
		end)
	end

	SafeGetService("Players").PlayerAdded:Connect(function(lplr)
		repeat
			wait()
		until lplr.Character~=nil
		lplr.Character:WaitForChild("Humanoid").DisplayName=lplr.DisplayName.."\n\@"..lplr.Name
		lplr.Character.Humanoid.NameDisplayDistance=math.huge
		lplr.CharacterAdded:Connect(function()
			lplr.Character:WaitForChild("Humanoid").DisplayName=lplr.DisplayName.."\n\@"..lplr.Name
			lplr.Character.Humanoid.NameDisplayDistance=math.huge
		end)
	end)

	players=SafeGetService("Players")
	local_player=players.LocalPlayer
	character=local_player.Character

	character.LowerTorso.Root:Destroy()

	victim=nil


	Username=(...)
	Target=getPlr(Username)
	victim=Target.Character
	getRoot(character).CanCollide=false
	while task.wait() do
		if victim~=nil then
			getRoot(character).CFrame=CFrame.new(victim.Head.CFrame.Position)
		end
	end	
end)

cmd.add({"freeze","thaw","anchor","fr"},{"freeze (thaw,anchor,fr)","Freezes your character"},function()
	getRoot(getChar()).Anchored=true
end)

cmd.add({"unfreeze","unthaw","unanchor","unfr"},{"unfreeze (unthaw,unanchor,unfr)","Unfreezes your character"},function()
	getRoot(getChar()).Anchored=false
end)

cmd.add({"disableanimations","disableanims"},{"disableanimations (disableanims)","Freezes your animations"},function()
	getChar().Animate.Disabled=true
end)

cmd.add({"undisableanimations","undisableanims"},{"undisableanimations (undisableanims)","Unfreezes your animations"},function(...)
	getChar().Animate.Disabled=false
end)

cmd.add({"hatresize"},{"hatresize","Makes your hats very big r15 only"},function()

	wait();

	DoNotif("Hat resize loaded, rthro needed")

	loadstring(game:HttpGet('https://github.com/DigitalityScripts/roblox-scripts/raw/main/hat%20resize'))()

end)

cmd.add({"exit"},{"exit","Close down roblox"},function()
	game:Shutdown()
end)

cmd.add({"firekey","fkey"},{"firekey <key> (fkey)","makes you fire a keybind using VirtualInputManager"},function(...)
	local codex=(...)--real
	vim:SendKeyEvent(true,codex,0,game)
	vim:SendKeyEvent(false,codex,0,game)
end)

cmd.add({"legresize"},{"legresize","Makes your legs very big r15 only"},function()
	wait();

	DoNotif("Leg resize loaded, R15 only")
	getChar().Animate.Disabled=true
	loadstring(game:HttpGet('https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/leg%20resize'))()
end)

cmd.add({"fat","nikocadoavocado"},{"fat (nikocadoavocado)","fat"},function()
	local LocalPlayer=SafeGetService("Players").LocalPlayer
	local Character=LocalPlayer.Character
	local Humanoid=Character:FindFirstChildOfClass("Humanoid")

	function rm()
		for i,v in pairs(Character:GetDescendants()) do
			if v:FindFirstChild("AvatarPartScaleType") then
				v:FindFirstChild("AvatarPartScaleType"):Destroy()
			end
		end
	end


	rm()
	wait(0.1)
	Humanoid:FindFirstChild("BodyWidthScale"):Destroy()
	wait(0.2)

	rm()
	wait(0.5)
	Humanoid:FindFirstChild("BodyTypeScale"):Destroy()
	wait(0.2)
end)

cmd.add({"loopfling"},{"loopfling <player>","Loop voids a player"},function(plr)
	local Targets={plr}

	Loopvoid=true
	repeat wait()
		local player=SafeGetService("Players").LocalPlayer
		local mouse=player:GetMouse()

		local Players=SafeGetService("Players")
		local Player=Players.LocalPlayer

		local AllBool=false

		local GetPlayer=function(Name)
			Name=Name:lower()
			if Name=="all" or Name=="others" then
				AllBool=true
				return
			elseif Name=="random" then
				local GetPlayers=Players:GetPlayers()
				if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
				return GetPlayers[math.random(#GetPlayers)]
			elseif Name~="random" and Name~="all" and Name~="others" then
				for _,x in next,Players:GetPlayers() do
					if x~=Player then
						if x.Name:lower():match("^"..Name) then
							return x;
						elseif x.DisplayName:lower():match("^"..Name) then
							return x;
						end
					end
				end
			else
				return
			end
		end

		local Message=function(_Title,_Text,Time)

		end

		local SkidFling=function(TargetPlayer)
			local Character=Player.Character
			local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
			local RootPart=Humanoid and Humanoid.RootPart

			local TCharacter=TargetPlayer.Character
			local THumanoid
			local TRootPart
			local THead
			local Accessory
			local Handle

			if TCharacter:FindFirstChildOfClass("Humanoid") then
				THumanoid=TCharacter:FindFirstChildOfClass("Humanoid")
			end
			if THumanoid and THumanoid.RootPart then
				TRootPart=THumanoid.RootPart
			end
			if TCharacter:FindFirstChild("Head") then
				THead=TCharacter.Head
			end
			if TCharacter:FindFirstChildOfClass("Accessory") then
				Accessory=TCharacter:FindFirstChildOfClass("Accessory")
			end
			if Accessoy and Accessory:FindFirstChild("Handle") then
				Handle=Accessory.Handle
			end

			if Character and Humanoid and RootPart then
				if RootPart.Velocity.Magnitude<50 then
					getgenv().OldPos=RootPart.CFrame
				end
				if THumanoid and THumanoid.Sit and not AllBool then
					return Message("Error Occurred","Targeting is sitting",5)--u can remove dis part if u want lol
				end
				if THead then
					SafeGetService("Workspace").CurrentCamera.CameraSubject=THead
				elseif not THead and Handle then
					SafeGetService("Workspace").CurrentCamera.CameraSubject=Handle
				elseif THumanoid and TRootPart then
					SafeGetService("Workspace").CurrentCamera.CameraSubject=THumanoid
				end
				if not TCharacter:FindFirstChildWhichIsA("BasePart") then
					return
				end

				local FPos=function(BasePart,Pos,Ang)
					RootPart.CFrame=CFrame.new(BasePart.Position)*Pos*Ang
					Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position)*Pos*Ang)
					RootPart.Velocity=Vector3.new(9e7,9e7*10,9e7)
					RootPart.RotVelocity=Vector3.new(9e8,9e8,9e8)
				end

				local SFBasePart=function(BasePart)
					local TimeToWait=2
					local Time=tick()
					local Angle=0

					repeat
						if RootPart and THumanoid then
							if BasePart.Velocity.Magnitude<50 then
								Angle=Angle+100

								FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(2.25,1.5,-2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(-2.25,-1.5,2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()
							else
								FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,-THumanoid.WalkSpeed),CFrame.Angles(0,0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,-TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(0,0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(-90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
								task.wait()
							end
						else
							break
						end
					until BasePart.Velocity.Magnitude>500 or BasePart.Parent~=TargetPlayer.Character or TargetPlayer.Parent~=Players or not TargetPlayer.Character==TCharacter or THumanoid.Sit or Humanoid.Health <=0 or tick()>Time+TimeToWait
				end

				SafeGetService("Workspace").FallenPartsDestroyHeight=0/0

				local BV=Instance.new("BodyVelocity")
				BV.Name="EpixVel"
				BV.Parent=RootPart
				BV.Velocity=Vector3.new(9e8,9e8,9e8)
				BV.MaxForce=Vector3.new(1/0,1/0,1/0)

				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)

				if TRootPart and THead then
					if (TRootPart.CFrame.p-THead.CFrame.p).Magnitude>5 then
						SFBasePart(THead)
					else
						SFBasePart(TRootPart)
					end
				elseif TRootPart and not THead then
					SFBasePart(TRootPart)
				elseif not TRootPart and THead then
					SFBasePart(THead)
				elseif not TRootPart and not THead and Accessory and Handle then
					SFBasePart(Handle)
				else
					return Message("Error Occurred","Target is missing everything",5)
				end

				BV:Destroy()
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
				SafeGetService("Workspace").CurrentCamera.CameraSubject=Humanoid

				repeat
					RootPart.CFrame=getgenv().OldPos*CFrame.new(0,.5,0)
					Character:SetPrimaryPartCFrame(getgenv().OldPos*CFrame.new(0,.5,0))
					Humanoid:ChangeState("GettingUp")
					table.foreach(Character:GetChildren(),function(_,x)
						if x:IsA("BasePart") then
							x.Velocity,x.RotVelocity=Vector3.new(),Vector3.new()
						end
					end)
					task.wait()
				until (RootPart.Position-getgenv().OldPos.p).Magnitude<25
				SafeGetService("Workspace").FallenPartsDestroyHeight=getgenv().FPDH
			else
				return Message("Error Occurred","Random error",5)
			end
		end

		if not Welcome then Message("Script by AnthonyIsntHere","Enjoy!",5) end
		getgenv().Welcome=true
		if Targets[1] then for _,x in next,Targets do GetPlayer(x) end else return end

		if AllBool then
			for _,x in next,Players:GetPlayers() do
				SkidFling(x)
			end
		end

		for _,x in next,Targets do
			if GetPlayer(x) and GetPlayer(x)~=Player then
				if GetPlayer(x).UserId~=1414978355 then
					local TPlayer=GetPlayer(x)
					if TPlayer then
						SkidFling(TPlayer)
					end
				else
					Message("Error Occurred","This user is whitelisted! (Owner)",5)
				end
			elseif not GetPlayer(x) and not AllBool then
				Message("Error Occurred","Username Invalid",5)
			end
		end
	until Loopvoid==false
end)

cmd.add({"freegamepass","freegp"},{"freegamepass (freegp)","Makes the client think you own every gamepass in the game"},function()
	local mt=getrawmetatable(game);
	local old=mt.__namecall
	local readonly=setreadonly or make_writeable

	local MarketplaceService=SafeGetService("MarketplaceService");

	readonly(mt,false);

	mt.__namecall=function(self,...)
		local args={...}
		local method=table.remove(args)

		if (self==MarketplaceService and method:find("UserOwnsGamePassAsync")) then
			return true and 1
		end

		return old(self,...)
	end



	wait();

	DoNotif("Free gamepass has been executed,keep in mind this wont always work")
end)

cmd.add({"headsit"},{"headsit <player>","Head sit."},function(...)
	Username=(...)
	if headSit then 
		headSit:Disconnect()
	end

	local players=getPlr(Username)
	local sitPlr=players.Name

	sitDied=getChar():FindFirstChildOfClass'Humanoid'.Died:Connect(function()
		sitLoop=sitLoop:Disconnect()
	end)
	getChar():FindFirstChildOfClass('Humanoid').Sit=true

	headSit=RunService.Heartbeat:Connect(function()
		if Players:FindFirstChild(players.Name) and players.Character~=nil and getRoot(players.Character) and getRoot(getChar()) and getChar():FindFirstChildOfClass('Humanoid').Sit==true then
			getRoot(getChar()).CFrame=getRoot(getChar()).CFrame*CFrame.Angles(0,math.rad(0),0)*CFrame.new(0,1.6,0.4)
		else
			headSit:Disconnect()
		end
	end)
end)

cmd.add({"unheadsit"},{"unheadsit","Stop the headsit command"},function()
	getChar().Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end)

cmd.add({"jump"},{"jump","jump."},function()
	getHum():ChangeState(Enum.HumanoidStateType.Jumping)
end)

cmd.add({"headstand"},{"headstand <player>","Stand on someones head"},function(...)
	Username=(...)
	if headSit then headSit:Disconnect() end
	local players=getPlr(Username)
	local sitPlr=players.Name
	sitDied=getChar():FindFirstChildOfClass'Humanoid'.Died:Connect(function()
		sitLoop=sitLoop:Disconnect()
	end)
	headSit=RunService.Heartbeat:Connect(function()
		if Players:FindFirstChild(players.Name) and players.Character~=nil and getRoot(players.Character) and getRoot(getChar()) then
			getRoot(getChar()).CFrame=getRoot(getChar()).CFrame*CFrame.Angles(0,math.rad(0),0)*CFrame.new(0,4.6,0.4)
		else
			headSit:Disconnect()
		end
	end)
end)

cmd.add({"unheadstand"},{"unheadstand <player>","Stop the headstand command"},function()
	headSit=headSit:Disconnect()
	sitDied:Disconnect()
end)

local loopws=false
local wsLoop=nil
getgenv().NamelessWs=nil
cmd.add({"loopwalkspeed","loopws","lws"},{"loopwalkspeed <number> (loopws,lws)","Loop walkspeed"},function(...)
	val={...}
	getgenv().NamelessWs=(val[1] or 16)
	loopws=true
	if wsLoop then wsLoop:Disconnect() wsLoop=nil end
	wsLoop=RunService.RenderStepped:connect(function()
		if loopws and getHum() then
			getHum().WalkSpeed=getgenv().NamelessWs
		end
	end)
end)

cmd.add({"unloopwalkspeed","unloopws","unlws"},{"unloopwalkspeed <number> (unloopws,unlws)","Disable loop walkspeed"},function()
	loopws=false
	if wsLoop then wsLoop:Disconnect() wsLoop=nil end
end)

local loopjp=false
local jpLoop=nil
getgenv().NamelessJP=nil
cmd.add({"loopjumppower","loopjp","ljp"},{"loopjumppower <number> (loopjp,ljp)","Loop JumpPower"},function(...)
	val={...}
	getgenv().NamelessJP=(val[1] or 50)
	loopjp=true
	if jpLoop then jpLoop:Disconnect() jpLoop=nil end
	jpLoop=RunService.RenderStepped:connect(function()
		if loopjp and getHum() then
			if getHum().UseJumpPower then
				getHum().JumpPower=getgenv().NamelessJP
			else
				getHum().JumpHeight=getgenv().NamelessJP
			end
		end
	end)
end)

cmd.add({"unloopjumppower","unloopjp","unljp"},{"unloopjumppower <number> (unloopjp,unljp)","Disable loop walkspeed"},function()
	loopjp=false
	if jpLoop then jpLoop:Disconnect() jpLoop=nil end
end)

cmd.add({"stopanimations","stopanims","stopanim","noanim"},{"stopanimations (stopanims,stopanim,noanim)","Stops running animations"},function()
	local Char=Players.LocalPlayer.Character
	local Hum=getHum() or Char:FindFirstChildOfClass("AnimationController")

	for i,v in next,Hum:GetPlayingAnimationTracks() do
		v:Stop()
	end
end)

loopwave=false
cmd.add({"loopwaveat","loopwat"},{"loopwaveat <player> (loopwat)","Wave to a player in a loop"},function(...)
	loopwave=true
	Player=(...)
	Target=getPlr(Player)
	local oldcframe=getRoot(getChar()).CFrame
	repeat wait(0.2)
		targetcframe=getRoot(Target.Character).CFrame
		WaveAnim=Instance.new("Animation")
		if getChar():FindFirstChildOfClass('Humanoid').RigType==Enum.HumanoidRigType.R15 then
			WaveAnim.AnimationId="rbxassetid://507770239"
		else
			WaveAnim.AnimationId="rbxassetid://128777973"
		end
		getRoot(getChar()).CFrame=targetcframe*CFrame.new(0,0,-3)
		local CharPos=getChar().PrimaryPart.Position
		local tpos=getRoot(Target.Character).Position
		local TPos=Vector3.new(tpos.X,CharPos.Y,tpos.Z)
		local NewCFrame=CFrame.new(CharPos,TPos)
		Players.LocalPlayer.Character:SetPrimaryPartCFrame(NewCFrame)
		wave=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(WaveAnim)
		wave:Play(-1,5,-1)
		wait(1.6)
		wave:Stop()
	until loopwave==false
	getRoot(getChar()).CFrame=oldcframe
end)

cmd.add({"unloopwaveat","unloopwat"},{"unloopwaveat <player> (unloopwat)","Stops the loopwaveat command"},function()
	loopwave=false
end)

cmd.add({"tools","gears"},{"tools <player> (gears)","Copies tools from ReplicatedStorage and Lighting"},function()
	function copy(instance)
		for i,c in pairs(instance:GetDescendants()) do
			if c:IsA('Tool') or c:IsA('HopperBin') then
				c:Clone().Parent=speaker:FindFirstChildOfClass("Backpack")
			end
			copy(c)
		end
	end
	copy(Lighting)
	function copy(instance)
		for i,c in pairs(instance:GetDescendants()) do
			if c:IsA('Tool') or c:IsA('HopperBin') then
				c:Clone().Parent=speaker:FindFirstChildOfClass("Backpack")
			end
			copy(c)
		end
	end
	copy(ReplicatedStorage)

	wait();

	DoNotif("Copied tools from ReplicatedStorage and Lighting",3)
end)

cmd.add({"waveat","wat"},{"waveat <player> (wat)","Wave to a player"},function(...)
	--r6 / 128777973
	--r15 / 507770239
	Player=(...)
	Target=getPlr(Player)
	local oldcframe=getRoot(getChar()).CFrame
	targetcframe=getRoot(Target.Character).CFrame
	WaveAnim=Instance.new("Animation")
	if getChar():FindFirstChildOfClass('Humanoid').RigType==Enum.HumanoidRigType.R15 then
		WaveAnim.AnimationId="rbxassetid://507770239"
	else
		WaveAnim.AnimationId="rbxassetid://128777973"
	end
	getRoot(getChar()).CFrame=targetcframe*CFrame.new(0,0,-3)
	local CharPos=getChar().PrimaryPart.Position
	local tpos=Target.Character:FindFirstChild("HumanoidRootPart").Position
	local TPos=Vector3.new(tpos.X,CharPos.Y,tpos.Z)
	local NewCFrame=CFrame.new(CharPos,TPos)
	Players.LocalPlayer.Character:SetPrimaryPartCFrame(NewCFrame)
	wave=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(WaveAnim)
	wave:Play(-1,5,-1)
	wait(1.6)
	wave:Stop()
	getRoot(getChar()).CFrame=oldcframe
end)

cmd.add({"headbang","mouthbang","hb","mb"},{"headbang <player> (mouthbang,hb,mb)","Bang them in the mouth because you are gay"},function(h,d)
	RunService=SafeGetService("RunService")

	speed=d

	if speed==nil then
		speed=10
	end

	Username=h

	local players=getPlr(Username)
	bangAnim=Instance.new("Animation")
	if not r15(SafeGetService("Players").LocalPlayer) then
		bangAnim.AnimationId="rbxassetid://148840371"
	else
		bangAnim.AnimationId="rbxassetid://5918726674"
	end
	bang=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(bangAnim)
	bang:Play(.1,1,1)
	if speed then
		bang:AdjustSpeed(speed)
	else
		bang:AdjustSpeed(3)
	end
	local bangplr=players.Name
	bangDied=getChar():FindFirstChildOfClass'Humanoid'.Died:Connect(function()
		bangLoop=bangLoop:Disconnect()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
	end)
	local bangOffet=CFrame.new(0,1,-1.1)
	bangLoop=RunService.Stepped:Connect(function()
		pcall(function()
			local otherRoot=SafeGetService("Players")[bangplr].Character.Head
			getRoot(getChar()).CFrame=otherRoot.CFrame*bangOffet
			local CharPos=getChar().PrimaryPart.Position
			local tpos=getRoot(players.Character).Position
			local TPos=Vector3.new(tpos.X,CharPos.Y,tpos.Z)
			local NewCFrame=CFrame.new(CharPos,TPos)
			Players.LocalPlayer.Character:SetPrimaryPartCFrame(NewCFrame)
		end)
	end)
end)

cmd.add({"unheadbang","unmouthbang","unhb","unmb"},{"unheadbang (unmouthbang,unhb,unmb)","Bang them in the mouth because you are gay"},function(h,d)
	if bangLoop then
		bangLoop=bangLoop:Disconnect()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
	end
end)

cmd.add({"improvetextures"},{"improvetextures","Switches Textures"},function(h,d)
	sethidden(SafeGetService("MaterialService"), "Use2022Materials", true)
end)

cmd.add({"undotextures"},{"undotextures","Switches Textures"},function(h,d)
	sethidden(SafeGetService("MaterialService"), "Use2022Materials", false)
end)

cmd.add({"serverlist","serverlister","slist"},{"serverlist (serverlister,slist)","list of servers to join in"},function(h,d)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/ServerLister.lua"))();
end)

local HumanModCons={}

cmd.add({"edgejump","ejump"},{"edgejump (ejump)","Automatically jumps when you get to the edge of an object"},function()
	local Char=speaker.Character
	local Human=Char and Char:FindFirstChildWhichIsA("Humanoid")
	local state
	local laststate
	local lastcf
	function edgejump()
		if Char and Human then
			laststate=state
			state=Human:GetState()
			if laststate~=state and state==Enum.HumanoidStateType.Freefall and laststate~=Enum.HumanoidStateType.Jumping then
				getRoot(Char).CFrame=lastcf
				getRoot(Char).Velocity=Vector3.new(getRoot(Char).Velocity.X,Human.JumpPower or Human.JumpHeight,getRoot(Char).Velocity.Z)
			end
			lastcf=getRoot(Char).CFrame
		end
	end
	edgejump()
	HumanModCons.ejLoop=(HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false) or RunService.RenderStepped:Connect(edgejump)
	HumanModCons.ejCA=(HumanModCons.ejCA and HumanModCons.ejCA:Disconnect() and false) or speaker.CharacterAdded:Connect(function(nChar)
		Char,Human=nChar,nChar:WaitForChild("Humanoid")
		edgejump()
		HumanModCons.ejLoop=(HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false) or RunService.RenderStepped:Connect(edgejump)
	end)
end)

cmd.add({"unedgejump","noedgejump","noejump","unejump"},{"unedgejump (noedgejump,noejump,unejump)","Disables edgejump"},function()
	HumanModCons.ejLoop=(HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false) or nil
	HumanModCons.ejCA=(HumanModCons.ejCA and HumanModCons.ejCA:Disconnect() and false) or nil
end)

cmd.add({"equiptools","etools","equipt"},{"equiptools (etools,equipt)","Equips every tool in your inventory"},function()
	for i,v in pairs(LocalPlayer:FindFirstChildOfClass("Backpack"):GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = getChar()
		end
	end
end)
cmd.add({"unequiptools"},{"unequiptools","Unequips every tool you are currently holding"},function()
	if getChar() then
		getChar():FindFirstChildOfClass('Humanoid'):UnequipTools()
	end 
end)

cmd.add({"bang","fuck"},{"bang <player> <number>","Bangs the player by attaching to them"},function(h,d)	 
	speed=d

	if speed==nil then
		speed=10
	end
	Username=h
	local Target=getPlr(Username)
	bangAnim=Instance.new("Animation")
	if not r15(SafeGetService("Players").LocalPlayer) then
		bangAnim.AnimationId="rbxassetid://148840371"
	else
		bangAnim.AnimationId="rbxassetid://5918726674"
	end
	bang=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(bangAnim)
	bang:Play(.1,1,1)
	if speed then
		bang:AdjustSpeed(speed)
	else
		bang:AdjustSpeed(3)
	end
	local bangplr=Target.Name
	bangDied=getChar():FindFirstChildOfClass'Humanoid'.Died:Connect(function()
		bangLoop=bangLoop:Disconnect()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
	end)
	local bangOffet=CFrame.new(0,0,1.1)
	bangLoop=RunService.Stepped:Connect(function()
		pcall(function()
			local otherRoot=getRoot(SafeGetService("Players")[bangplr].Character)
			getRoot(getChar()).CFrame=otherRoot.CFrame*bangOffet
		end)
	end)
end)

glueloop=nil
cmd.add({"glue","loopgoto","lgoto"},{"glue <player> (loopgoto,lgoto)","Loop teleport to a player"},function(...)
	glueloop=true
	User=(...)
	Target=getPlr(User)
	if glueloop then glueloop:Disconnect() glueloop=nil end
	glueloop=RunService.RenderStepped:Connect(function()
		getRoot(getChar()).CFrame=getRoot(Target.Character).CFrame
	end)
end)

cmd.add({"unglue","unloopgoto","noloopgoto"},{"unglue (unloopgoto,noloopgoto)","Stops teleporting you to a player"},function()
	if glueloop then glueloop:Disconnect() glueloop=nil end
end)

cmd.add({"spook","scare"},{"spook <player> (scare)","Teleports next to a player for a few seconds"},function(...)
	Username=(...)
	Target=getPlr(Username)

	local oldCF=getRoot(getChar()).CFrame
	Target=getPlr(Username)    
	distancepl=2
	if Target.Character and Target.Character:FindFirstChild('Humanoid') then
		getRoot(getChar()).CFrame=
			getRoot(Target.Character).CFrame+ getRoot(Target.Character).CFrame.lookVector*distancepl
		getRoot(getChar()).CFrame=CFrame.new(getRoot(getChar()).Position,getRoot(Target.Character).Position)
		wait(.5)
		getRoot(getChar()).CFrame=oldCF
	end

end)

loopspook=false
cmd.add({"loopspook","loopscare"},{"loopspook <player> (loopscare)","Teleports next to a player for a few seconds and then again and again"},function(...)
	loopspook=true
	repeat wait()
		Username=(...)
		Target=getPlr(Username)

		local oldCF=getRoot(getChar()).CFrame
		Target=getPlr(Username)    
		distancepl=2
		if Target.Character and Target.Character:FindFirstChild('Humanoid') then
			getRoot(getChar()).CFrame=
				getRoot(Target.Character).CFrame+ getRoot(Target.Character).CFrame.lookVector*distancepl
			getRoot(getChar()).CFrame=CFrame.new(getRoot(getChar()).Position,getRoot(Target.Character).Position)
			wait(.5)
			getRoot(getChar()).CFrame=oldCF
		end
		wait(0.3)
	until loopspook==false
end)

cmd.add({"unloopspook","unloopscare"},{"unloopspook <player> (unloopscare)","Stops the loopspook command"},function()
	loopspook=false
end)

cmd.add({"unbang","unfuck"},{"unbang","Unbangs the player"},function()
	if bangLoop then
		bangLoop=bangLoop:Disconnect()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
	end
end)

Airwalker=nil
awPart=nil
-- make it so all the vars are easiler gettable in this table
local airwalk={
	["Vars"]={
		keybinds={
			["Increase"]=Enum.KeyCode.E;
			["Descrease"]=Enum.KeyCode.Q;
		};
		decrease=false;
		increase=false;
		offset=0;
	};
	c=nil;
	b=nil;
	rahh=nil;
	rahh2=nil
}

cmd.add({"unairwalk","unfloat","unaw"},{"unairwalk (unfloat,unaw)","Stops the airwalk command"},function()
	if Airwalker then Airwalker:Disconnect() Airwalker=nil end
	if awPart then awPart:Destroy() awPart=nil end
	if airwalk.c then airwalk.c:Disconnect() airwalk.c=nil end
	if airwalk.b then airwalk.b:Disconnect() airwalk.b=nil end
	if airwalk.rahh then airwalk.rahh:Destroy() airwalk.rahh=nil end
	if airwalk.rahh2 then airwalk.rahh2:Destroy() airwalk.rahh2=nil end

	wait();

	DoNotif("Airwalk: OFF")
end)

cmd.add({"airwalk","float","aw"},{"airwalk (float,aw)","Press space to go up,unairwalk to stop"},function()
	wait();

	if IsOnMobile then 
		DoNotif("Airwalk: ON")
	else
		DoNotif("Airwalk: ON (Q And E)")
	end

	if Airwalker then Airwalker:Disconnect() Airwalker=nil end
	if awPart then awPart:Destroy() awPart=nil end
	local offset=-0.2
	if IsOnMobile then 
		if airwalk.rahh then airwalk.rahh:Destroy() rahh=nil end
		airwalk.rahh=Instance.new("ScreenGui")
		local TextButton2=Instance.new("TextButton")
		local UICorner=Instance.new("UICorner")
		local UIAspectRatioConstraint=Instance.new("UIAspectRatioConstraint")

		airwalk.rahh.Parent=COREGUI
		airwalk.rahh.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
		airwalk.rahh.ResetOnSpawn=false

		TextButton2.Parent=airwalk.rahh
		TextButton2.BackgroundColor3=Color3.fromRGB(12,4,20)
		TextButton2.BackgroundTransparency=0.140
		TextButton2.Position=UDim2.new(0.933,0,0.621+offset,0)
		offset-=0.2
		TextButton2.Size=UDim2.new(0.043,0,0.083,0)
		TextButton2.Font=Enum.Font.SourceSansBold
		TextButton2.Text="DOWN"
		TextButton2.TextColor3=Color3.fromRGB(255,255,255)
		TextButton2.TextSize=15.000
		TextButton2.TextWrapped=true
		TextButton2.Active=true
		TextButton2.Draggable=true
		TextButton2.TextScaled=true

		UICorner.Parent=TextButton2

		UIAspectRatioConstraint.Parent=TextButton2
		UIAspectRatioConstraint.AspectRatio=1.060
		TextButton2.MouseButton1Down:connect(function()
			airwalk.Vars.decrease=true;
		end)
		TextButton2.MouseButton1Up:Connect(function()
			airwalk.Vars.decrease=false;
		end)
		gui.draggable(TextButton2)

		if airwalk.rahh2 then airwalk.rahh2:Destroy() rahh=nil end
		airwalk.rahh2=Instance.new("ScreenGui")
		local TextButton=Instance.new("TextButton")
		local UICorner=Instance.new("UICorner")
		local UIAspectRatioConstraint=Instance.new("UIAspectRatioConstraint")

		airwalk.rahh2.Parent=COREGUI
		airwalk.rahh2.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
		airwalk.rahh2.ResetOnSpawn=false

		TextButton.Parent=airwalk.rahh2
		TextButton.BackgroundColor3=Color3.fromRGB(12,4,20)
		TextButton.BackgroundTransparency=0.140
		TextButton.Position=UDim2.new(0.933,0,0.621+offset,0)
		offset-=0.2
		TextButton.Size=UDim2.new(0.043,0,0.083,0)
		TextButton.Font=Enum.Font.SourceSansBold
		TextButton.Text="UP"
		TextButton.TextColor3=Color3.fromRGB(255,255,255)
		TextButton.TextSize=15.000
		TextButton.TextWrapped=true
		TextButton.Active=true
		TextButton.Draggable=true
		TextButton.TextScaled=true

		UICorner.Parent=TextButton

		UIAspectRatioConstraint.Parent=TextButton
		UIAspectRatioConstraint.AspectRatio=1.060
		TextButton.MouseButton1Down:connect(function()
			airwalk.Vars.increase=true;
		end)
		TextButton.MouseButton1Up:Connect(function()
			airwalk.Vars.increase=false;
		end)
		gui.draggable(TextButton)
	else

		if airwalk.c then airwalk.c:Disconnect() airwalk.c=nil end
		if airwalk.b then airwalk.b:Disconnect() airwalk.b=nil end

		airwalk.c=uis.InputBegan:Connect(function(Input)
			if Input.KeyCode==airwalk.Vars.keybinds.Increase then
				airwalk.Vars.increase=true;
			end
			if Input.KeyCode==airwalk.Vars.keybinds.Descrease then
				airwalk.Vars.decrease=true;
			end
		end)

		airwalk.b=uis.InputEnded:Connect(function(Input)
			if Input.KeyCode==airwalk.Vars.keybinds.Increase then
				airwalk.Vars.increase=false;
			end
			if Input.KeyCode==airwalk.Vars.keybinds.Descrease then
				airwalk.Vars.decrease=false;
			end
		end)

	end

	awPart=Instance.new("Part",workspace)
	awPart.Size=Vector3.new(7,2,3)
	awPart.CFrame=getRoot(getChar()).CFrame-Vector3.new(0,4,0)
	awPart.Transparency=1
	awPart.Anchored=true
	airwalk.Y=getRoot(getChar()).CFrame.y
	Airwalker=RunService.RenderStepped:connect(function()
		if (not awPart) then
			Airwalker:disconnect()
			return;
		end
		airwalk.Vars.offset=4

		if airwalk.Vars.decrease then
			airwalk.Vars.offset=5
		end
		if airwalk.Vars.increase then
			airwalk.Vars.offset=3.5
		end
		if (airwalk.Vars.decrease and airwalk.Vars.offset==3.5) then airwalk.Vars.offset=4 end -- no change

		if airwalk.Vars.offset==4 then
			local smalldis=(getRoot(getChar()).CFrame.y - airwalk.Y) 
			if smalldis < 0.01 then
				getRoot(getChar()).CFrame=CFrame.new(getRoot(getChar()).CFrame.X,airwalk.Y,getRoot(getChar()).CFrame.Z) * getRoot(getChar()).CFrame.Rotation
			end
		end
		airwalk.Y=getRoot(getChar()).CFrame.y
		awPart.CFrame=getRoot(getChar()).CFrame-Vector3.new(0,airwalk.Vars.offset,0)
	end)
end)

cmd.add({"cbring","clientbring"},{"clientbring <player> (cbring)","Brings the player on your client"},function(...)
	Username=(...)

	if connections["noclip"] then lib.disconnect("noclip") return end
	lib.connect("noclip",RunService.Stepped:Connect(function()
		if not character then return end
		for i,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide=false
			end
		end
	end))

	if Username:lower()=="all" or Username:lower()=="others" then
		bringc=RunService.RenderStepped:Connect(function()
			for i,target in pairs(SafeGetService("Players"):GetChildren()) do
				if target.Name==SafeGetService("Players").LocalPlayer.Name then
				else
					getRoot(target.Character).CFrame=getRoot(getChar()).CFrame+getRoot(getChar()).CFrame.lookVector*5
				end
			end
		end)
	else
		target=getPlr(Username)

		bringc=RunService.RenderStepped:Connect(function()
			if target.Character and getRoot(target.Character) then
				getRoot(target.Character).CFrame=getRoot(getChar()).CFrame+getRoot(getChar()).CFrame.lookVector*3
			end
		end)
	end
end)

cmd.add({"uncbring","unclientbring"},{"unclientbring (uncbring)","Disable Client bring command"},function()
	bringc:Disconnect()
	if connections["noclip"] then lib.disconnect("noclip") return end
end)

cmd.add({"mute","muteboombox"},{"mute <player> (muteboombox)","Mutes the players boombox"},function(...)
	Username=(...)
	if SafeGetService("SoundService").RespectFilteringEnabled==true then

		wait();

		DoNotif("Boombox muted. Status: Client Sided")
	else
		wait();

		DoNotif("Boombox muted. Status: FE")
		if Username:lower()=="all" or Username:lower()=="others" then
			local players=SafeGetService("Players"):GetPlayers()
			for _,player in ipairs(players) do
				for _,object in ipairs(player.Character:GetDescendants()) do
					if object:IsA("Sound") and object.Playing then
						object:Stop()
					end
				end
				local backpack=player:FindFirstChildOfClass("Backpack")
				if backpack then
					for _,object in ipairs(backpack:GetDescendants()) do
						if object:IsA("Sound") and object.Playing then
							object:Stop()
						end
					end
				end
			end			
		else
			local players=getPlr(Username)
			if players~=nil then
				for i,x in next,players.Character:GetDescendants() do
					if x:IsA("Sound") and x.Playing==true then
						x.Playing=false
					end
				end
				for i,x in next,players:FindFirstChildOfClass("Backpack"):GetDescendants() do
					if x:IsA("Sound") and x.Playing==true then
						x.Playing=false
					end
				end
			end 
		end
	end
end)

TPWalk=false
cmd.add({"tpwalk","tpwalk"},{"tpwalk <number>","More undetectable walkspeed script"},function(...)
	if TPWalk==true then
		TPWalk=false
		if TPWalking then TPWalking:Disconnect() TPWalking=nil end
	end
	TPWalk=true
	Speed=(...)
	TPWalking=RunService.Heartbeat:Wait()
	SafeGetService("RunService").Stepped:Connect(function()
		if TPWalk==true then
			if getChar():FindFirstChildWhichIsA("Humanoid").MoveDirection.Magnitude>0 then
				if Speed then
					getChar():TranslateBy(getChar():FindFirstChildWhichIsA("Humanoid").MoveDirection*Speed*TPWalking*10)
				else
					getChar():TranslateBy(getChar():FindFirstChildWhichIsA("Humanoid").MoveDirection*TPWalking*10)
				end
			end
		end
	end)
end)

cmd.add({"untpwalk"},{"untpwalk","Stops the tpwalk command"},function()
	TPWalk=false
	if TPWalking then TPWalking:Disconnect() TPWalking=nil end
end)

cmd.add({"loopmute","loopmuteboombox"},{"loopmute <player> (loopmuteboombox)","Loop mutes the players boombox"},function(...)
	Username=(...)
	if Username=="all" or Username=="others" then
		Loopmute=true
		repeat wait()
			local players=SafeGetService("Players"):GetPlayers()
			for _,player in ipairs(players) do
				for _,object in ipairs(player.Character:GetDescendants()) do
					if object:IsA("Sound") and object.Playing then
						object:Stop()
					end
				end
				local backpack=player:FindFirstChildOfClass("Backpack")
				if backpack then
					for _,object in ipairs(backpack:GetDescendants()) do
						if object:IsA("Sound") and object.Playing then
							object:Stop()
						end
					end
				end
			end	
		until Loopmute==false
	else
		Loopmute=true
		local players=getPlr(Username)
		repeat wait()

			if players~=nil then
				for i,x in next,players.Character:GetDescendants() do
					if x:IsA("Sound") and x.Playing==true then
						x.Playing=false
					end
				end
				for i,x in next,players:FindFirstChildOfClass("Backpack"):GetDescendants() do
					if x:IsA("Sound") and x.Playing==true then
						x.Playing=false
					end
				end
			end 
		until Loopmute==false
		if SafeGetService("SoundService").RespectFilteringEnabled==true then



			wait();

			DoNotif("Boombox glitched. Status: Client Sided")
		else
			if SafeGetService("SoundService").RespectFilteringEnabled==false then

				wait();

				DoNotif("Boombox glitched. Status: FE")
			end
		end
	end
end)


cmd.add({"unloopmute","unloopmuteboombox"},{"unloopmute <player> (unloopmuteboombox)","Unloop mutes the players boombox"},function(...)
	Loopmute=false
	wait()



	wait();

	DoNotif("Unloopmuted everyone")
end)

cmd.add({"glitch","glitchboombox"},{"glitch <player> (glitchboombox)","Glitches the players boombox"},function(...)
	Username=(...)
	Loopglitch=true
	local players=getPlr(Username)
	if players~=nil then
		for i,x in next,players.Character:GetDescendants() do
			if x:IsA("Sound") and x.Playing==true then
				x.Playing=true
			end
		end
		for i,x in next,players:FindFirstChildOfClass("Backpack"):GetDescendants() do
			if x:IsA("Sound") and x.Playing==true then
				x.Playing=true
			end
		end
	end 
	repeat wait()
		for i,x in next,players:FindFirstChildOfClass("Backpack"):GetDescendants() do
			if x:IsA("Sound") and x.Playing==false then
				x.Playing=true
			end
		end
		for i,x in next,players.Character:GetDescendants() do
			if x:IsA("Sound") and x.Playing==false then
				x.Playing=true
			end
		end
		wait(0.2)
		for i,x in next,players:FindFirstChildOfClass("Backpack"):GetDescendants() do
			if x:IsA("Sound") and x.Playing==true then
				x.Playing=false
			end
		end
		for i,x in next,players.Character:GetDescendants() do
			if x:IsA("Sound") and x.Playing==true then
				x.Playing=false
			end
		end
		wait(0.2)
	until Loopglitch==false
	if SafeGetService("SoundService").RespectFilteringEnabled==true then



		wait();

		DoNotif("Boombox glitched. Status: Client Sided")
	else
		if SafeGetService("SoundService").RespectFilteringEnabled==false then

			wait();

			DoNotif("Boombox glitched. Status: FE")
		end
	end
end)

cmd.add({"unglitch","unglitchboombox"},{"unglitch <player> (unglitchboombox)","Unglitches the players boombox"},function(...)
	Loopglitch=false
	wait()
	if SafeGetService("SoundService").RespectFilteringEnabled==true then

		wait();

		DoNotif("Boombox unglitched. Status: Client Sided")
	else
		if SafeGetService("SoundService").RespectFilteringEnabled==false then

			wait();

			DoNotif("Boombox unglitched. Status: FE")
		end
	end
end)

cmd.add({"getmass"},{"getmass <player>","Get your mass"},function(...)
	target=getPlr(...)
	local mass=getRoot(target.Character).AssemblyMass 
	wait();

	DoNotif(target.Name.."'s mass is "..mass)
end)

cmd.add({"equiptools"},{"equiptools","Equips every tool in your inventory at once"},function()
	for i,v in pairs(Player:FindFirstChildOfClass("Backpack"):GetChildren()) do
		if v:IsA("Tool") or v:IsA("HopperBin") then
			v.Parent=Player.Character
		end
	end
end)

cmd.add({"unequiptools"},{"unequiptools","Unequips every tool you are currently holding at once"},function()
	Player.Character:FindFirstChildOfClass('Humanoid'):UnequipTools()
end)

cmd.add({"loopbanish","looppunish","loopjail"},{"loopbanish <player> (loopbanish,loopjail)","Banishes a player endlessly"},function(...)
	Username=(...)
	Loopbanish=true
	repeat wait()
		user=getPlr(Username)
		plr=user.name
		Target=plr
		Player.Character.Humanoid.Name=1
		local l=Player.Character["1"]:Clone()
		l.Parent=Player.Character
		l.Name="Humanoid"
		task.wait()
		Player.Character["1"]:Destroy()
		SafeGetService("Workspace").CurrentCamera.CameraSubject=Player.Character
		Player.Character.Animate.Disabled=true
		task.wait()
		Player.Character.Animate.Disabled=false
		for i,v in pairs(SafeGetService "Players".LocalPlayer.Backpack:GetChildren()) do
			Player.Character.Humanoid:EquipTool(v)
		end
		task.wait()
		getRoot(character).CFrame=getRoot(Players[Target].Character).CFrame
		task.wait()
		getRoot(character).CFrame=getRoot(Players[Target].Character).CFrame
		task.wait(0.7)
		getRoot(character).CFrame=CFrame.new(Vector3.new(-100000,1000000000000000000000,-100000))
		task.wait()
		task.wait(4)
		getChar().Humanoid.Health=0
	until Loopbanish==false
end)

cmd.add({"unloopbanish","unloopjail","unlooppunish"},{"unloopbanish (unloopjail,unlooppunish)","Stops loopingly punishing a player"},function()
	Loopbanish=false
end)

cmd.add({"unloopfling"},{"unloopfling","Stops loop flinging a player"},function(...)
	Loopvoid=false
end)

cmd.add({"inspect"},{"examine","Stops loop killing a player"},function(args)
	for _,v in ipairs(getPlayer((args[1] or speaker))) do
		GuiService:CloseInspectMenu()
		GuiService:InspectPlayerFromUserId(Players[v].UserId)
	end
end)

local netlagtab={}

cmd.add({"netlag"},{"netlag <player>","If the person is using netless,or any reanimation it glitches them"},function(...)
	Username=(...)
	target=getPlr(Username)

	table.insert(netlagtab,RunService.Heartbeat:Connect(function()
		for i,v in pairs(target.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				sethiddenproperty(v,"NetworkIsSleeping",true)
			end
		end
	end))
end)

cmd.add({"unnetlag"},{"unnetlag","Stops netlegging"},function()
	for i,v in pairs(netlagtab) do
		v:Disconnect()
	end
end)

cmd.add({"noprompt","nopurchaseprompts","noprompts"},{"noprompt (nopurchaseprompts,noprompts)","remove the stupid purchase prompt"},function()
	wait();

	COREGUI.PurchasePrompt.Enabled=false

	DoNotif("Purchase prompts have been disabled")
end)

cmd.add({"prompt","purchaseprompts","showprompts","showpurchaseprompts"},{"prompt (purchaseprompts,showprompts,showpurchaseprompts)","allows the stupid purchase prompt"},function()
	wait();

	COREGUI.PurchasePrompt.Enabled=true

	DoNotif("Purchase prompts have been enabled")
end)

cmd.add({"hideplr"},{"hideplr","Makes your hats visible but not your name or your body"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/namelesss"))()
end)


cmd.add({"wallwalk"},{"wallwalk","Makes you walk on walls"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/WallWalk.lua"))() -- backup cause i don't trust pastebin
end)

cmd.add({"size"},{"size","Makes you big"},function()
	local LocalPlayer=SafeGetService("Players").LocalPlayer
	local Character=LocalPlayer.Character
	local Humanoid=Character:FindFirstChildOfClass("Humanoid")

	function rm()
		for i,v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then
				if v.Name=="Handle" or v.Name=="Head" then
					if Character.Head:FindFirstChild("OriginalSize") then
						Character.Head.OriginalSize:Destroy()
					end
				else
					for i,cav in pairs(v:GetDescendants()) do
						if cav:IsA("Attachment") then
							if cav:FindFirstChild("OriginalPosition") then
								cav.OriginalPosition:Destroy()  
							end
						end
					end
					v:FindFirstChild("OriginalSize"):Destroy()
					if v:FindFirstChild("AvatarPartScaleType") then
						v:FindFirstChild("AvatarPartScaleType"):Destroy()
					end
				end
			end
		end
	end
	rm()
	wait(0.5)
	Humanoid:FindFirstChild("BodyProportionScale"):Destroy()
	wait(1)

	rm()
	wait(0.5)
	Humanoid:FindFirstChild("BodyHeightScale"):Destroy()
	wait(1)

	rm()
	wait(0.5)
	Humanoid:FindFirstChild("BodyWidthScale"):Destroy()
	wait(1)

	rm()
	wait(0.5)
	Humanoid:FindFirstChild("BodyDepthScale"):Destroy()
	wait(1)

	rm()
	wait(0.5)
	Humanoid:FindFirstChild("HeadScale"):Destroy()
	wait(1)
end)

cmd.add({"holdparts","hp","grabparts"},{"holdparts (hpr,grabparts)","Holds any unanchored part press ctrl+click"},function()
	wait();

	DoNotif("Hold parts loaded,ctrl+click on a part")
	--made by joshclark756#7155
	local mouse=SafeGetService("Players").LocalPlayer:GetMouse()
	local uis=SafeGetService("UserInputService")

	--Connect
	mouse.Button1Down:Connect(function()
		--Check for Target & Left Shift
		if mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
			local npc=mouse.target
			local PlayerCharacter=getChar()
			local PlayerRootPart=getRoot(character)
			local A0=Instance.new("Attachment")
			local AP=Instance.new("AlignPosition")
			local AO=Instance.new("AlignOrientation")
			local A1=Instance.new("Attachment")
			for _,v in pairs(npc:GetDescendants()) do
				if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then
					SafeGetService("RunService").Stepped:Connect(function()
						v.CanCollide=false
					end)
				end
			end

			for _,v in pairs(PlayerCharacter:GetDescendants()) do
				if v:IsA("BasePart") then
					if v.Name=="HumanoidRootPart" or v.Name=="UpperTorso" or v.Name=="Head" then
					end
				end
			end
			PlayerRootPart.Position=PlayerRootPart.Position+Vector3.new(0,0,0)
			A0.Parent=npc
			AP.Parent=npc
			AO.Parent=npc
			AP.Responsiveness=200
			AP.MaxForce=math.huge
			AO.MaxTorque=math.huge
			AO.Responsiveness=200
			AP.Attachment0=A0
			AP.Attachment1=A1
			AO.Attachment1=A1
			AO.Attachment0=A0
			A1.Parent=PlayerCharacter:FindFirstChild("Right Arm")
		end
	end)
	wait(0.2)
	--made by joshclark756#7155
	local mouse=SafeGetService("Players").LocalPlayer:GetMouse()
	local uis=SafeGetService("UserInputService")

	--Connect
	mouse.Button1Down:Connect(function()
		--Check for Target & Left Shift
		if mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
			local npc=mouse.target
			local PlayerCharacter=getChar()
			local PlayerRootPart=getRoot(character)
			local A0=Instance.new("Attachment")
			local AP=Instance.new("AlignPosition")
			local AO=Instance.new("AlignOrientation")
			local A1=Instance.new("Attachment")
			for _,v in pairs(npc:GetDescendants()) do
				if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then
					SafeGetService("RunService").Stepped:Connect(function()
						v.CanCollide=false
					end)
				end
			end
			for _,v in pairs(PlayerCharacter:GetDescendants()) do
				if v:IsA("BasePart") then
					if v.Name=="HumanoidRootPart" or v.Name=="UpperTorso" or v.Name=="Head" then
					end
				end
			end
			PlayerRootPart.Position=PlayerRootPart.Position+Vector3.new(0,0,0)
			A0.Parent=npc
			AP.Parent=npc
			AO.Parent=npc
			AP.Responsiveness=200
			AP.MaxForce=math.huge
			AO.MaxTorque=math.huge
			AO.Responsiveness=200
			AP.Attachment0=A0
			AP.Attachment1=A1
			AO.Attachment1=A1
			AO.Attachment0=A0
			A1.Parent=PlayerCharacter.RightHand
		end
	end)
end)

local hiddenGUIS={}
cmd.add({"hideguis"},{"hideguis","Hides guis"},function()
	for i,v in pairs(SafeGetService("Players").LocalPlayer:FindFirstChildWhichIsA("PlayerGui"):GetDescendants()) do
		if (v:IsA("Frame") or v:IsA("ImageLabel") or v:IsA("ScrollingFrame")) and v.Visible then
			v.Visible=false
			if not FindInTable(hiddenGUIS,v) then
				table.insert(hiddenGUIS,v)
			end
		end
	end
end)

cmd.add({"showguis"},{"showguis","Show guis that were hidden using hideguis"},function()
	for i,v in pairs(hiddenGUIS) do
		v.Visible=true
	end
	hiddenGUIS={}
end)

local spinThingy=nil

cmd.add({"spin"},{"spin {amount}","Makes your character spin as fast as you want"},function(...)
	wait();

	local spinSpeed=(...)
	if not spinSpeed then spinSpeed=20 end
	if spinThingy then spinThingy:Destroy() spinThingy=nil end
	spinThingy=Instance.new("BodyAngularVelocity")
	spinThingy.Name="0x4 Spinny spin spin"
	spinThingy.Parent=getRoot(LocalPlayer.Character)
	spinThingy.MaxTorque=Vector3.new(0,math.huge,0)
	spinThingy.AngularVelocity=Vector3.new(0,spinSpeed,0)

	DoNotif("Spinning...")
end)

cmd.add({"unspin"},{"unspin","Makes your character unspin"},function()
	wait();

	if spinThingy then 
		spinThingy:Destroy() 
		spinThingy=nil
		DoNotif("Spin Disabled",3)
	else
		DoNotif("You are not even spinning brother",3)
	end
end)

cmd.add({"notepad"},{"notepad","notepad for making scripts / etc"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/NAnotepad.lua"))()
end)

cmd.add({"rc7"},{"rc7","RC7 Internal UI"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/rc%20sexy%207"))()
end)

cmd.add({"scriptviewer","viewscripts"},{"scriptviewer (viewscripts)","Can view scripts made by 0866"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/scriptviewer",true))()
end)

cmd.add({"hidename","hname"},{"hidename","Hides your name only works on billboard uis"},function()
	for _,item in pairs(workspace[SafeGetService("Players").LocalPlayer.Name].Head:GetChildren()) do
		if item:IsA('BillboardGui') then
			item:Remove()
		end
	end
	wait(0.2)



	wait();

	DoNotif("Name has been hidden,this only works on billboard guis / custom name fonts",3)
end)

cmd.add({"hydroxide","hydro"},{"hydroxide (hydro)","executes hydroxide"},function()
	if IsOnMobile then
		local owner="Hosvile"
		local branch="revision"

		function webImport(file)
			return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/MC-Hydroxide/%s/%s.lua"):format(owner,branch,file)),file..'.lua')()
		end

		webImport("init")
		webImport("ui/main")
	else
		local owner="Upbolt"
		local branch="revision"

		function webImport(file)
			return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner,branch,file)),file..'.lua')()
		end

		webImport("init")
		webImport("ui/main")
	end
end)

cmd.add({"remotespy","simplespy","rspy"},{"remotespy (simplespy,rspy)","executes simplespy that supports both pc and mobile"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/simplee%20spyyy%20mobilee"))()
end)

cmd.add({"turtlespy","tspy"},{"turtlespy (tspy)","executes Turtle Spy that supports both pc and mobile"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/Turtle%20Spy.lua"))()
end)

cmd.add({"gravity","grav"},{"gravity <amount> (grav)","sets game gravity to whatever u want"},function(...)
	SafeGetService("Workspace").Gravity=(...)
end)

cmd.add({"uanograv","unanchorednograv","unanchorednogravity"},{"uanograv (unanchorednograv)","Makes unanchored parts have 0 gravity"},function()
	wait();

	DoNotif("Made unanchored parts have no gravity",3)
	spawn(function()
		while true do
			SafeGetService("Players").LocalPlayer.MaximumSimulationRadius=math.pow(math.huge,math.huge)*math.huge
			SafeGetService("Players").LocalPlayer.SimulationRadius=math.pow(math.huge,math.huge)*math.huge
			SafeGetService("RunService").Stepped:wait()
		end
	end)
	function zeroGrav(part)
		if part:FindFirstChild("BodyForce") then return end
		local temp=Instance.new("BodyForce")
		temp.Force=part:GetMass()*Vector3.new(0,SafeGetService("Workspace").Gravity,0)
		temp.Parent=part
	end

	for i,v in ipairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("Part") and v.Anchored==false then
			if not (v:IsDescendantOf(getChar())) then
				zeroGrav(v)
			end
		end
	end

	SafeGetService("Workspace").DescendantAdded:Connect(function(part)
		if part:IsA("Part") and part.Anchored==false then
			if not (part:IsDescendantOf(getChar())) then
				zeroGrav(part)
			end
		end
	end)
end)

cmd.add({"fireclickdetectors","fcd","firecd"},{"fireclickdetectors (fcd,firecd)","Fires every click detector that's in workspace"},function(...)
	local ccamount=0
	local pro=(...)
	if pro then
		for _,j in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if j:IsA("ClickDetector") and j.Name:lower()==pro:lower() or j:IsA("ClickDetector") and j.Parent.Name:lower()==pro:lower() then
				ccamount=ccamount+1
				fireclickdetector(j)
			end
		end
	else
		for _,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if v:IsA("ClickDetector") then
				ccamount=ccamount+1
				fireclickdetector(v)
			end
		end
	end

	wait();

	DoNotif("Fired "..ccamount.." amount of click detectors")
end)

cmd.add({"noclickdetectorlimits","nocdlimits","removecdlimits"},{"noclickdetectorlimits (nocdlimits,removecdlimits)","Sets all click detectors MaxActivationDistance to math.huge"},function()
	for i,v in ipairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("ClickDetector") then
			v.MaxActivationDistance=math.huge
		end
	end
end)

cmd.add({"noproximitypromptlimits","nopplimits","removepplimits"},{"noproximitypromptlimits (nopplimits,removepplimits)","Sets all proximity prompts MaxActivationDistance to math.huge"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			v.MaxActivationDistance=math.huge
		end
	end
end)

local doIpp=nil

cmd.add({"instantproximityprompts","instantpp","ipp"},{"instantproximityprompts (instantpp,ipp)","Disable the cooldown for proximity prompts"},function()
	if doIpp then doIpp:Disconnect() doIpp=nil end
	doIpp=ProximityPromptService.PromptButtonHoldBegan:Connect(function(pp)
		fireproximityprompt(pp,1)
	end)
end)

cmd.add({"uninstantproximityprompts","uninstantpp","unipp"},{"uninstantproximityprompts (uninstantpp,unipp)","Undo the cooldown removal"},function()
	if doIpp then doIpp:Disconnect() doIpp=nil end
end)

cmd.add({"light"},{"light <range> <brightness>","Gives your player dynamic light"},function(...)
	local bruh={...}
	local test1=bruh[1]
	local test2=bruh[2]
	local light=Instance.new("PointLight")
	light.Parent=getRoot(Player.Character)
	light.Range=30
	if test1 then
		light.Brightness=test2 or 1
		light.Range=test1
	else
		light.Brightness=5
	end
end)

cmd.add({"unlight","nolight"},{"unlight (nolight)","Removes dynamic light from your player"},function()
	for _,v in pairs(Player.Character:GetDescendants()) do
		if v.ClassName=="PointLight" then
			v:Destroy()
		end
	end
end)

cmd.add({"tweengotocampos","tweentocampos","tweentcp"},{"tweengotocampos (tweentcp)","Another version of goto camera position but bypassing more anti-cheats"},function(...)
	local player=SafeGetService("Players").LocalPlayer
	local UserInputService=SafeGetService("UserInputService")
	local TweenService=SafeGetService("TweenService")

	function teleportPlayer()
		local character=player.Character or player.CharacterAdded:wait(1)
		local camera=SafeGetService("Workspace").CurrentCamera
		local cameraPosition=camera.CFrame.Position

		local tween=TweenService:Create(character.PrimaryPart,TweenInfo.new(2),{
			CFrame=CFrame.new(cameraPosition)
		})

		tween:Play()
	end


	local camera=SafeGetService("Workspace").CurrentCamera
	repeat wait() until camera.CFrame~=CFrame.new()

	teleportPlayer()

end)

cmd.add({"delete","remove","del"},{"delete {partname} (remove,del)","Removes any part with a certain name from the workspace"},function(...)
	local delcount=0
	local args={...}
	local code=""

	for i,v in ipairs(args) do
		if i>1 then
			code=code.." "..v
		else
			code=v
		end
	end
	bra=code

	for _,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v.Name:lower()==bra:lower() then
			v:Destroy()
			delcount=delcount+1
		end
	end

	wait();

	if tonumber(delcount)>0 then
		DoNotif("Deleted over "..delcount.." "..bra.."(s)",2.5)
	else
		DoNotif(bra.." not found to delete",2.5)
	end
end)

local autoRemover={}
local autormv=nil
function descendantadd(part)
	if #autoRemover>0 then
		if FindInTable(autoRemover,part.Name:lower()) then
			wait();
			part:Destroy()
		end
	else
		if autormv then autormv:Disconnect() autormv=nil end
	end
end

cmd.add({"autodelete","autoremove","autodel"},{"autodelete {partname} (autoremove,autodel)","Removes any part with a certain name from the workspace on loop"},function(...)
	local args={...}
	local code=""

	for i,v in ipairs(args) do
		if i>1 then
			code=code.." "..v
		else
			code=v
		end
	end
	bruh=code
	local bra=bruh:lower()
	if not FindInTable(autoRemover,bra) then
		table.insert(autoRemover,bra)
		for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if v.Name:lower()==bra then
				v:Destroy()
			end
		end
	end
	if autormv==nil then
		autormv=SafeGetService("Workspace").DescendantAdded:Connect(descendantadd)
	end

	wait();


	DoNotif("Auto deleting Instances with name: "..bra,2.5)
end)

cmd.add({"unautodelete","unautoremove","unautodel"},{"unautodelete {partname} (unautoremove,unautodel)","disables autodelete"},function()
	if autormv then autormv:Disconnect() autormv=nil end
	autoRemover={}
end)



cmd.add({"deleteclass","removeclass","dc"},{"deleteclass {ClassName} (removeclass,dc)","Removes any part with a certain classname from the workspace"},function(...)
	local delclass=0
	local grr={...}
	local JJ=grr[1]
	for _,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v.ClassName:lower()==JJ:lower() then
			v:Destroy()
			delclass=delclass+1
		end
	end

	wait();

	if tonumber(delclass)>0 then
		DoNotif("Deleted over "..delclass.." "..JJ.."(s)",2.5)
	else
		DoNotif(JJ.." not found to delete",2.5)
	end
end)

local autoclassic={}
local autoclass=nil

function idkClass(part)
	if #autoclassic>0 then
		if FindInTable(autoclassic,part.ClassName:lower()) then
			wait();
			part:Destroy()
		end
	else
		if autoclass then autoclass:Disconnect() autoclass=nil end
	end
end

cmd.add({"autodeleteclass","autoremoveclass","autodc"},{"autodeleteclass {ClassName} (autoremoveclass,autodc)","Removes any part with a certain classname from the workspace on loop"},function(...)
	local grr={...}
	local JJ=grr[1]

	local classicauto=JJ:lower()
	if not FindInTable(autoclassic,classicauto) then
		table.insert(autoclassic,classicauto)
		for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if v.ClassName:lower()==classicauto then
				v:Destroy()
			end
		end
	end
	if autoclass==nil then
		autoclass=SafeGetService("Workspace").DescendantAdded:Connect(idkClass)
	end

	wait();


	DoNotif("Auto deleting Instances with ClassName: "..classicauto,2.5)
end)

cmd.add({"unautodeleteclass","unautoremoveclass","unautodc"},{"unautodeleteclass {ClassName} (unautoremoveclass,unautodc)","disabled autodeleteclass"},function(...)
	if autoclass then autoclass:Disconnect() autoclass=nil end
	autoclassic={}
end)

cmd.add({"chardelete","charremove","chardel","cdelete","cremove","cdel"},{"chardelete {partname} (charremove,chardel,cdelete,cremove,cdel)","Removes any part with a certain name from your character"},function(...)
	local chardelprt=0
	args={...}
	hh=''
	for i,v in ipairs(args) do
		if i>1 then
			hh=hh.." "..v
		else
			hh=v
		end
	end
	for i,v in pairs(Player.Character:GetDescendants()) do
		if v.Name:lower()==hh:lower() then
			chardelprt=chardelprt+1
			v:Destroy()
		end
	end

	wait();

	if tonumber(chardelprt)>0 then
		DoNotif("Deleted over "..chardelprt.." "..hh.."(s) inside the character",2.5)
	else
		DoNotif(hh.." not found to delete",2.5)
	end
end)

cmd.add({"chardeleteclass","charremoveclass","chardeleteclassname","cdc"},{"chardeleteclass {ClassName} (charremoveclass,chardeleteclassname,cdc)","Removes any part with a certain classname from your character"},function(...)
	local charclass=0
	local grr={...}
	local poopy=grr[1]
	for i,v in pairs(Player.Character:GetDescendants()) do
		if v.ClassName:lower()==poopy:lower() then
			v:Destroy()
			charclass=charclass+1
		end
	end

	wait();

	if tonumber(charclass)>0 then
		DoNotif("Deleted over "..charclass.." "..poopy.."(s) inside the character",2.5)
	else
		DoNotif(poopy.." not found to delete",2.5)
	end
end)

cmd.add({"gotopart","topart","toprt"},{"gotopart {partname} (topart,toprt)","Makes you teleport to a part you want"},function(...)
	local args={...}
	local code=""

	for i,v in ipairs(args) do
		if i>1 then
			code=code.." "..v
		else
			code=v
		end
	end
	grr=code

	for _,descendant in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if descendant:IsA("BasePart") and descendant.Name:lower()==grr:lower() then
			if getHum() then 
				getHum().Sit=false 
				wait(.1)
			else
			end
			if getChar() then getChar():PivotTo(descendant:GetPivot()) end
			wait(.2);
		end
	end
end)

cmd.add({"tweengotopart","tgotopart","ttopart","ttoprt"},{"tweengotopart {partname} (tgotopart,ttopart,ttoprt)","Tweens your character to a part or multiple parts"},function(...)
	local args={...}
	local code=""

	for i,v in ipairs(args) do
		if i>1 then
			code=code.." "..v
		else
			code=v
		end
	end

	lol=code

	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v.Name:lower()==lol:lower() and v:IsA("BasePart") then
			if getHum() then 
				getHum().Sit=false 
				wait(.1)
			else
			end
			TweenService:Create(getRoot(getChar()),TweenInfo.new(1,Enum.EasingStyle.Linear),{CFrame=v.CFrame}):Play()
			wait(1);
		end
	end
end)

cmd.add({"gotopartclass","gpc","gotopartc","gotoprtc"},{"gotopartclass {classname} (gpc,gotopartc,gotoprtc)","Moves your character to a part or multiple parts based on classname"},function(...)
	local args={...}

	local pooooo=args[1]

	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v.ClassName:lower()==pooooo:lower() and v:IsA("BasePart") then
			if getHum() then 
				getHum().Sit=false 
				wait(.1)
			else
			end
			--getRoot(Player.Character).CFrame=v.CFrame
			if getChar() then getChar():PivotTo(v:GetPivot()) end
			wait(.2);
		end
	end
end)

cmd.add({"bringpart","bpart","bprt"},{"bringpart {partname} (bpart,bprt)","Brings the part(s) to you"},function(...)
	local args={...}
	local code=""

	for i,v in ipairs(args) do
		if i>1 then
			code=code.." "..v
		else
			code=v
		end
	end
	bringmeit=code

	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v.Name:lower()==bringmeit:lower() and v:IsA("BasePart") then
			if getChar() then v:PivotTo(getChar():GetPivot()) end
		end
	end
end)

cmd.add({"bringmodel","bmodel"},{"bringmodel {modelname} (bmodel)","Brings the model(s) to you"},function(...)
	local args={...}
	local code=""

	for i,v in ipairs(args) do
		if i>1 then
			code=code.." "..v
		else
			code=v
		end
	end

	givemethemodel=code

	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v.Name:lower()==givemethemodel:lower() and v:IsA("Model") then
			if getChar() then v:PivotTo(getChar():GetPivot()) end
		end
	end
end)

cmd.add({"gotomodel","tomodel"},{"gotomodel {modelname} (tomodel)","Teleports you to the model"},function(...)
	local args={...}
	local code=""

	for i,v in ipairs(args) do
		if i>1 then
			code=code.." "..v
		else
			code=v
		end
	end

	i_love_models=code

	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v.Name:lower()==i_love_models:lower() and v:IsA("Model") then
			if getHum() then 
				getHum().Sit=false 
				wait(.1)
			else
			end
			if getChar() then getChar():PivotTo(v:GetPivot()) end
			wait(.2);
		end
	end
end)

cmd.add({"swim"},{"swim {speed}","Swim in the air"},function(...)
	speaker=SafeGetService("Players").LocalPlayer
	SafeGetService("Workspace").Gravity=0
	if getHum() then 
		getHum():SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Running,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		getHum():ChangeState(Enum.HumanoidStateType.Swimming)
		getHum().WalkSpeed=(...) 
	end
	if (...)==nil then
		if getHum() then getHum().WalkSpeed=16 end
	end
end)

cmd.add({"unswim"},{"unswim","Stops the swim script"},function(...)
	speaker=Player
	SafeGetService("Workspace").Gravity=168
	if getHum() then 
		getHum():SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Running,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		getHum():SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		getHum():ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
		getHum().WalkSpeed=16 
	end
end)

local espParts={}
local partEspTrigger=nil
function partAdded(part)
	if #espParts>0 then
		if FindInTable(espParts,part.Name:lower()) then
			if part:IsA("BasePart") then
				local a=Instance.new("BoxHandleAdornment")
				a.Name=part.Name:lower().."_PESP"
				a.Parent=part
				a.Adornee=part
				a.AlwaysOnTop=true
				a.ZIndex=0
				a.Size=part.Size
				a.Transparency=0.45
				a.Color=BrickColor.new("Lime green")
			elseif part:IsA("Model") then
				local a=Instance.new("BoxHandleAdornment")
				a.Name=part.Name:lower().."_PESP"
				a.Parent=part
				a.Adornee=part
				a.AlwaysOnTop=true
				a.ZIndex=0
				a.Transparency=0.40
			else
			end
		end
	else
		if partEspTrigger then partEspTrigger:Disconnect() partEspTrigger=nil end
	end
end


cmd.add({"esppart","partesp","pesp"},{"esppart {partname} (partesp,pesp)","Makes you be able to see any part"},function(...)
	local args={...}
	local code=""

	for i,v in ipairs(args) do
		if i>1 then
			code=code.." "..v
		else
			code=v
		end
	end

	local partEspName=code:lower()
	if not FindInTable(espParts,partEspName) then
		table.insert(espParts,partEspName)
		for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if v:IsA("BasePart") and v.Name:lower()==partEspName then
				local a=Instance.new("BoxHandleAdornment")
				a.Name=partEspName.."_PESP"
				a.Parent=v
				a.Adornee=v
				a.AlwaysOnTop=true
				a.ZIndex=0
				a.Size=v.Size
				a.Transparency=0.45
				a.Color=BrickColor.new("Lime green")
			elseif v:IsA("Model") and v.Name:lower()==partEspName then
				local a=Instance.new("BoxHandleAdornment")
				a.Name=partEspName.."_PESP"
				a.Parent=v
				a.Adornee=v
				a.AlwaysOnTop=true
				a.ZIndex=0
				a.Transparency=0.25
			end
		end
	end
	if partEspTrigger==nil then
		partEspTrigger=SafeGetService("Workspace").DescendantAdded:Connect(partAdded)
	end
end)

cmd.add({"unesppart","unpartesp","unpesp"},{"unesppart (unpartesp,unpesp)","Removes the esp from the parts"},function()
	if partEspTrigger then partEspTrigger:Disconnect() partEspTrigger=nil end
	espParts={}
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("BoxHandleAdornment") and v.Name:sub(-5)=='_PESP' then
			v:Destroy()
		end
	end
end)

cmd.add({"viewpart","viewp","vpart"},{"viewpart {partname} (viewp,vpart)","Views a part"},function(...)
	local table={...}
	local args=''
	for i,v in pairs(table) do
		if i~=1 then
			h=h.." "..v
			args=h
		else
			args=v
		end
	end

	for _,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		local lwr=v.Name:lower()
		if lwr==args:lower() then
			if v:IsA("BasePart") then
				wait(0.1)
				SafeGetService("Workspace").CurrentCamera.CameraSubject=v
			elseif v:IsA("Model") or v:IsA("Folder") then
				for _,j in ipairs(v:GetDescendants()) do
					if j:IsA("BasePart") then
						wait(0.1)
						SafeGetService("Workspace").CurrentCamera.CameraSubject=j
						break
					end
				end
			end
		end
	end
end)

cmd.add({"unviewpart","unviewp"},{"unviewpart (unviewp)","Unviews the part"},function()
	local cam=SafeGetService("Workspace").CurrentCamera
	cam.CameraSubject=getHum()
end)

cmd.add({"console"},{"console","Opens developer console"},function()
	SafeGetService("StarterGui"):SetCore("DevConsoleVisible",true)
end)

local loophitbox=false

cmd.add({"hitbox","hbox"},{"hitbox {amount}","Makes everyones hitbox as much as you want"},function(h,d)

	if loophitbox==true then
		loophitbox=false
	end
	Username=h
	Plr=getPlr(h)

	wait();

	DoNotif("Hitbox changed")
	_G.HeadSize=d
	_G.Disabled=true

	if _G.HeadSize==nil then
		_G.HeadSize=10
	end

	loophitbox=true

	if Username=="all" or Username=="others" then
		SafeGetService("RunService").Stepped:Connect(function()
			if loophitbox then
				for i,v in next,SafeGetService('Players'):GetPlayers() do
					if v.Name~=SafeGetService('Players').LocalPlayer.Name then
						getRoot(v.Character).Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
						getRoot(v.Character).Transparency=0.9
						getRoot(v.Character).BrickColor=BrickColor.new("Really black")
						getRoot(v.Character).Material="Neon"
						getRoot(v.Character).CanCollide=false
					end
				end
			end
		end)
	else
		SafeGetService("RunService").Stepped:Connect(function()
			if loophitbox then
				getRoot(Plr.Character).Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
				getRoot(Plr.Character).Transparency=0.7
				getRoot(Plr.Character).BrickColor=BrickColor.new("Really black")
				getRoot(Plr.Character).Material="Neon"
				getRoot(Plr.Character).CanCollide=false

			end
		end)
	end
end)


cmd.add({"unhitbox","unhbox"},{"unhitbox","Disables hitbox"},function(h)
	Username=h
	Plr=getPlr(h)

	_G.HeadSize=5
	_G.Disabled=false

	loophitbox=false

	if Username=="all" or Username=="others" then
		for i,v in next,SafeGetService('Players'):GetPlayers() do
			if v.Name~=SafeGetService('Players').LocalPlayer.Name then
				getRoot(v.Character).Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
				getRoot(v.Character).Transparency=1
				getRoot(v.Character).BrickColor=BrickColor.new("Really black")
				getRoot(v.Character).Material="Neon"
				getRoot(v.Character).CanCollide=false
			end
		end
	else
		getRoot(Plr.Character).Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
		getRoot(Plr.Character).Transparency=1
		getRoot(Plr.Character).BrickColor=BrickColor.new("Really black")
		getRoot(Plr.Character).Material="Neon"
		getRoot(Plr.Character).CanCollide=false
	end
end)

cmd.add({"breakcars","bcars"},{"breakcars (bcars)","Breaks any car"},function()



	wait();

	DoNotif("Car breaker loaded,sit on a vehicle need to be the driver")
	local UserInputService=SafeGetService("UserInputService")
	local Mouse=SafeGetService("Players").LocalPlayer:GetMouse()
	local Folder=Instance.new("Folder",SafeGetService("Workspace"))
	local Part=Instance.new("Part",Folder)
	local Attachment1=Instance.new("Attachment",Part)
	Part.Anchored=true
	Part.CanCollide=false
	Part.Transparency=1
	local Updated=Mouse.Hit+Vector3.new(0,5,0)
	local NetworkAccess=coroutine.create(function()
		settings().Physics.AllowSleep=false
		while RunService.RenderStepped:Wait() do
			for _,Players in next,SafeGetService("Players"):GetPlayers() do
				if Players~=SafeGetService("Players").LocalPlayer then
					Players.MaximumSimulationRadius=0 
					sethiddenproperty(Players,"SimulationRadius",0) 
				end 
			end
			SafeGetService("Players").LocalPlayer.MaximumSimulationRadius=math.pow(math.huge,math.huge)
			setsimulationradius(math.huge) 
		end 
	end) 
	coroutine.resume(NetworkAccess)
	function ForcePart(v)
		if v:IsA("Part") and v.Anchored==false and v.Parent:FindFirstChild("Humanoid")==nil and v.Parent:FindFirstChild("Head")==nil and v.Name~="Handle" then
			Mouse.TargetFilter=v
			for _,x in next,v:GetChildren() do
				if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
					x:Destroy()
				end
			end
			if v:FindFirstChild("Attachment") then
				v:FindFirstChild("Attachment"):Destroy()
			end
			if v:FindFirstChild("AlignPosition") then
				v:FindFirstChild("AlignPosition"):Destroy()
			end
			if v:FindFirstChild("Torque") then
				v:FindFirstChild("Torque"):Destroy()
			end
			v.CanCollide=false
			local Torque=Instance.new("Torque",v)
			Torque.Torque=Vector3.new(100000,100000,100000)
			local AlignPosition=Instance.new("AlignPosition",v)
			local Attachment2=Instance.new("Attachment",v)
			Torque.Attachment0=Attachment2
			AlignPosition.MaxForce=9999999999999999
			AlignPosition.MaxVelocity=math.huge
			AlignPosition.Responsiveness=200
			AlignPosition.Attachment0=Attachment2 
			AlignPosition.Attachment1=Attachment1
		end
	end
	for _,v in next,SafeGetService("Workspace"):GetDescendants() do
		ForcePart(v)
	end
	SafeGetService("Workspace").DescendantAdded:Connect(function(v)
		ForcePart(v)
	end)
	UserInputService.InputBegan:Connect(function(Key,Chat)
		if Key.KeyCode==Enum.KeyCode.E and not Chat then
			Updated=Mouse.Hit+Vector3.new(0,5,0)
		end
	end)
	spawn(function()
		while RunService.RenderStepped:Wait() do
			Attachment1.WorldCFrame=Updated
		end
	end)
end)

cmd.add({"firetouchinterests","fti"},{"firetouchinterests (fti)","Fires every Touch Interest that's in workspace"},function()
	local ftiamount=0

	for _,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("TouchTransmitter") then
			ftiamount=ftiamount+1
			firetouchinterest(getRoot(getChar()),v.Parent,0)--0 is touch
			task.wait();
			firetouchinterest(getRoot(getChar()),v.Parent,1)--1 is untouch
		end
	end

	wait();

	DoNotif("Fired "..ftiamount.." amount of touch interests")
end)

local infJump=nil
local jumpFixy=nil

cmd.add({"infjump","infinitejump"},{"infjump (infinitejump)","Makes you be able to jump infinitly"},function()

	wait();

	DoNotif("Infinite Jump Enabled")

	local r=0
	local d=0.25

	function fix()
		if infJump then infJump:Disconnect() infJump=nil end
		infJump=getHum():GetPropertyChangedSignal("Jump"):Connect(function()
			if tick()-r>d then
				r=tick()
				getHum():ChangeState("Jumping")
			end
		end)
	end

	fix()

	if jumpFixy then jumpFixy:Disconnect() jumpFixy=nil end
	jumpFixy=plr.CharacterAdded:Connect(fix)
end)

cmd.add({"uninfjump","uninfinitejump"},{"uninfjump (uninfinitejump)","Makes you NOT be able to infinitly jump"},function()
	wait();

	DoNotif("Infinite Jump Disabled",3)

	if infJump then infJump:Disconnect() infJump=nil end
	if jumpFixy then jumpFixy:Disconnect() jumpFixy=nil end
end)

local flyjump=nil

cmd.add({"flyjump"},{"flyjump","Allows you to hold space to fly up"},function()

	wait();

	DoNotif("FlyJump Enabled",3)


	if flyjump then flyjump:Disconnect() end
	flyjump=UserInputService.JumpRequest:Connect(function()
		Player.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end)
end)

cmd.add({"unflyjump","noflyjump"},{"unflyjump (noflyjump)","Disables flyjump"},function()

	wait();

	DoNotif("FlyJump Disabled",3)


	if flyjump then flyjump:Disconnect() end
end)

cmd.add({"xray","xrayon"},{"xray (xrayon)","Makes you be able to see through walls"},function()



	wait();

	DoNotif("Xray enabled")
	transparent=true
	x(transparent)
end)

cmd.add({"unxray","xrayoff"},{"unxray (xrayoff)","Makes you not be able to see through walls"},function()



	wait();

	DoNotif("Xray disabled")
	transparent=false
	x(transparent)
end)

cmd.add({"pastebinscraper","pastebinscrape"},{"pastebinscraper (pastebinscrape)","Scrapes paste bin posts"},function()



	wait();

	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/trash(paste)bin%20scrapper"))()
	SafeGetService("CoreGui").Scraper["Pastebin Scraper"].BackgroundTransparency=0.5
	SafeGetService("CoreGui").Scraper["Pastebin Scraper"].TextButton.Text="             ⭐ Pastebin Post Scraper ⭐"
	SafeGetService("CoreGui").Scraper["Pastebin Scraper"].Content.Search.PlaceholderText="Search for a post here..."
	SafeGetService("CoreGui").Scraper["Pastebin Scraper"].Content.Search.BackgroundTransparency=0.4
	DoNotif("Pastebin scraper loaded")
end)

cmd.add({"amongus","amogus"},{"amongus (amogus)","among us in real life,sus sus."},function()

	wait();

	DoNotif("Amog us...")
	loadstring(game:HttpGet(('https://pastefy.ga/aMY1wxRS/raw'),true))()
end)

cmd.add({"blackhole"},{"blackhole","Makes unanchored parts teleport to the black hole"},function()
	local UserInputService=SafeGetService("UserInputService")
	local Mouse=SafeGetService("Players").LocalPlayer:GetMouse()
	local Folder=Instance.new("Folder",SafeGetService("Workspace"))
	local Part=Instance.new("Part",Folder)
	local Attachment1=Instance.new("Attachment",Part)
	Part.Anchored=true
	Part.CanCollide=false
	Part.Transparency=1
	local Updated=Mouse.Hit+Vector3.new(0,5,0)
	local NetworkAccess=coroutine.create(function()
		settings().Physics.AllowSleep=false
		while RunService.RenderStepped:Wait() do
			for _,Players in next,SafeGetService("Players"):GetPlayers() do
				if Players~=SafeGetService("Players").LocalPlayer then
					Players.MaximumSimulationRadius=0 
					sethiddenproperty(Players,"SimulationRadius",0) 
				end 
			end
			SafeGetService("Players").LocalPlayer.MaximumSimulationRadius=math.pow(math.huge,math.huge)
		end 
	end) 
	coroutine.resume(NetworkAccess)
	function ForcePart(v)
		if v:IsA("Part") and v.Anchored==false and v.Parent:FindFirstChild("Humanoid")==nil and v.Parent:FindFirstChild("Head")==nil and v.Name~="Handle" then
			Mouse.TargetFilter=v
			for _,x in next,v:GetChildren() do
				if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
					x:Destroy()
				end
			end
			if v:FindFirstChild("Attachment") then
				v:FindFirstChild("Attachment"):Destroy()
			end
			if v:FindFirstChild("AlignPosition") then
				v:FindFirstChild("AlignPosition"):Destroy()
			end
			if v:FindFirstChild("Torque") then
				v:FindFirstChild("Torque"):Destroy()
			end
			v.CanCollide=false
			local Torque=Instance.new("Torque",v)
			Torque.Torque=Vector3.new(100000,100000,100000)
			local AlignPosition=Instance.new("AlignPosition",v)
			local Attachment2=Instance.new("Attachment",v)
			Torque.Attachment0=Attachment2
			AlignPosition.MaxForce=9999999999999999
			AlignPosition.MaxVelocity=math.huge
			AlignPosition.Responsiveness=200
			AlignPosition.Attachment0=Attachment2 
			AlignPosition.Attachment1=Attachment1
		end
	end
	for _,v in next,SafeGetService("Workspace"):GetDescendants() do
		ForcePart(v)
	end
	SafeGetService("Workspace").DescendantAdded:Connect(function(v)
		ForcePart(v)
	end)
	UserInputService.InputBegan:Connect(function(Key,Chat)
		if Key.KeyCode==Enum.KeyCode.E and not Chat then
			Updated=Mouse.Hit+Vector3.new(0,5,0)
		end
	end)
	spawn(function()
		while RunService.RenderStepped:Wait() do
			Attachment1.WorldCFrame=Updated
		end
	end)



	wait();

	DoNotif("Blackhole has been loaded,press e to change the position to where your mouse is")
end)

cmd.add({"fullbright","fullb","fb"},{"fullbright (fullb,fb)","Makes games that are really dark to have no darkness and be really light"},function()
	if not _G.FullBrightExecuted then

		_G.FullBrightEnabled=false

		_G.NormalLightingSettings={
			Brightness=SafeGetService("Lighting").Brightness,
			ClockTime=SafeGetService("Lighting").ClockTime,
			FogEnd=SafeGetService("Lighting").FogEnd,
			GlobalShadows=SafeGetService("Lighting").GlobalShadows,
			Ambient=SafeGetService("Lighting").Ambient
		}

		SafeGetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
			if SafeGetService("Lighting").Brightness~=1 and SafeGetService("Lighting").Brightness~=_G.NormalLightingSettings.Brightness then
				_G.NormalLightingSettings.Brightness=SafeGetService("Lighting").Brightness
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				SafeGetService("Lighting").Brightness=1
			end
		end)

		SafeGetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
			if SafeGetService("Lighting").ClockTime~=12 and SafeGetService("Lighting").ClockTime~=_G.NormalLightingSettings.ClockTime then
				_G.NormalLightingSettings.ClockTime=SafeGetService("Lighting").ClockTime
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				SafeGetService("Lighting").ClockTime=12
			end
		end)

		SafeGetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
			if SafeGetService("Lighting").FogEnd~=786543 and SafeGetService("Lighting").FogEnd~=_G.NormalLightingSettings.FogEnd then
				_G.NormalLightingSettings.FogEnd=SafeGetService("Lighting").FogEnd
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				SafeGetService("Lighting").FogEnd=786543
			end
		end)

		SafeGetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
			if SafeGetService("Lighting").GlobalShadows~=false and SafeGetService("Lighting").GlobalShadows~=_G.NormalLightingSettings.GlobalShadows then
				_G.NormalLightingSettings.GlobalShadows=SafeGetService("Lighting").GlobalShadows
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				SafeGetService("Lighting").GlobalShadows=false
			end
		end)

		SafeGetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
			if SafeGetService("Lighting").Ambient~=Color3.fromRGB(178,178,178) and SafeGetService("Lighting").Ambient~=_G.NormalLightingSettings.Ambient then
				_G.NormalLightingSettings.Ambient=SafeGetService("Lighting").Ambient
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				SafeGetService("Lighting").Ambient=Color3.fromRGB(178,178,178)
			end
		end)

		SafeGetService("Lighting").Brightness=1
		SafeGetService("Lighting").ClockTime=12
		SafeGetService("Lighting").FogEnd=786543
		SafeGetService("Lighting").GlobalShadows=false
		SafeGetService("Lighting").Ambient=Color3.fromRGB(178,178,178)

		local LatestValue=true
		spawn(function()
			repeat
				wait()
			until _G.FullBrightEnabled
			while wait() do
				if _G.FullBrightEnabled~=LatestValue then
					if not _G.FullBrightEnabled then
						SafeGetService("Lighting").Brightness=_G.NormalLightingSettings.Brightness
						SafeGetService("Lighting").ClockTime=_G.NormalLightingSettings.ClockTime
						SafeGetService("Lighting").FogEnd=_G.NormalLightingSettings.FogEnd
						SafeGetService("Lighting").GlobalShadows=_G.NormalLightingSettings.GlobalShadows
						SafeGetService("Lighting").Ambient=_G.NormalLightingSettings.Ambient
					else
						SafeGetService("Lighting").Brightness=1
						SafeGetService("Lighting").ClockTime=12
						SafeGetService("Lighting").FogEnd=786543
						SafeGetService("Lighting").GlobalShadows=false
						SafeGetService("Lighting").Ambient=Color3.fromRGB(178,178,178)
					end
					LatestValue=not LatestValue
				end
			end
		end)
	end

	_G.FullBrightExecuted=true
	_G.FullBrightEnabled=not _G.FullBrightEnabled
end)

local dayCon=nil

cmd.add({"loopday","lday"},{"loopday (lday)","Sunshiiiine!"},function()
	if dayCon then
		dayCon:Disconnect()
	end
	
	SafeGetService("Lighting").ClockTime = 14
		
	dayCon=SafeGetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
		SafeGetService("Lighting").ClockTime=14
	end)
end)

cmd.add({"unloopday","unlday"},{"unloopday (unlday)","No more sunshine"},function()
	if dayCon then
		dayCon:Disconnect()
	end
end)

fbCon,fbCon1,fbCon2,fbCon3,fbCon4=nil,nil,nil,nil,nil

cmd.add({"loopfullbright","loopfb","lfb"},{"loopfullbright (loopfb,lfb)","Sunshiiiine!"},function()
	if fbCon then
		fbCon:Disconnect()
	end
	if fbCon1 then
		fbCon1:Disconnect()
	end
	if fbCon2 then
		fbCon2:Disconnect()
	end
	if fbCon3 then
		fbCon3:Disconnect()
	end
	if fbCon4 then
		fbCon4:Disconnect()
	end
	
	SafeGetService("Lighting").Brightness=1
	SafeGetService("Lighting").ClockTime=12
	SafeGetService("Lighting").FogEnd=786543
	SafeGetService("Lighting").GlobalShadows=false
	SafeGetService("Lighting").Ambient=Color3.fromRGB(178,178,178)

	fbCon=SafeGetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
		SafeGetService("Lighting").Brightness=1
	end)
	fbCon1=SafeGetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
		SafeGetService("Lighting").ClockTime=12
	end)
	fbCon2=SafeGetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
		SafeGetService("Lighting").FogEnd=786543
	end)
	fbCon3=SafeGetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
		SafeGetService("Lighting").GlobalShadows=false
	end)
	fbCon4=SafeGetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
		SafeGetService("Lighting").Ambient=Color3.fromRGB(178,178,178)
	end)
end)

cmd.add({"unloopfullbright","unloopfb","unlfb"},{"unloopfullbright (unloopfb,unlfb)","No more sunshine"},function()
	if fbCon then
		fbCon:Disconnect()
	end
	if fbCon1 then
		fbCon1:Disconnect()
	end
	if fbCon2 then
		fbCon2:Disconnect()
	end
	if fbCon3 then
		fbCon3:Disconnect()
	end
	if fbCon4 then
		fbCon4:Disconnect()
	end
end)


nightCon,nightCon1,nightCon2,nightCon3,nightCon4=nil,nil,nil,nil,nil

cmd.add({"loopnight","loopn","ln"},{"loopnight (loopn,ln)","Moonlight."},function()
	if nightCon then
		nightCon:Disconnect()
	end
	if nightCon1 then
		nightCon1:Disconnect()
	end
	if nightCon2 then
		nightCon2:Disconnect()
	end
	if nightCon3 then
		nightCon3:Disconnect()
	end
	if nightCon4 then
		nightCon4:Disconnect()
	end
	
	SafeGetService("Lighting").Brightness=1
	SafeGetService("Lighting").ClockTime=0
	SafeGetService("Lighting").FogEnd=786543
	SafeGetService("Lighting").GlobalShadows=false
	SafeGetService("Lighting").Ambient=Color3.fromRGB(178,178,178)
		
	nightCon=SafeGetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
		SafeGetService("Lighting").Brightness=1
	end)
	nightCon1=SafeGetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
		SafeGetService("Lighting").ClockTime=0
	end)
	nightCon2=SafeGetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
		SafeGetService("Lighting").FogEnd=786543
	end)
	nightCon3=SafeGetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
		SafeGetService("Lighting").GlobalShadows=false
	end)
	nightCon4=SafeGetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
		SafeGetService("Lighting").Ambient=Color3.fromRGB(178,178,178)
	end)
end)

cmd.add({"unloopnight","unloopn","unln"},{"unloopnight (unloopn,unln)","No more moonlight."},function()
	if nightCon then
		nightCon:Disconnect()
	end
	if nightCon1 then
		nightCon1:Disconnect()
	end
	if nightCon2 then
		nightCon2:Disconnect()
	end
	if nightCon3 then
		nightCon3:Disconnect()
	end
	if nightCon4 then
		nightCon4:Disconnect()
	end
end)

fogLoop=nil
fogCon=nil

cmd.add({"loopnofog","lnofog","lnf", "loopnf"},{"loopnofog (lnofog,lnf,loopnf)","See clearly forever!"},function()
	local Lighting=SafeGetService("Lighting")
	if fogLoop then
		fogLoop:Disconnect()
	end
	if fogCon then
		fogCon:Disconnect()
	end
	Lighting.FogEnd=786543
	local function fogFunc()
		for i,v in pairs(Lighting:GetDescendants()) do
			if v:IsA("Atmosphere") then
				v:Destroy()
			end
		end
	end
	fogCon=Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
		Lighting.FogEnd=786543
	end)

	fogLoop = RunService.RenderStepped:Connect(fogFunc)
end)

cmd.add({"unloopnofog","unlnofog","unlnf","unloopnf"},{"unloopnofog (unlnofog,unlnf,unloopnf)","No more sight."},function()
	if fogLoop then
		fogLoop:Disconnect()
	end
	if fogCon then
		fogCon:Disconnect()
	end
end)

cmd.add({"brightness"},{"brightness","Changes the brightness lighting property"},function(...)
	Lighting.Brightness=(...)
end)

cmd.add({"globalshadows","gshadows"},{"globalshadows (gshadows)","Enables global shadows"},function()
	Lighting.GlobalShadows=true
end)

cmd.add({"unglobalshadows","nogshadows","ungshadows","noglobalshadows"},{"unglobalshadows (nogshadows,ungshadows,noglobalshadows)","Disables global shadows"},function()
	Lighting.GlobalShadows=false
end)

cmd.add({"givehat","givehatui"},{"givehat (givehatui)","Executes a hat giver gui check in console for hat names"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Gimme%20That%20Hat"))()
end)

cmd.add({"fireproximityprompts","fpp","firepp"},{"fireproximityprompts (fpp,firepp)","Fires every Proximity Prompt that's in workspace"},function(...)
	fppamount=0
	local fppname=(...)
	if fppname then
		local name=fppname
		for _,firedapp in ipairs(SafeGetService("Workspace"):GetDescendants()) do
			if firedapp:IsA("ProximityPrompt") and firedapp.Name:lower()==name:lower() or firedapp:IsA("ProximityPrompt") and descandant.Parent.Name:lower()==name:lower() then
				fppamount=fppamount+1
				fireproximityprompt(firedapp,1)
			end
		end
	else
		for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if v:IsA("ProximityPrompt") then
				fppamount=fppamount+1
				fireproximityprompt(v,1)
			end
		end
	end


	wait();

	DoNotif("Fired "..fppamount.." of proximity prompts")
end)

cmd.add({"iy"},{"iy {command}","Executes infinite yield scripts"},function(...)
	if IYLOADED==false then
		function copytable(tbl) local copy={} for i,v in pairs(tbl) do copy[i]=v end return copy end
		local sandbox_env=copytable(getfenv())
		setmetatable(sandbox_env,{
			__index=function(self,i)
				if rawget(sandbox_env,i) then
					return rawget(sandbox_env,i)
				elseif getfenv()[i] then
					return getfenv()[i]
				end
			end
		})
		sandbox_env.game=nil
		iy,_=game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"):gsub("local Main","Main"):gsub("Players.LocalPlayer.Chatted","Funny=Players.LocalPlayer.Chatted"):gsub("local lastMessage","notify=_G.notify\nlocal lastMessage")
		setfenv(loadstring(iy),sandbox_env)()
		iy_cmds_table=sandbox_env.CMDs
		iy_gui=sandbox_env.Main
		iy_chathandler=sandbox_env.Funny
		execCmd=sandbox_env.execCmd
		iy_gui:Destroy()
		pcall(function()
			iy_chathandler:Disconnect()
		end)
		IYLOADED=true
	end
	execCmd((...))
end)

cmd.add({"chatspy"},{"chatspy","Spies on chat,enables chat,spies whispers etc."},function()



	wait();

	DoNotif("Chat spy enabled")
	--This script reveals ALL hidden messages in the default chat
	--chat "/spy" to toggle!
	enabled=true
	--if true will check your messages too
	spyOnMyself=false
	--if true will chat the logs publicly (fun,risky)
	public=false
	--if true will use /me to stand out
	publicItalics=true
	--customize private logs
	privateProperties={
		Color=Color3.fromRGB(0,255,255); 
		Font=Enum.Font.SourceSansBold;
		TextSize=18;
	}
	--////////////////////////////////////////////////////////////////
	local StarterGui=SafeGetService("StarterGui")
	local Players=SafeGetService("Players")
	local player=Players.LocalPlayer
	local saymsg=SafeGetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
	local getmsg=SafeGetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
	local instance=(_G.chatSpyInstance or 0)+1
	_G.chatSpyInstance=instance

	function onChatted(p,msg)
		if _G.chatSpyInstance==instance then
			if p==player and msg:lower():sub(1,4)=="/spy" then
				enabled=not enabled
				wait(0.3)
				print("XD")
				StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
			elseif enabled and (spyOnMyself==true or p~=player) then
				msg=msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
				local hidden=true
				local conn=getmsg.OnClientEvent:Connect(function(packet,channel)
					if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and Players[packet.FromSpeaker].Team==player.Team)) then
						hidden=false
					end
				end)
				wait(1)
				conn:Disconnect()
				if hidden and enabled then
					if public then
						saymsg:FireServer((publicItalics and "/me " or '').."{SPY} [".. p.Name .."]: "..msg,"All")
					else
						privateProperties.Text="{SPY} [".. p.Name .."]: "..msg
						StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
					end
				end
			end
		end
	end

	for _,p in ipairs(Players:GetPlayers()) do
		p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	end
	Players.PlayerAdded:Connect(function(p)
		p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	end)
	print("XD")
	StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
	local chatFrame=player.PlayerGui.Chat.Frame
	chatFrame.ChatChannelParentFrame.Visible=true
	chatFrame.ChatBarParentFrame.Position=chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
end)


cmd.add({"bhop"},{"bhop","bhop bhop bhop bhop bhop bhop bhop bla bla bla idk what im saying"},function()
	--[[ bhop functions ]]--
	local player
	local character
	local collider
	local camera
	local input
	local collider
	local playerGrounded
	local playerVelocity
	local jumping
	local moveInputSum
	local dt=1/60
	local partYRatio
	local partZRatio
	local cameraYaw
	local cameraLook
	local movementPosition
	local movementVelocity
	local gravityForce
	local airAccelerate
	local airMaxSpeed
	local groundAccelerate
	local groundMaxVelocity
	local friction
	local playerTorsoToGround
	local movementStickDistance
	local jumpVelocity
	local movementPositionForce
	local movementVelocityForce
	local maxMovementPitch
	local rayYLength
	local movementPositionD
	local movementPositionP
	local movementVelocityP
	local gravity



	function init(Player,Camera,Input)
		player=Player
		character=player.Character
		collider=getRoot(character)
		camera=Camera
		input=Input
		playerVelocity=0
		playerGrounded=false
		moveInputSum={
			["forward"]=0,
			["side"] 	=0--left is positive
		}

		airAccelerate 			=10000
		airMaxSpeed 			=2.4
		groundAccelerate 		=250
		groundMaxVelocity 		=20
		friction			 	=10
		playerTorsoToGround 	=3
		movementStickDistance 	=0.5
		jumpVelocity 			=52.5
		movementPositionForce	=400000
		movementVelocityForce	=300000
		maxMovementPitch		=0.6
		rayYLength				=playerTorsoToGround+movementStickDistance
		movementPositionD		=125
		movementPositionP		=14000
		movementVelocityP		=1500
		gravity					=0.4

	end

	function initBodyMovers()
		movementPosition=Instance.new("BodyPosition",collider)
		movementPosition.Name="movementPosition"
		movementPosition.D=movementPositionD
		movementPosition.P=movementPositionP
		movementPosition.maxForce=Vector3.new()
		movementPosition.position=Vector3.new()

		movementVelocity=Instance.new("BodyVelocity",collider)
		movementVelocity.Name="movementVelocity"
		movementVelocity.P=movementVelocityP
		movementVelocity.maxForce=Vector3.new()
		movementVelocity.velocity=Vector3.new()

		gravityForce=Instance.new("BodyForce",collider)
		gravityForce.Name="gravityForce"
		gravityForce.force=Vector3.new(0,(1-gravity)*196.2,0)*getCharacterMass()
	end

	function update(deltaTime)
		dt=deltaTime
		updateMoveInputSum()
		cameraYaw=getYaw()
		cameraLook=cameraYaw.lookVector	
		if cameraLook==nil then
			return
		end
		local hitPart,hitPosition,hitNormal,yRatio,zRatio=findCollisionRay()
		partYRatio=yRatio
		partZRatio=zRatio

		playerGrounded=hitPart~=nil and true or false
		playerVelocity=collider.Velocity-Vector3.new(0,collider.Velocity.y,0)
		if playerGrounded and (input["Space"] or jumping) then
			jumping=true
		else
			jumping=false
		end

		setCharacterRotation()
		if jumping then
			jump()
		elseif playerGrounded then
			run(hitPosition)
		else
			air()		
		end

	end

	function updateMoveInputSum()
		moveInputSum["forward"]=input["W"]==true and 1 or 0
		moveInputSum["forward"]=input["S"]==true and moveInputSum["forward"]-1 or moveInputSum["forward"]
		moveInputSum["side"]=input["A"]==true and 1 or 0
		moveInputSum["side"]=input["D"]==true and moveInputSum["side"]-1 or moveInputSum["side"]
	end

	function findCollisionRay()
		local torsoCFrame=getRoot(character).CFrame
		local ignoreList={character,camera}
		local rays={
			Ray.new(getRoot(character).Position,Vector3.new(0,-rayYLength,0)),
			Ray.new((torsoCFrame*CFrame.new(-0.8,0,0)).p,Vector3.new(0,-rayYLength,0)),
			Ray.new((torsoCFrame*CFrame.new(0.8,0,0)).p,Vector3.new(0,-rayYLength,0)),
			Ray.new((torsoCFrame*CFrame.new(0,0,0.8)).p,Vector3.new(0,-rayYLength,0)),
			Ray.new((torsoCFrame*CFrame.new(0,0,-0.8)).p,Vector3.new(0,-rayYLength,0))
		}
		local rayReturns={}

		local i
		for i=1,#rays do
			local part,position,normal=SafeGetService("Workspace"):FindPartOnRayWithIgnoreList(rays[i],ignoreList)
			if part==nil then
				position=Vector3.new(0,-3000000,0)
			end
			if i==1 then
				table.insert(rayReturns,{part,position,normal})
			else
				local yPos=position.y
				if yPos <=rayReturns[#rayReturns][2].y then
					table.insert(rayReturns,{part,position,normal})
				else 
					local j
					for j=1,#rayReturns do
						if yPos >=rayReturns[j][2].y then
							table.insert(rayReturns,j,{part,position,normal})
						end
					end
				end
			end
		end

		i=1
		local yRatio,zRatio=getPartYRatio(rayReturns[i][3])
		while magnitude2D(yRatio,zRatio)>maxMovementPitch and i<#rayReturns do
			i=i+1
			if rayReturns[i][1] then
				yRatio,zRatio=getPartYRatio(rayReturns[i][3])
			end
		end

		return rayReturns[i][1],rayReturns[i][2],rayReturns[i][3],yRatio,zRatio
	end

	function setCharacterRotation()
		local rotationLook=collider.Position+camera.CoordinateFrame.lookVector
		collider.CFrame=CFrame.new(collider.Position,Vector3.new(rotationLook.x,collider.Position.y,rotationLook.z))
		collider.RotVelocity=Vector3.new()
	end

	function jump()
		collider.Velocity=Vector3.new(collider.Velocity.x,jumpVelocity,collider.Velocity.z)
		air()
	end

	function air()
		movementPosition.maxForce=Vector3.new()
		movementVelocity.velocity=getMovementVelocity(collider.Velocity,airAccelerate,airMaxSpeed)
		movementVelocity.maxForce=getMovementVelocityAirForce()
	end

	function run(hitPosition)
		local playerSpeed=collider.Velocity.magnitude
		local mVelocity=collider.Velocity

		if playerSpeed~=0 then
			local drop=playerSpeed*friction*dt;
			mVelocity=mVelocity*math.max(playerSpeed-drop,0) / playerSpeed;
		end

		movementPosition.position=hitPosition+Vector3.new(0,playerTorsoToGround,0)
		movementPosition.maxForce=Vector3.new(0,movementPositionForce,0)
		movementVelocity.velocity=getMovementVelocity(mVelocity,groundAccelerate,groundMaxVelocity)
		local VelocityForce=getMovementVelocityForce()
		movementVelocity.maxForce=VelocityForce
		movementVelocity.P=movementVelocityP
	end

	function getMovementVelocity(prevVelocity,accelerate,maxVelocity)
		local accelForward=cameraLook*moveInputSum["forward"]
		local accelSide=(cameraYaw*CFrame.Angles(0,math.rad(90),0)).lookVector*moveInputSum["side"];
		local accelDir=(accelForward+accelSide).unit;
		if moveInputSum["forward"]==0 and moveInputSum["side"]==0 then--avoids divide 0 errors
			accelDir=Vector3.new(0,0,0);
		end

		local projVel=prevVelocity:Dot(accelDir);
		local accelVel=accelerate*dt;

		if (projVel+accelVel>maxVelocity) then
			accelVel=math.max(maxVelocity-projVel,0);
		end

		return prevVelocity+accelDir*accelVel;
	end

	function getMovementVelocityForce()

		return Vector3.new(movementVelocityForce,0,movementVelocityForce)
	end

	function getMovementVelocityAirForce()
		local accelForward=cameraLook*moveInputSum["forward"];
		local accelSide=(cameraYaw*CFrame.Angles(0,math.rad(90),0)).lookVector*moveInputSum["side"]
		local accelDir=(accelForward+accelSide).unit
		if moveInputSum["forward"]==0 and moveInputSum["side"]==0 then
			accelDir=Vector3.new(0,0,0);
		end

		local xp=math.abs(accelDir.x)
		local zp=math.abs(accelDir.z)

		return Vector3.new(movementVelocityForce*xp,0,movementVelocityForce*zp)
	end

	function getPartYRatio(normal)
		local partYawVector=Vector3.new(-normal.x,0,-normal.z)
		if partYawVector.magnitude==0 then
			return 0,0
		else
			local partPitch=math.atan2(partYawVector.magnitude,normal.y)/(math.pi/2)
			local vector=Vector3.new(cameraLook.x,0,cameraLook.z)*partPitch
			return vector:Dot(partYawVector),-partYawVector:Cross(vector).y
		end	
	end

	function getYaw()--returns CFrame
		return camera.CoordinateFrame*CFrame.Angles(-getPitch(),0,0)
	end

	function getPitch()--returns number
		return math.pi/2-math.acos(camera.CoordinateFrame.lookVector:Dot(Vector3.new(0,1,0)))
	end

	function getCharacterMass()
		return getRoot(character):GetMass()+character.Head:GetMass()
	end

	function magnitude2D(x,z)
		return math.sqrt(x*x+z*z)
	end

	local inputKeys={
		["W"]=false,
		["S"]=false,
		["A"]=false,
		["D"]=false,
		["Space"]=false,
		["LMB"]=false,
		["RMB"]=false
	}

	local plr=SafeGetService("Players").LocalPlayer
	local camera=SafeGetService("Workspace").CurrentCamera
	local UserInputService=SafeGetService("UserInputService")
	function onInput(input,gameProcessedEvent)
		local inputState
		--print(input.KeyCode)
		if input.UserInputState==Enum.UserInputState.Begin then
			inputState=true
		elseif input.UserInputState==Enum.UserInputState.End then
			inputState=false
		else
			return
		end 

		if input.UserInputType==Enum.UserInputType.Keyboard then
			local key=input.KeyCode.Name
			if inputKeys[key]~=nil then
				inputKeys[key]=inputState
			end
		elseif input.UserInputType==Enum.UserInputType.MouseButton1 then--LMB down
			inputKeys.LMB=inputState
		elseif input.UserInputType==Enum.UserInputType.MouseButton2 then--RMB down
			inputKeys.RMB=inputState
		end
	end
	function main()
		local a=plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character:WaitForChild("Humanoid");
		a.PlatformStand=true
		--init movement
		init(plr,camera,inputKeys);
		initBodyMovers();

		--connect input
		UserInputService.InputBegan:connect(onInput);
		UserInputService.InputEnded:connect(onInput);
		--connect updateloop
		SafeGetService("RunService"):BindToRenderStep("updateLoop",1,updateLoop);

		--rip
	end

	local prevUpdateTime=nil
	local updateDT=1/60

	function setDeltaTime()--seconds
		local UpdateTime=tick() 
		if prevUpdateTime~=nil then
			updateDT=(UpdateTime-prevUpdateTime)
		else
			updateDT=1/60
		end
		prevUpdateTime=UpdateTime
	end
	function updateLoop()
		setDeltaTime();
		update(updateDT);
	end
	main()
end)

cmd.add({"firstp","1stp","firstperson","fp"},{"firstperson (1stp,firstp,fp)","Makes you go in first person mode"},function()
	Player.CameraMode="LockFirstPerson"
end)

cmd.add({"thirdp","3rdp","thirdperson"},{"thirdperson (3rdp,thirdp)","Makes you go in third person mode"},function()
	Player.CameraMaxZoomDistance=math.huge
	Player.CameraMode="Classic"
end)

cmd.add({"maxzoom"},{"maxzoom <amount>","Set your maximum camera distance"},function(...)
	local args={...}
	local num=args[1]

	if num==nil then
		num=math.huge
	else
		num=tonumber(num)
	end
	SafeGetService("Players").LocalPlayer.CameraMaxZoomDistance=num
end)

cmd.add({"minzoom"},{"minzoom <amount>","Set your minimum camera distance"},function(...)
	local args={...}
	local num=args[1]

	if num==nil then
		num=0
	else
		num=tonumber(num)
	end
	SafeGetService("Players").LocalPlayer.CameraMinZoomDistance=num
end)

cmd.add({"cameranoclip","camnoclip","cnoclip","nccam"},{"cameranoclip (camnoclip,cnoclip,nccam)","Makes your camera clip through walls"},function()
	SetConstant=(debug and debug.setconstant) or setconstant
	GetConstants=(debug and debug.getconstants) or getconstants
	if SetConstant or GetConstants or getgc then
		local Popper=SafeGetService("Players").LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
		for i,v in pairs(getgc()) do
			if type(v)=='function' and getfenv(v).script==Popper then
				for i,v1 in pairs(GetConstants(v)) do
					if tonumber(v1)==.25 then
						SetConstant(v,i,0)
					elseif tonumber(v1)==0 then
						SetConstant(v,i,.25)
					end
				end
			end
		end
	else
		wait();

		DoNotif("Sorry,your exploit does not support cameranoclip")
	end
end)

cmd.add({"uncameranoclip","uncamnoclip","uncnoclip","unnccam"},{"uncameranoclip (uncamnoclip,uncnoclip,unnccam)","Makes your camera not clip through walls"},function()
	local SetConstant=(debug and debug.setconstant) or setconstant
	local GetConstants=(debug and debug.getconstants) or getconstants
	if SetConstant or GetConstants or getgc then
		local Popper=SafeGetService("Players").LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
		for i,v in pairs(getgc()) do
			if type(v)=='function' and getfenv(v).script==Popper then
				for i,v1 in pairs(GetConstants(v)) do
					if tonumber(v1)==.25 then
						SetConstant(v,i,0)
					elseif tonumber(v1)==0 then
						SetConstant(v,i,.25)
					end
				end
			end
		end
	else
		wait();

		DoNotif("Sorry,your exploit does not support cameranoclip and uncameranoclip")
	end	
end)

cmd.add({"2016anims"},{"2016anims","2016 animations"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/2016%20anims"))()
end)

cmd.add({"oganims"},{"oganims","Old animations from 2007"},function()



	wait();

	DoNotif("OG animations set")
	loadstring(game:HttpGet(('https://pastebin.com/raw/6GNkQUu6'),true))()
end)

cmd.add({"fakechat"},{"fakechat","Fake a chat gui"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/fake%20chatte"))()
end)

cmd.add({"fpscap"},{"fpscap <number>","Sets the fps cap to whatever you want"},function(...)
	setfpscap(...)
end)

cmd.add({"holdhat"},{"holdhat","Can make you hold your hats execute the command and you will have them in your inventory"},function(...)
	--made by Nightmare#0930
	local lp=SafeGetService("Players").LocalPlayer
	local char=lp.Character

	for i,v in pairs(char:GetChildren()) do
		if v:IsA("BallSocketConstraint") then
			v:Destroy()
		end
	end

	for i,v in pairs(char:GetChildren()) do
		if v:IsA("HingeConstraint") then
			v:Destroy()
		end
	end

	for i,v in pairs(char.Humanoid:GetAccessories()) do
		local hat=v.Name

		char[hat].Archivable=true
		local fake=char[hat]:Clone()
		fake.Parent=char
		fake.Handle.Transparency=1

		local hold=false
		local enabled=false

		char[hat].Handle.AccessoryWeld:Destroy()

		local tool=Instance.new("Tool",lp.Backpack)
		tool.RequiresHandle=true
		tool.CanBeDropped=false
		tool.Name=hat

		local handle=Instance.new("Part",tool)
		handle.Name="Handle"
		handle.Size=Vector3.new(1,1,1)
		handle.Massless=true
		handle.Transparency=1

		local positions={
			forward=tool.GripForward,
			pos=tool.GripPos,
			right=tool.GripRight,
			up=tool.GripUp
		}

		tool.Equipped:connect(function()
			hold=true
		end)

		tool.Unequipped:connect(function()
			hold=false
		end)

		tool.Activated:connect(function()
			if enabled==false then
				enabled=true
				tool.GripForward=Vector3.new(-0.976,0,-0.217)
				tool.GripPos=Vector3.new(.95,-0.76,1.4)
				tool.GripRight=Vector3.new(0.217,0,0.976)
				tool.GripUp=Vector3.new(0,1,0)
				wait(.8)
				tool.GripForward=positions.forward
				tool.GripPos=positions.pos
				tool.GripRight=positions.right
				tool.GripUp=positions.up
				enabled=false
			end
		end)

		RunService.Heartbeat:connect(function()
			pcall(function()
				char[hat].Handle.Velocity=Vector3.new(30,0,0)
				if hold==false then
					char[hat].Handle.CFrame=fake.Handle.CFrame
				elseif hold==true then
					char[hat].Handle.CFrame=handle.CFrame
				end
			end)
		end)
	end
end)

cmd.add({"toolinvisible","tinvis"},{"toolinvisible (tinvis)","Be invisible while still be able to use tools"},function()
	local offset=1100
	local invisible=SafeGetService("Players").LocalPlayer
	local grips={}
	local heldTool
	local gripChanged
	local handle
	local weld
	function setDisplayDistance(distance)
		for _,player in pairs(SafeGetService("Players"):GetPlayers()) do
			if player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") then
				player.Character:FindFirstChildWhichIsA("Humanoid").NameDisplayDistance=distance
				player.Character:FindFirstChildWhichIsA("Humanoid").HealthDisplayDistance=distance
			end
		end
	end
	local tool=Instance.new("Tool",SafeGetService("Players").LocalPlayer.Backpack)
	tool.Name="Turn Invisible"
	tool.RequiresHandle=false
	tool.CanBeDropped=false
	tool.Equipped:Connect(
		function()
			wait()
			if not invisible then
				invisible=true
				tool.Name="Visible enabled"
				if handle then
					handle:Destroy()
				end
				if weld then
					weld:Destroy()
				end
				handle=Instance.new("Part",workspace)
				handle.Name="Handle"
				handle.Transparency=1
				handle.CanCollide=false
				handle.Size=Vector3.new(2,1,1)
				weld=Instance.new("Weld",handle)
				weld.Part0=handle
				weld.Part1=getRoot(getChar())
				weld.C0=CFrame.new(0,offset-1.5,0)
				setDisplayDistance(offset+100)
				SafeGetService("Workspace").CurrentCamera.CameraSubject=handle
				getRoot(getChar()).CFrame=getRoot(getChar()).CFrame*CFrame.new(0,offset,0)
				getChar().Humanoid.HipHeight=offset
				getChar().Humanoid:ChangeState(11)
				for _,child in pairs(SafeGetService("Players").LocalPlayer.Backpack:GetChildren()) do
					if child:IsA("Tool") and child~=tool then
						grips[child]=child.Grip
					end
				end
			elseif invisible then
				invisible=false
				tool.Name="Visible Disabled"
				if handle then
					handle:Destroy()
				end
				if weld then
					weld:Destroy()
				end
				for _,child in pairs(getChar():GetChildren()) do
					if child:IsA("Tool") then
						child.Parent=SafeGetService("Players").LocalPlayer.Backpack
					end
				end
				for tool,grip in pairs(grips) do
					if tool then
						tool.Grip=grip
					end
				end
				heldTool=nil
				setDisplayDistance(100)
				SafeGetService("Workspace").CurrentCamera.CameraSubject=getChar().Humanoid
				getRoot(getChar()).CFrame=getRoot(getChar()).CFrame*CFrame.new(0,-offset,0)
				getChar().Humanoid.HipHeight=0
			end
			tool.Parent=SafeGetService("Players").LocalPlayer.Backpack
		end
	)
	getChar().ChildAdded:Connect(
		function(child)
			wait()
			if invisible and child:IsA("Tool") and child~=heldTool and child~=tool then
				heldTool=child
				local lastGrip=heldTool.Grip
				if not grips[heldTool] then
					grips[heldTool]=lastGrip
				end
				for _,track in pairs(getChar().Humanoid:GetPlayingAnimationTracks()) do
					track:Stop()
				end
				getChar().Animate.Disabled=true
				heldTool.Grip=heldTool.Grip*(CFrame.new(0,offset-1.5,1.5)*CFrame.Angles(math.rad(-90),0,0))
				heldTool.Parent=SafeGetService("Players").LocalPlayer.Backpack
				heldTool.Parent=getChar()
				if gripChanged then
					gripChanged:Disconnect()
				end
				gripChanged=
					heldTool:GetPropertyChangedSignal("Grip"):Connect(
						function()
							wait()
							if not invisible then
								gripChanged:Disconnect()
							end
							if heldTool.Grip~=lastGrip then
								lastGrip=
								heldTool.Grip*(CFrame.new(0,offset-1.5,1.5)*CFrame.Angles(math.rad(-90),0,0))
								heldTool.Grip=lastGrip
								heldTool.Parent=SafeGetService("Players").LocalPlayer.Backpack
								heldTool.Parent=getChar()
							end
						end
					)
			end
		end
	)
end)

local invisBtnlol=nil

cmd.add({"invisible","invis"},{"invisible (invis)","Sets invisibility to scare people or something"},function()
	Keybind="E"

	local CS=SafeGetService("CollectionService")
	local UIS=SafeGetService("UserInputService")

	if invisRunning then return end
	invisRunning=true
	--Full credit to AmokahFox @V3rmillion
	local Player=SafeGetService("Players").LocalPlayer
	repeat wait(.1) until getChar()
	local Character=getChar()
	Character.Archivable=true
	local IsInvis=false
	local IsRunning=true
	local InvisibleCharacter=Character:Clone()
	InvisibleCharacter.Parent=SafeGetService("Lighting")
	local Void=SafeGetService("Workspace").FallenPartsDestroyHeight
	InvisibleCharacter.Name=""
	local CF

	local invisFix=SafeGetService("RunService").Stepped:Connect(function()
		pcall(function()
			local IsInteger
			if tostring(Void):find'-' then
				IsInteger=true
			else
				IsInteger=false
			end
			local Pos=getRoot(getChar()).Position
			local Pos_String=tostring(Pos)
			local Pos_Seperate=Pos_String:split(',')
			local X=tonumber(Pos_Seperate[1])
			local Y=tonumber(Pos_Seperate[2])
			local Z=tonumber(Pos_Seperate[3])
			if IsInteger==true then
				if Y <=Void then
					Respawn()
				end
			elseif IsInteger==false then
				if Y >=Void then
					Respawn()
				end
			end
		end)
	end)

	for i,v in pairs(InvisibleCharacter:GetDescendants())do
		if v:IsA("BasePart") then
			if v.Name=="HumanoidRootPart" then
				v.Transparency=1
			else
				v.Transparency=.5
			end
		end
	end

	function Respawn()
		IsRunning=false
		if IsInvis==true then
			pcall(function()
				Player.Character=Character
				wait()
				Character.Parent=SafeGetService("Workspace")
				Character:FindFirstChildWhichIsA'Humanoid':Destroy()
				IsInvis=false
				InvisibleCharacter.Parent=nil
				invisRunning=false
			end)
		elseif IsInvis==false then
			pcall(function()
				Player.Character=Character
				wait()
				Character.Parent=SafeGetService("Workspace")
				Character:FindFirstChildWhichIsA'Humanoid':Destroy()
				TurnVisible()
			end)
		end
	end

	local invisDied
	invisDied=InvisibleCharacter:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
		Respawn()
		invisDied:Disconnect()
	end)

	function TurnVisible()
		if IsInvis==false then return end
		invisFix:Disconnect()
		invisDied:Disconnect()
		CF=SafeGetService("Workspace").CurrentCamera.CFrame
		Character=Character
		local CF_1=getRoot(Player.Character).CFrame
		getRoot(character).CFrame=CF_1
		InvisibleCharacter.Parent=SafeGetService("Lighting")
		Player.Character=Character
		Character.Parent=SafeGetService("Workspace")
		IsInvis=false
		Player.Character.Animate.Disabled=true
		Player.Character.Animate.Disabled=false
		invisDied=Character:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
			Respawn()
			invisDied:Disconnect()
		end)
		invisRunning=false
	end



	local CS=SafeGetService("CollectionService")
	local UIS=SafeGetService("UserInputService")

	UIS.InputBegan:Connect(function(input,gameProcessed)
		if input.UserInputType==Enum.UserInputType.Keyboard then
			if input.KeyCode==Enum.KeyCode.E and not gameProcessed then
				if IsInvis==false then
					IsInvis=true
					CF=SafeGetService("Workspace").CurrentCamera.CFrame
					local CF_1=getRoot(getChar()).CFrame
					Character:MoveTo(Vector3.new(0,math.pi*1000000,0))
					SafeGetService("Workspace").CurrentCamera.CameraType=Enum.CameraType.Scriptable
					wait(.1)
					SafeGetService("Workspace").CurrentCamera.CameraType=Enum.CameraType.Custom
					InvisibleCharacter=InvisibleCharacter
					Character.Parent=SafeGetService("Lighting")
					InvisibleCharacter.Parent=SafeGetService("Workspace")
					InvisiblegetRoot(character).CFrame=CF_1
					SafeGetService("Players").LocalPlayer.Character=InvisibleCharacter
					local workspace=SafeGetService("Workspace")
					Players=SafeGetService("Players")
					local speaker=SafeGetService("Players").LocalPlayer
					SafeGetService("Workspace").CurrentCamera:remove()
					wait(.1)
					SafeGetService("Workspace").CurrentCamera.CameraSubject=speaker.Character:FindFirstChildWhichIsA('Humanoid')
					SafeGetService("Workspace").CurrentCamera.CameraType="Custom"
					SafeGetService("Players").LocalPlayer.CameraMinZoomDistance=0.5
					SafeGetService("Players").LocalPlayer.CameraMaxZoomDistance=400
					SafeGetService("Players").LocalPlayer.CameraMode="Classic"
					getChar().Head.Anchored=false
					getChar().Animate.Disabled=true
					getChar().Animate.Disabled=false
				elseif IsInvis==true then
					TurnVisible()
					IsInvis=false
				end
			end
		end
	end)

	wait();

	DoNotif("Invisible loaded,press "..Keybind.." to toggle")
	if IsOnMobile then 
		wait();

		DoNotif(adminName.." has detected you using mobile you now have a invisible button click it to enable / disable invisibility")

		if invisBtnlol then invisBtnlol:Destroy() invisBtnlol=nil end
		invisBtnlol=Instance.new("ScreenGui")
		local TextButton=Instance.new("TextButton")
		local UICorner=Instance.new("UICorner")
		local UIAspectRatioConstraint=Instance.new("UIAspectRatioConstraint")

		--Properties:
		invisBtnlol.Parent=COREGUI
		invisBtnlol.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
		invisBtnlol.ResetOnSpawn=false

		TextButton.Parent=invisBtnlol
		TextButton.BackgroundColor3=Color3.fromRGB(12,4,20)
		TextButton.BackgroundTransparency=0.140
		TextButton.Position=UDim2.new(0.933,0,0.621,0)
		TextButton.Size=UDim2.new(0.043,0,0.083,0)
		TextButton.Font=Enum.Font.SourceSansBold
		TextButton.Text="Invisible"
		TextButton.TextColor3=Color3.fromRGB(255,255,255)
		TextButton.TextSize=15.000
		TextButton.TextWrapped=true
		TextButton.Active=true
		TextButton.Draggable=true
		TextButton.TextScaled=true

		UICorner.Parent=TextButton

		UIAspectRatioConstraint.Parent=TextButton
		UIAspectRatioConstraint.AspectRatio=1.060

		--Scripts:

		function FEPVI_fake_script()
			IsInvis=false
			TextButton.MouseButton1Click:Connect(function()
				if IsInvis==false then
					IsInvis=true
					CF=SafeGetService("Workspace").CurrentCamera.CFrame
					local CF_1=getRoot(getChar()).CFrame
					Character:MoveTo(Vector3.new(0,math.pi*1000000,0))
					SafeGetService("Workspace").CurrentCamera.CameraType=Enum.CameraType.Scriptable
					wait(.1)
					SafeGetService("Workspace").CurrentCamera.CameraType=Enum.CameraType.Custom
					InvisibleCharacter=InvisibleCharacter
					Character.Parent=SafeGetService("Lighting")
					InvisibleCharacter.Parent=SafeGetService("Workspace")
					InvisiblegetRoot(character).CFrame=CF_1
					Player.Character=InvisibleCharacter
					local workspace=SafeGetService("Workspace")
					Players=SafeGetService("Players")
					local speaker=SafeGetService("Players").LocalPlayer
					SafeGetService("Workspace").CurrentCamera:remove()
					wait(.1)
					SafeGetService("Workspace").CurrentCamera.CameraSubject=speaker.Character:FindFirstChildWhichIsA('Humanoid')
					SafeGetService("Workspace").CurrentCamera.CameraType="Custom"
					SafeGetService("Players").LocalPlayer.CameraMinZoomDistance=0.5
					SafeGetService("Players").LocalPlayer.CameraMaxZoomDistance=400
					SafeGetService("Players").LocalPlayer.CameraMode="Classic"
					getChar().Head.Anchored=false
					getChar().Animate.Disabled=true
					getChar().Animate.Disabled=false
					TextButton.Text="Visible"
				elseif IsInvis==true then
					TurnVisible()
					IsInvis=false
					TextButton.Text="Invisible"
				end
			end)
		end
		coroutine.wrap(FEPVI_fake_script)()
	else
	end
end)

cmd.add({"unchatspy"},{"unchat","Unspies on chat,enables chat,spies whispers etc."},function()

	wait();

	DoNotif("Chat spy disabled")
	--This script reveals ALL hidden messages in the default chat
	--chat "/spy" to toggle!
	enabled=false
	--if true will check your messages too
	spyOnMyself=true
	--if true will chat the logs publicly (fun,risky)
	public=false
	--if true will use /me to stand out
	publicItalics=true
	--customize private logs
	privateProperties={
		Color=Color3.fromRGB(0,255,255); 
		Font=Enum.Font.SourceSansBold;
		TextSize=18;
	}
	--////////////////////////////////////////////////////////////////
	local StarterGui=SafeGetService("StarterGui")
	local Players=SafeGetService("Players")
	local player=Players.LocalPlayer
	local saymsg=SafeGetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
	local getmsg=SafeGetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
	local instance=(_G.chatSpyInstance or 0)+1
	_G.chatSpyInstance=instance

	function onChatted(p,msg)
		if _G.chatSpyInstance==instance then
			if p==player and msg:lower():sub(1,4)=="/spy" then
				enabled=not enabled
				wait(0.3)
				print("XD")
				StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
			elseif enabled and (spyOnMyself==true or p~=player) then
				msg=msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
				local hidden=true
				local conn=getmsg.OnClientEvent:Connect(function(packet,channel)
					if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and Players[packet.FromSpeaker].Team==player.Team)) then
						hidden=false
					end
				end)
				wait(1)
				conn:Disconnect()
				if hidden and enabled then
					if public then
						saymsg:FireServer((publicItalics and "/me " or '').."{SPY} [".. p.Name .."]: "..msg,"All")
					else
						privateProperties.Text="{SPY} [".. p.Name .."]: "..msg
						StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
					end
				end
			end
		end
	end

	for _,p in ipairs(Players:GetPlayers()) do
		p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	end
	Players.PlayerAdded:Connect(function(p)
		p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	end)
	StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
	local chatFrame=player.PlayerGui.Chat.Frame
	chatFrame.ChatChannelParentFrame.Visible=true
	chatFrame.ChatBarParentFrame.Position=chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
end)

cmd.add({"fireremotes"},{"fireremotes","Fires every remote"},function()
	local rem=0
	for _,v in pairs(game:GetDescendants()) do
		if not v:IsDescendantOf(game.CoreGui) then
			if v:IsA("RemoteEvent") then
				NACaller(function()
					v:FireServer()
				end)
				rem=rem+1
			elseif v:IsA("BindableEvent") then
				NACaller(function()
					v:Fire()
				end)
				rem=rem+1
			elseif v:IsA("RemoteFunction") then
				NACaller(function()
					v:InvokeServer()
				end)
				rem=rem+1
			end
		end
	end

	wait()

	DoNotif("Fired "..rem.." amount of remotes")

end)


cmd.add({"uafollow","unanchoredfollow"},{"uafollow (unanchoredfollow)","Makes unanchored parts follow you"},function() 
	wait();

	DoNotif("Unanchored follow executed")
	local LocalPlayer=SafeGetService("Players").LocalPlayer
	local unanchoredparts={}
	local movers={}
	for index,part in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if part:IsA("Part") and part.Anchored==false and part:IsDescendantOf(LocalPlayer.Character)==false then
			table.insert(unanchoredparts,part)
			part.Massless=true
			part.CanCollide=false
			if part:FindFirstChildOfClass("BodyPosition")~=nil then
				part:FindFirstChildOfClass("BodyPosition"):Destroy()
			end
		end
	end
	for index,part in pairs(unanchoredparts) do
		local mover=Instance.new("BodyPosition",part)
		table.insert(movers,mover)
		mover.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
	end
	repeat
		for index,mover in pairs(movers) do
			mover.Position=LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame:PointToWorldSpace(Vector3.new(0,0,5))
		end
		wait(0.5)
	until LocalPlayer.Character:FindFirstChild("Humanoid").Health <=0
	for _,mover in pairs(movers) do
		mover:Destroy()
	end
end)

--tween works better for some reason

cmd.add({"fov"},{"fov <number>","Makes your FOV to something custom you want (1-120 FOV)"},function(num)
	local field=(num or 70)
	--SafeGetService("Workspace").CurrentCamera.FieldOfView=tonumber(arg[1])
	local hh=SafeGetService("TweenService"):Create(SafeGetService("Workspace").CurrentCamera,TweenInfo.new(0,Enum.EasingStyle.Linear),{FieldOfView=tonumber(field)})
	hh:Play()
end)

local fovcon=nil

cmd.add({"loopfov","lfov"},{"loopfov <number> (lfov)","Makes your FOV to something custom you want (1-120 FOV) on loop"},function(num)
	local field=(num or 70)
	if fovcon then fovcon:Disconnect() fovcon=nil end
	fovcon=SafeGetService("RunService").RenderStepped:Connect(function()
		local hh=SafeGetService("TweenService"):Create(SafeGetService("Workspace").CurrentCamera,TweenInfo.new(0,Enum.EasingStyle.Linear),{FieldOfView=tonumber(field)})
		hh:Play()
	end)
end)

cmd.add({"unloopfov","unlfov"},{"unloopfov <number> (unlfov)",""},function()
	if fovcon then fovcon:Disconnect() fovcon=nil end
end)

cmd.add({"homebrew"},{"homebrew","Executes homebrew admin"},function()
	_G.CustomUI=false
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/mgamingpro/HomebrewAdmin/master/Main'),true))()
end)

cmd.add({"fatesadmin"},{"fatesadmin","Executes fates admin"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))();
end)

cmd.add({"savetools","stools"},{"savetools (stools)","puts your tools in players.localplayer"},function()
	for _,v in pairs(SafeGetService("Players").LocalPlayer.Backpack:GetChildren()) do
		if (v:IsA("Tool")) then
			v.Parent=Players.LocalPlayer
		end
	end
end)

cmd.add({"loadtools","ltools"},{"loadtools (ltools)","puts your tools back in the backpack"},function()
	for _,v in pairs(SafeGetService("Players").LocalPlayer:GetChildren()) do
		if (v:IsA("Tool")) then
			v.Parent=SafeGetService("Players").LocalPlayer.Backpack
		end
	end
end)

cmd.add({"grabtools","gt"},{"grabtools","Grabs any dropped tools"},function()
	local p=SafeGetService("Players").LocalPlayer
	local c=p.Character
	if c and c:FindFirstChild("Humanoid") then
		for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if v:IsA("Tool") then
				c:FindFirstChild("Humanoid"):EquipTool(v)
			end
		end
	end
	wait();

	DoNotif("Grabbed all tools")
end)

cmd.add({"ws","speed","walkspeed"},{"walkspeed <number> (speed,ws)","Makes your WalkSpeed whatever you want"},function(...)
	local args={...}
	if args[2] then
		local speed=args[2] or 16
		if isNumber(speed) then
			getHum().WalkSpeed=speed
		end
	else
		local speed=args[1] or 16
		if isNumber(speed) then
			getHum().WalkSpeed=speed
		end
	end
end)

cmd.add({"jp","jumppower"},{"jumppower <number> (jp)","Makes your JumpPower whatever you want"},function(...)
	local args={...}
	local jpower=args[1] or 50
	if isNumber(jpower) then
		if getHum().UseJumpPower then
			getHum().JumpPower=jpower
		else
			getHum().JumpHeight=jpower
		end
	end
end)

cmd.add({"oofspam"},{"oofspam","Spams oof"},function()
	_G.enabled=true
	_G.speed=100
	local HRP=Humanoid.RootPart or Humanoid:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not _G.enabled then
		if Humanoid and Humanoid.Health <=0 then
			Humanoid:Destroy()
		end
		return
	end
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead,false)
	Humanoid.BreakJointsOnDeath=false
	Humanoid.RequiresNeck=false
	local con; con=RunService.Stepped:Connect(function()
		if not Humanoid then return con:Disconnect() end
		Humanoid:ChangeState(Enum.HumanoidStateType.Running)
	end)
	LocalPlayer.Character=nil
	LocalPlayer.Character=Character
	task.wait(Players.RespawnTime+0.1)
	while task.wait(1/_G.speed) do
		Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
	end
end)


cmd.add({"tpua","bringua"},{"tpua <player> (bringua)","brings every unanchored part on the map"},function(...)
	local heartbeat=RunService.Heartbeat
	task.spawn(function()
		while true do heartbeat:Wait()
			SafeGetService("Players").LocalPlayer.MaximumSimulationRadius=math.pow(math.huge,math.huge)*math.huge
			sethiddenproperty(SafeGetService("Players").LocalPlayer,"SimulationRadius",math.pow(math.huge,math.huge)*math.huge)
			SafeGetService("RunService").Stepped:wait()
		end
	end)

	function execute(name)
		for index,part in pairs(game:GetDescendants()) do
			if part:IsA("BasePart" or "UnionOperation" or "Model") and part.Anchored==false and part:IsDescendantOf(getChar())==false and part.Name=="Torso"==false and part.Name=="Head"==false and part.Name=="Right Arm"==false and part.Name=="Left Arm"==false and part.Name=="Right Leg"==false and part.Name=="Left Leg"==false and part.Name=="HumanoidRootPart"==false then--// Checks Part Properties
				part.CFrame=CFrame.new(SafeGetService("Workspace")[name].Head.Position)--TP Part To User
				if spam==true and part:FindFirstChild("BodyGyro")==nil then
					local bodyPos=Instance.new("BodyPosition")
					bodyPos.Position=part.Position
					bodyPos.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
					bodyPos.P=1e6
					bodyPos.Parent=part
				end
			end
		end
	end
	User=(...)
	Target=getPlr(User)
	TargetName=Target.Name
	execute(TargetName)
	wait();

	DoNotif("Unanchored parts have been teleported to "..TargetName)
end)

cmd.add({"freezeua","thawua"},{"freezeua (thawua)","freezes every unanchored part on the map"},function()
	frozenParts={}
	if sethidden then
		local badnames={
			"Head",
			"UpperTorso",
			"LowerTorso",
			"RightUpperArm",
			"LeftUpperArm",
			"RightLowerArm",
			"LeftLowerArm",
			"RightHand",
			"LeftHand",
			"RightUpperLeg",
			"LeftUpperLeg",
			"RightLowerLeg",
			"LeftLowerLeg",
			"RightFoot",
			"LeftFoot",
			"Torso",
			"Right Arm",
			"Left Arm",
			"Right Leg",
			"Left Leg",
			"HumanoidRootPart"
		}
		function FREEZENOOB(v)
			if v:IsA("BasePart" or "UnionOperation") and v.Anchored==false then
				local BADD=false
				for i=1,#badnames do
					if v.Name==badnames[i] then
						BADD=true
					end
				end
				if getChar() and v:IsDescendantOf(getChar()) then
					BADD=true
				end
				if BADD==false then
					for i,c in pairs(v:GetChildren()) do
						if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
							c:Destroy()
						end
					end
					local bodypos=Instance.new("BodyPosition")
					bodypos.Parent=v
					bodypos.Position=v.Position
					bodypos.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
					local bodygyro=Instance.new("BodyGyro")
					bodygyro.Parent=v
					bodygyro.CFrame=v.CFrame
					bodygyro.MaxTorque=Vector3.new(math.huge,math.huge,math.huge)
					if not table.find(frozenParts,v) then
						table.insert(frozenParts,v)
					end
				end
			end
		end
		for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
			FREEZENOOB(v)
		end
		freezingua=SafeGetService("Workspace").DescendantAdded:Connect(FREEZENOOB)
	end
end)

cmd.add({"unfreezeua","unthawua"},{"unfreezeua (unthawua)","unfreezes every unanchored part on the map"},function()
	wait();

	DoNotif("Unfroze unanchored parts")
	if sethidden then
		if freezingua then
			freezingua:Disconnect()
		end
		for i,v in pairs(frozenParts) do
			for i,c in pairs(v:GetChildren()) do
				if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
					c:Destroy()
				end
			end
		end
		frozenParts={}
	end
end)

cmd.add({"highlightua","highlightunanchored"},{"highlightua (hightlightunanchored)","Highlights all unanchored parts"},function()
	wait();

	DoNotif("Highlighted all unanchored parts")
	for _,part in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Anchored==false and part:IsDescendantOf(getChar())==false and part.Name=="Torso"==false and part.Name=="Head"==false and part.Name=="Right Arm"==false and part.Name=="Left Arm"==false and part.Name=="Right Leg"==false and part.Name=="Left Leg"==false and part.Name=="HumanoidRootPart"==false and part:FindFirstChild("Weld")==nil then
			local selectionBox=Instance.new("SelectionBox")
			selectionBox.Adornee=part
			selectionBox.Color3=Color3.new(1,0,0)
			selectionBox.Parent=part
		end
	end
end)

cmd.add({"unhighlightua","unhighlightunanchored"},{"unhighlightua (unhightlightunanchored)","Unhighlights all unanchored parts"},function()

	wait();

	DoNotif("Unhighlighted unanchored parts")

	for _,part in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Anchored==false and part:IsDescendantOf(getChar())==false and part.Name=="Torso"==false and part.Name=="Head"==false and part.Name=="Right Arm"==false and part.Name=="Left Arm"==false and part.Name=="Right Leg"==false and part.Name=="Left Leg"==false and part.Name=="HumanoidRootPart"==false and part:FindFirstChild("Weld")==nil then
			if part:FindFirstChild("SelectionBox") then
				part.SelectionBox:Destroy()
			end
		end
	end
end)

cmd.add({"countua","countunanchoreed"},{"countua (countunanchored)","Counts all unanchored parts in the console"},function()
	b=0
	for index,part in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Anchored==false and part:IsDescendantOf(getChar())==false and part.Name=="Torso"==false and part.Name=="Head"==false and part.Name=="Right Arm"==false and part.Name=="Left Arm"==false and part.Name=="Right Leg"==false and part.Name=="Left Leg"==false and part.Name=="HumanoidRootPart"==false and part:FindFirstChild("Weld")==nil then
			b=b+1
		end
	end	 
	wait();

	DoNotif("Parts have been counted,the amount is "..b)
end)

cmd.add({"httpspy"},{"httspy","HTTP Spy"},function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/httpspy.lua'))()
end)

cmd.add({"keystroke"},{"keystroke","Executes a keystroke ui script"},function()
	loadstring(game:HttpGet("https://system-exodus.com/scripts/misc-releases/Keystrokes.lua",true))()
end)

cmd.add({"ownerid"},{"ownerid","Changes the client id to the owner's. Can give special things"},function()
	local ownId="unknown"
	local ownUser="unknown"
	NACaller(function()
		if game.CreatorType==Enum.CreatorType.User then
			Player.UserId=game.CreatorId
			Player.Name=game.CreatorName
			ownId=game.CreatorId
			ownUser=game.CreatorName
		end
	end)
	NACaller(function()
		if game.CreatorType==Enum.CreatorType.Group then
			local groupId=game.CreatorId
			local groupInfo=SafeGetService("GroupService"):GetGroupInfoAsync(groupId)
			local owner=groupInfo.Owner
			Player.Name=owner.Name
			Player.UserId=owner.Id
			ownId=owner.Id
			ownUser=owner.Name
		end
	end)
	NACaller(function()
		SafeGetService("StarterGui"):SetCoreGuiEnabled(0,false)
		wait(3);
		SafeGetService("StarterGui"):SetCoreGuiEnabled(0,true)
	end)

	DoNotif("UserId set to: "..ownId.."\nUsername set to: "..ownUser)
	print'set'
end)

cmd.add({"errorchat"},{"errorchat","Makes the chat error appear when roblox chat is slow"},function()
	for i=1,3 do 
		lib.LocalPlayerChat("\0","All")
	end
end)


--[[ FUNCTIONALITY ]]--
localPlayer.Chatted:Connect(function(str)
	lib.parseCommand(str)
end)

--[[ Admin Player]]
function IsAdminAndRun(Message,Player)
	if Admin[Player.UserId] or isRelAdmin(Player) then
		lib.parseCommand(Message,Player)
	end
end

function CheckPermissions(Player)
	Player.Chatted:Connect(function(Message)
		IsAdminAndRun(Message,Player)
	end)
end

Players.PlayerAdded:Connect(function(plr)
	CheckPermissions(plr)
end)
Players.PlayerAdded:Connect(function(plr)
	if ESPenabled then
		repeat wait(1) until plr.Character
		ESP(plr)
	end
end)
for i,v in pairs(Players:GetPlayers()) do
	if v~=LocalPlayer then
		CheckPermissions(v)
	end
end

function Getmodel(id)
	local ob23e232323=nil
	s,r=pcall(function()
		ob23e232323=game:GetObjects(id)[1]
	end)
	if s and ob23e232323 then
		return ob23e232323
	end
	task.wait(1)
	warn("retrying")
	return Getmodel(id) 
end

--[[ GUI VARIABLES ]]--
local ScreenGui=Getmodel("rbxassetid://140418556029404")
local rPlayer=Players:FindFirstChildWhichIsA("Player")
local coreGuiProtection={}
if not RunService:IsStudio() then
else
	repeat wait() until player:FindFirstChild("AdminUI",true)
	ScreenGui=player:FindFirstChild("AdminUI",true)
end
repeat wait() until ScreenGui~=nil -- if it loads late then I'll just add this here
if (get_hidden_gui or gethui) then
	local hiddenUI=(get_hidden_gui or gethui)
	local Main=ScreenGui
	--Main.Name=randomString()
	NAProtection(Main)
	Main.Parent=hiddenUI()
elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
	local Main=ScreenGui
	--Main.Name=randomString()
	NAProtection(Main)
	syn.protect_gui(Main)
	Main.Parent=SafeGetService("CoreGui")
elseif SafeGetService("CoreGui"):FindFirstChildWhichIsA("ScreenGui") then
	pcall(function()
		for i,v in pairs(ScreenGui:GetDescendants()) do
			coreGuiProtection[v]=rPlayer.Name
		end
		ScreenGui.DescendantAdded:Connect(function(v)
			coreGuiProtection[v]=rPlayer.Name
		end)
		coreGuiProtection[ScreenGui]=rPlayer.Name

		local meta=getrawmetatable(game)
		local tostr=meta.__tostring
		setreadonly(meta,false)
		meta.__tostring=newcclosure(function(t)
			if coreGuiProtection[t] and not checkcaller() then
				return coreGuiProtection[t]
			end
			return tostr(t)
		end)
	end)
	if not RunService:IsStudio() then
		local newGui=SafeGetService("CoreGui"):FindFirstChildWhichIsA("ScreenGui")
		newGui.DescendantAdded:Connect(function(v)
			coreGuiProtection[v]=rPlayer.Name
		end)
		for i,v in pairs(ScreenGui:GetChildren()) do
			v.Parent=newGui
		end
		ScreenGui=newGui
	end
elseif COREGUI then
	local Main=ScreenGui
	--Main.Name=randomString()
	NAProtection(Main)
	Main.Parent=COREGUI
else
	warn'no guis?'
end
if ScreenGui then ScreenGui.DisplayOrder=9999 ScreenGui.ResetOnSpawn=false end
local description=ScreenGui:FindFirstChild("Description");
local cmdBar=ScreenGui:FindFirstChild("CmdBar");
local centerBar=cmdBar:FindFirstChild("CenterBar");
local cmdInput=centerBar:FindFirstChild("Input");
local cmdAutofill=cmdBar:FindFirstChild("Autofill");
local cmdExample=cmdAutofill:FindFirstChild("Cmd");
local leftFill=cmdBar:FindFirstChild("LeftFill");
local rightFill=cmdBar:FindFirstChild("RightFill");
local chatLogsFrame=ScreenGui:FindFirstChild("ChatLogs");
local chatLogs=chatLogsFrame:FindFirstChild("Container"):FindFirstChild("Logs");
local chatExample=chatLogs:FindFirstChild("TextLabel");
local commandsFrame=ScreenGui:FindFirstChild("Commands");
local commandsFilter=commandsFrame:FindFirstChild("Container"):FindFirstChild("Filter");
local commandsList=commandsFrame:FindFirstChild("Container"):FindFirstChild("List");
local commandExample=commandsList:FindFirstChild("TextLabel");
local UniverseViewerFrame=ScreenGui:FindFirstChild("UniverseViewer");
local UniverseList=UniverseViewerFrame:FindFirstChild("Container"):FindFirstChild("List");
local UniverseExample=UniverseList:FindFirstChildOfClass("TextButton");
local UpdLogsFrame=ScreenGui:FindFirstChild("UpdLog");
local UpdLogsTitle=UpdLogsFrame:FindFirstChild("Topbar"):FindFirstChild("TopBar"):FindFirstChild("Title");
local UpdLogsList=UpdLogsFrame:FindFirstChild("Container"):FindFirstChild("List");
local UpdLogsLabel=UpdLogsList:FindFirstChildOfClass("TextLabel");
local ShiftlockUi=ScreenGui:FindFirstChild("LockButton");
local resizeFrame=ScreenGui:FindFirstChild("Resizeable");
local resizeXY={
	Top		={Vector2.new(0,-1),	Vector2.new(0,-1),	"rbxassetid://2911850935"},
	Bottom	={Vector2.new(0,1),	Vector2.new(0,0),	"rbxassetid://2911850935"},
	Left	={Vector2.new(-1,0),	Vector2.new(1,0),	"rbxassetid://2911851464"},
	Right	={Vector2.new(1,0),	Vector2.new(0,0),	"rbxassetid://2911851464"},

	TopLeft		={Vector2.new(-1,-1),	Vector2.new(1,-1),	"rbxassetid://2911852219"},
	TopRight	={Vector2.new(1,-1),	Vector2.new(0,-1),	"rbxassetid://2911851859"},
	BottomLeft	={Vector2.new(-1,1),	Vector2.new(1,0),	"rbxassetid://2911851859"},
	BottomRight	={Vector2.new(1,1),	Vector2.new(0,0),	"rbxassetid://2911852219"},
}

cmdExample.Parent=nil
chatExample.Parent=nil
commandExample.Parent=nil
UniverseExample.Parent=nil
UpdLogsLabel.Parent=nil
resizeFrame.Parent=nil

	--[[pcall(function()
		for i,v in pairs(ScreenGui:GetDescendants()) do
			coreGuiProtection[v]=rPlayer.Name
		end
		ScreenGui.DescendantAdded:Connect(function(v)
			coreGuiProtection[v]=rPlayer.Name
		end)
		coreGuiProtection[ScreenGui]=rPlayer.Name
	
		local meta=getrawmetatable(game)
		local tostr=meta.__tostring
		setreadonly(meta,false)
		meta.__tostring=newcclosure(function(t)
			if coreGuiProtection[t] and not checkcaller() then
				return coreGuiProtection[t]
			end
			return tostr(t)
		end)
	end)
	if not RunService:IsStudio() then
		local newGui=SafeGetService("CoreGui"):FindFirstChildWhichIsA("ScreenGui")
		newGui.DescendantAdded:Connect(function(v)
			coreGuiProtection[v]=rPlayer.Name
		end)
		for i,v in pairs(ScreenGui:GetChildren()) do
			v.Parent=newGui
		end
		ScreenGui=newGui
	end]]

--[[ GUI FUNCTIONS ]]--
gui={}
gui.txtSize=function(ui,x,y)
	local textService=SafeGetService("TextService")
	return textService:GetTextSize(ui.Text,ui.TextSize,ui.Font,Vector2.new(x,y))
end
gui.commands=function()
	if not commandsFrame.Visible then
		commandsFrame.Visible=true
		commandsList.CanvasSize=UDim2.new(0,0,0,0)
	end
	for i,v in pairs(commandsList:GetChildren()) do
		if v:IsA("TextLabel") then
			v:Remove()
		end
	end
	local i=0
	for cmdName,tbl in pairs(Commands) do
		local Cmd=commandExample:Clone()
		Cmd.Parent=commandsList
		Cmd.Name=cmdName
		Cmd.Text=" "..tbl[2][1]
		Cmd.MouseEnter:Connect(function()
			description.Visible=true
			description.Text=tbl[2][2]
		end)
		Cmd.MouseLeave:Connect(function()
			if description.Text==tbl[2][2] then
				description.Visible=false
				description.Text=""
			end
		end)
		i=i+1
	end
	commandsList.CanvasSize=UDim2.new(0,0,0,i*20+10)
	commandsFrame.Position=UDim2.new(0.5,-283/2,0.5,-260/2)
end
gui.chatlogs=function()
	if not chatLogsFrame.Visible then
		chatLogsFrame.Visible=true
	end
	chatLogsFrame.Position=UDim2.new(0.5,-283/2+5,0.5,-260/2+5)
end
gui.universeGui=function()
	if not UniverseViewerFrame.Visible then
		UniverseViewerFrame.Visible=true
	end
	UniverseViewerFrame.Position=UDim2.new(0.5,-283/2+5,0.5,-260/2+5)
end
gui.updateLogs=function()
	if not UpdLogsFrame.Visible and next(updLogs) then
		UpdLogsFrame.Visible=true
	elseif not next(updLogs) then
		DoNotif("no upd logs for now...")
	else
		warn("huh?")
	end
	UpdLogsFrame.Position=UDim2.new(0.5,-283/2+5,0.5,-260/2+5)
end
gui.ShiftlockVis=function()
	if not ShiftlockUi.Visible then
		ShiftlockUi.Visible=true
	end
end
gui.ShiftlockInvis=function()
	if ShiftlockUi.Visible then
		ShiftlockUi.Visible=false
	end
end

gui.tween=function(obj,style,direction,duration,goal)
	local tweenInfo=TweenInfo.new(duration,Enum.EasingStyle[style],Enum.EasingDirection[direction])
	local tween=TweenService:Create(obj,tweenInfo,goal)
	tween:Play()
	return tween
end
gui.mouseIn=function(guiObject,range)
	local pos1,pos2=guiObject.AbsolutePosition,guiObject.AbsolutePosition+guiObject.AbsoluteSize
	local mX,mY=mouse.X,mouse.Y
	if mX>pos1.X-range and mX<pos2.X+range and mY>pos1.Y-range and mY<pos2.Y+range then
		return true
	end
	return false
end
gui.resizeable=function(ui,min,max)
	local rgui=resizeFrame:Clone()
	rgui.Parent=ui

	local mode
	local UIPos
	local lastSize
	local lastPos=Vector2.new()

	function update(delta)
		local xy=resizeXY[(mode and mode.Name) or '']
		if not mode or not xy then return end
		local delta=(delta*xy[1]) or Vector2.new()
		local newSize=Vector2.new(lastSize.X+delta.X,lastSize.Y+delta.Y)
		newSize=Vector2.new(
			math.clamp(newSize.X,min.X,max.X),
			math.clamp(newSize.Y,min.Y,max.Y)
		)
		ui.Size=UDim2.new(0,newSize.X,0,newSize.Y)
		ui.Position=UDim2.new(
			UIPos.X.Scale,
			UIPos.X.Offset+(-(newSize.X-lastSize.X)*xy[2]).X,
			UIPos.Y.Scale,
			UIPos.Y.Offset+(delta*xy[2]).Y
		)
	end

	mouse.Move:Connect(function()
		update(Vector2.new(mouse.X,mouse.Y)-lastPos)
	end)

	for _,button in pairs(rgui:GetChildren()) do
		local isIn=false
		button.InputBegan:Connect(function(input)
			if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
				mode=button
				lastPos=Vector2.new(mouse.X,mouse.Y)
				lastSize=ui.AbsoluteSize
				UIPos=ui.Position
			end
		end)
		button.InputEnded:Connect(function(input)
			if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
				mode=nil
			end
		end)
		button.MouseEnter:Connect(function()
			mouse.Icon=resizeXY[button.Name][3]
		end)
		button.MouseLeave:Connect(function()
			if mouse.Icon==resizeXY[button.Name][3] then
				mouse.Icon=""
			end
		end)
	end
end
gui.draggable=function(ui, dragui)
	if not dragui then dragui = ui end
	local UserInputService = SafeGetService("UserInputService")

	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		ui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	dragui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = ui.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	dragui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	ui.Active=true
end
gui.draggablev2=function(floght)
	floght.Active=true
	floght.Draggable=true
end
gui.menuify=function(menu)
	local exit=menu:FindFirstChild("Exit",true)
	local mini=menu:FindFirstChild("Minimize",true)
	local minimized=false
	local sizeX,sizeY=Instance.new("IntValue",menu),Instance.new("IntValue",menu)
	mini.MouseButton1Click:Connect(function()
		minimized=not minimized
		if minimized then
			sizeX.Value=menu.Size.X.Offset
			sizeY.Value=menu.Size.Y.Offset
			gui.tween(menu,"Quart","Out",0.5,{Size=UDim2.new(0,283,0,25)})
		else
			gui.tween(menu,"Quart","Out",0.5,{Size=UDim2.new(0,sizeX.Value,0,sizeY.Value)})
		end
	end)
	exit.MouseButton1Click:Connect(function()
		menu.Visible=false
	end)
	gui.draggable(menu,menu.Topbar)
	menu.Visible=false
end
gui.menuifyv2=function(menu)
	local exit=menu:FindFirstChild("Exit",true)
	local mini=menu:FindFirstChild("Minimize",true)
	local clear=menu:FindFirstChild("Clear",true);
	local minimized=false
	local sizeX,sizeY=Instance.new("IntValue",menu),Instance.new("IntValue",menu)
	mini.MouseButton1Click:Connect(function()
		minimized=not minimized
		if minimized then
			sizeX.Value=menu.Size.X.Offset
			sizeY.Value=menu.Size.Y.Offset
			gui.tween(menu,"Quart","Out",0.5,{Size=UDim2.new(0,283,0,25)})
		else
			gui.tween(menu,"Quart","Out",0.5,{Size=UDim2.new(0,sizeX.Value,0,sizeY.Value)})
		end
	end)
	exit.MouseButton1Click:Connect(function()
		menu.Visible=false
	end)
	if clear then 
		clear.MouseButton1Click:Connect(function()
			local t=menu:FindFirstChild("Container",true):FindFirstChildOfClass("ScrollingFrame"):FindFirstChildOfClass("UIListLayout",true)
			for _,v in ipairs(t.Parent:GetChildren()) do
				if v:IsA("TextLabel") then
					v:Destroy()
				end
			end
		end)
	end
	gui.draggable(menu,menu.Topbar)
	menu.Visible=false
end

gui.shiftlock=function(sLock,lockImg)
	local V=false
	local g=nil
	local GameSettings=UserSettings():GetService("UserGameSettings")
	local J=nil
	lockImg.Active=false

	function ForceShiftLock()
		local i,k=pcall(function()
			return GameSettings.RotationType
		end)
		_=i
		g=k
		J=SafeGetService("RunService").RenderStepped:Connect(function()
			pcall(function()
				GameSettings.RotationType=Enum.RotationType.CameraRelative
			end)
		end)
	end

	function EndForceShiftLock()
		if J then
			pcall(function()
				GameSettings.RotationType=g or Enum.RotationType.MovementRelative
			end)
			J:Disconnect()
		end
	end

	sLock.MouseButton1Click:Connect(function()
		V=not V
		lockImg.ImageColor3=V and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,255,255)
		if V then
			ForceShiftLock()
		else
			EndForceShiftLock()
		end
	end)
	gui.draggable(sLock)
end


gui.loadCommands=function()
	for i,v in pairs(cmdAutofill:GetChildren()) do
		if v.Name~="UIListLayout" then
			v:Remove()
		end
	end
	local last=nil
	local i=0
	for name,tbl in pairs(Commands) do
		local info=tbl[2]
		local btn=cmdExample:Clone()
		btn.Parent=cmdAutofill
		btn.Name=name
		btn.Input.Text=info[1]
		i=i+1

		local size=btn.Size
		btn.Size=UDim2.new(0,0,0,25)
		btn.Size=size
	end
end

gui.loadCommands()
for i,v in ipairs(cmdAutofill:GetChildren()) do
	if v:IsA("Frame") then
		v.Visible=false
	end
end
gui.barSelect=function(speed)
	centerBar.Visible=true
	gui.tween(centerBar,"Sine","Out",speed or 0.25,{Size=UDim2.new(0,250,1,15)})
	gui.tween(leftFill,"Quad","Out",speed or 0.3,{Position=UDim2.new(0,0,0.5,0)})
	gui.tween(rightFill,"Quad","Out",speed or 0.3,{Position=UDim2.new(1,0,0.5,0)})
end
gui.barDeselect=function(speed)
	gui.tween(centerBar,"Sine","Out",speed or 0.25,{Size=UDim2.new(0,250,0,0)})
	gui.tween(leftFill,"Sine","In",speed or 0.3,{Position=UDim2.new(-0.5,100,0.5,0)})
	gui.tween(rightFill,"Sine","In",speed or 0.3,{Position=UDim2.new(1.5,-100,0.5,0)})
	for i,v in ipairs(cmdAutofill:GetChildren()) do
		if v:IsA("Frame") then
			wrap(function()
				wait(math.random(1,200)/2000)
				gui.tween(v,"Back","In",0.35,{Size=UDim2.new(0,0,0,25)})
			end)
		end
	end
end

--[[ AUTOFILL SEARCHER ]]--
gui.searchCommands=function()
	local searchTerm=cmdInput.Text:gsub(";",""):lower()
	local index=0
	local lastFramePos
	for _,frame in ipairs(cmdAutofill:GetChildren()) do
		if frame:IsA("Frame") and index < 5 then
			local cmdName=frame.Name
			local command=Commands[cmdName]
			local displayName=command and command[2][1] or ""
			local isMatching=searchTerm=="" or cmdName:find(searchTerm,1,true)~=nil
			frame.Input.Text=searchTerm~="" and (cmdName:find(searchTerm,1,true)==1 and cmdName or displayName) or displayName
			frame.Visible=isMatching
			if isMatching then
				index=index+1
				local newSize=UDim2.new(0.5,math.sqrt(index)*125,0,25)
				local newYPos=(index - 1)*28
				local newPosition=UDim2.new(0.5,0,0,newYPos)
				gui.tween(frame,"Quint","Out",0.3,{
					Size=newSize,
					Position=lastFramePos and newPosition or UDim2.new(0.5,0,0,newYPos),
				})
				lastFramePos=newPosition
			end
		end
	end
end

--[[ OPEN THE COMMAND BAR ]]--
mouse.KeyDown:Connect(function(k)
	if k:lower()==opt.prefix then
		gui.barSelect()
		cmdInput.Text=''
		cmdInput:CaptureFocus()
		wait();
		cmdInput.Text=''
	end
end)

--[[ CLOSE THE COMMAND BAR ]]--
cmdInput.FocusLost:Connect(function(enterPressed)
	--if enterPressed then
	wrap(function()
		lib.parseCommand(opt.prefix..cmdInput.Text)
	end)
	--end
	gui.barDeselect()
end)

cmdInput:GetPropertyChangedSignal("Text"):Connect(function()
	gui.searchCommands()
end)

gui.barDeselect(0)
cmdBar.Visible=true
gui.menuifyv2(chatLogsFrame)
gui.menuify(commandsFrame)
gui.menuify(UniverseViewerFrame)
gui.menuify(UpdLogsFrame)
gui.shiftlock(ShiftlockUi,ShiftlockUi.btnIcon)

--[[ GUI RESIZE FUNCTION ]]--

--table.find({Enum.Platform.IOS,Enum.Platform.Android},SafeGetService("UserInputService"):GetPlatform()) | searches if the player is on mobile.
function autoResizeable(ui)
	local initialSize=ui.AbsoluteSize
	local minSize=Vector2.new(
		math.max(100,initialSize.X*0.5),
		math.max(100,initialSize.Y*0.5)
	)
	local maxSize=Vector2.new(
		initialSize.X*3,
		initialSize.Y*3
	)

	gui.resizeable(ui,minSize,maxSize)
end
if not IsOnMobile then 
	autoResizeable(chatLogsFrame)
	autoResizeable(commandsFrame)
	autoResizeable(UniverseViewerFrame)
	autoResizeable(UpdLogsFrame)
end

--[[ CMDS COMMANDS SEARCH FUNCTION ]]--
commandsFilter.Changed:Connect(function(p)
	if p~="Text" then return end
	for i,v in pairs(commandsList:GetChildren()) do
		if v:IsA("TextLabel") then
			if v.Name:find(commandsFilter.Text:lower()) and v.Name:find(commandsFilter.Text:lower()) <=2 then
				v.Visible=true
			else
				v.Visible=false
			end
		end
	end
end)

--[[ CHAT TO USE COMMANDS ]]--
function bindToChat(plr,msg)
	local chatMsg=chatExample:Clone()
	for i,v in pairs(chatLogs:GetChildren()) do
		if v:IsA("TextLabel") then
			v.LayoutOrder=v.LayoutOrder+1
		end
	end
	chatMsg.Parent=chatLogs
	chatMsg.Text=("%s [@%s]: %s"):format(plr.DisplayName,plr.Name,msg)

	local txtSize=gui.txtSize(chatMsg,chatMsg.AbsoluteSize.X,100)
	chatMsg.Size=UDim2.new(1,-5,0,txtSize.Y)
end

for i,plr in pairs(Players:GetPlayers()) do
	plr.Chatted:Connect(function(msg)
		bindToChat(plr,msg)
	end)
end
Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		bindToChat(plr,msg)
	end)
end)

mouse.Move:Connect(function()
	description.Position=UDim2.new(0,mouse.X,0,mouse.Y)
	local size=gui.txtSize(description,200,100)
	description.Size=UDim2.new(0,size.X,0,size.Y)
end)

RunService.Stepped:Connect(function()
	chatLogs.CanvasSize=UDim2.new(0,0,0,chatLogs:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y)
	commandsList.CanvasSize=UDim2.new(0,0,0,commandsList:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y)
	UniverseList.CanvasSize=UDim2.new(0,0,0,UniverseList:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y)
	UpdLogsList.CanvasSize=UDim2.new(0,0,0,UpdLogsList:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y)
end)

NACaller(function()
	local page=AssetService:GetGamePlacesAsync()
	while true do
		local template=UniverseExample
		local list=UniverseList
		for _,place in page:GetCurrentPage() do
			local btn=template:Clone()
			btn.Parent=list
			btn.Name=place.Name
			btn.Text=place.Name.." ("..place.PlaceId..")"
			btn.MouseButton1Click:Connect(function()
				TeleportService:Teleport(place.PlaceId)
				DoNotif("Teleporting To Place: "..place.Name)
			end)
		end
		if page.IsFinished then
			break
		end
		page:AdvanceToNextPageAsync()
	end
end)

NACaller(function()
	local template=UpdLogsLabel
	local list=UpdLogsList

	UpdLogsTitle.Text=UpdLogsTitle.Text.." "..updDate

	if next(updLogs) then
		for name,txt in pairs(updLogs) do
			local btn=template:Clone()
			btn.Parent=list
			btn.Name=name
			btn.Text="-"..txt
		end
	else
	end
end)

--[[ COMMAND BAR BUTTON ]]--
local TextLabelLabel=Instance.new("TextLabel")
local UICorner=Instance.new("UICorner")
local ImageButton=Instance.new("ImageButton")
local UICorner2=Instance.new("UICorner")

--TextLabelLabel.Name=randomString()
NAProtection(TextLabelLabel)
TextLabelLabel.Parent=ScreenGui
TextLabelLabel.BackgroundColor3=Color3.fromRGB(4,4,4)
TextLabelLabel.BackgroundTransparency=1.000
TextLabelLabel.AnchorPoint=Vector2.new(0.5,0.5)
TextLabelLabel.Position=UDim2.new(0.5,0,0.5,0)
TextLabelLabel.Size=UDim2.new(0,2,0,33)
TextLabelLabel.Font=Enum.Font.SourceSansBold
TextLabelLabel.Text=adminName.." V"..curVer
TextLabelLabel.TextColor3=Color3.fromRGB(255,255,255)
TextLabelLabel.TextSize=20.000
TextLabelLabel.TextWrapped=true
TextLabelLabel.ZIndex=9999

--ImageButton.Name=randomString()
NAProtection(ImageButton)
ImageButton.Parent=ScreenGui
ImageButton.AnchorPoint=Vector2.new(0.5,0)
ImageButton.BackgroundColor3=Color3.fromRGB(255,255,255)
ImageButton.BorderSizePixel=0
ImageButton.Position=UDim2.new(0.48909232,0,-1,0)
ImageButton.Size=UDim2.new(0,32,0,33)
ImageButton.Image="rbxassetid://18567102564"
ImageButton.ZIndex=9999


UICorner.CornerRadius=UDim.new(1,0)
UICorner.Parent=ImageButton


UICorner2.CornerRadius=UDim.new(1,0)
UICorner2.Parent=TextLabelLabel

function Swoosh()
	local imagebutton=ImageButton
	imagebutton.Size=UDim2.new(0,32,0,33)
	imagebutton.BackgroundTransparency=0
	imagebutton:TweenPosition(UDim2.new(0.5,0,0,0),"Out","Quint",1,true)
	gui.draggable(imagebutton)
end
function mainNameless()
	local txtlabel=TextLabelLabel
	txtlabel.Size=UDim2.new(0,2,0,33)
	txtlabel.BackgroundTransparency=0.14

	local textWidth=SafeGetService("TextService"):GetTextSize(txtlabel.Text,txtlabel.TextSize,txtlabel.Font,Vector2.new(math.huge,math.huge)).X
	local newSize=UDim2.new(0,textWidth+69,0,33)

	txtlabel:TweenSize(newSize,"Out","Quint",1,true)
	if IsOnMobile then
		Swoosh()
	else
		ImageButton:Destroy()
	end
	wait(2)
	SafeGetService("TweenService"):Create(txtlabel,TweenInfo.new(.7,Enum.EasingStyle.Sine),{BackgroundTransparency=1}):Play()
	local h=SafeGetService("TweenService"):Create(txtlabel,TweenInfo.new(.7,Enum.EasingStyle.Sine),{TextTransparency=1})
	h:Play()
	h.Completed:Connect(function()
		--[[if IsOnMobile then
			Swoosh()
		else
			ImageButton:Destroy()
		end]]
		txtlabel:Destroy()
	end)
end
coroutine.wrap(mainNameless)()

if IsOnMobile then
	ImageButton.MouseButton1Click:Connect(function()
		gui.barSelect()
		cmdInput.Text=''
		cmdInput:CaptureFocus()
	end)
end

--@ltseverydayyou (maxype)
--@MuhXd (Viper)

--original by @qipu | loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))();

NACaller(function()
	local display=Player.DisplayName
	local name=Player.Name
	local hh=nil
	local NAresult=tick()-NAbegin
	if display:lower()==name:lower() then
		hh="@"..name..""
	else
		hh=display.." (@"..name..")"
	end

	delay(0.3,function()
		if identifyexecutor then--idk why i made it as a check
			DoNotif("Welcome to "..adminName.." V"..curVer.."\nExecutor: "..identifyexecutor().."\nUpdated On: "..updDate.."\nTime Taken To Load: "..loadedResults(NAresult),6,rngMsg().." "..hh)
		else
			DoNotif("Welcome to "..adminName.." V"..curVer.."\nUpdated On: "..updDate.."\nTime Taken To Load: "..loadedResults(NAresult),6,rngMsg().." "..hh)
		end
		--DoNotif(goof(),4,"Random Goofy Message")
		DoNotif("Your Keybind Prefix: "..opt.prefix,10,adminName.." Keybind Prefix")
		task.wait(5)
		DoNotif('Added "updlog" command (displays any new changes added into '..adminName..')',3,"Info")
	end)

	cmdInput.PlaceholderText=adminName.." V"..curVer
end)

queueteleport(loader)

print([[0x4]])

task.spawn(function()
	NACaller(function()--better saveinstance support
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/SaveInstance.lua"))();
	end)
end)
