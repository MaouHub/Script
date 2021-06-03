----------------Bypass-------------
local Bypassed = false
function Bypass()
local Client = game.Players.LocalPlayer.Character.Services.Client;
    for _,func in pairs(getgc()) do 
        if type(func)=='function' then
            local scr = getfenv(func).script;
            if scr==Client then
                for idx,const in pairs(debug.getconstants(func)) do 
                    if tostring(const) == "Magnitude" then
                        debug.setconstant(func, idx, "");
                    end
                end;
            end
        end;
    end;
end
Bypass()
local check = true
for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v:FindFirstChild("Main") then
    check = false
        end
     end
spawn(function()
while true do
if check == true then 
    pcall(function()
if Bypassed == true and game.Players.LocalPlayer.CharacterAdded:Wait() then
    Bypassed = false

elseif Bypassed == false then
wait(5)
    Bypass()
end
end)
end
wait(game.Players.LocalPlayer.CharacterAdded:Wait())
end
end)
--[[
GetDescendants
GetChildren
]]
local Edit = false
local VU = game:GetService("VirtualUser")
local camera = workspace.CurrentCamera
local themes = {
Background = Color3.fromRGB(50, 50, 50),
Glow = Color3.fromRGB(0, 30, 255),
Accent = Color3.fromRGB(40, 40, 40),
LightContrast = Color3.fromRGB(50, 50, 50),
DarkContrast = Color3.fromRGB(45, 45, 45),  
TextColor = Color3.fromRGB(0, 255, 255)
}
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MaouStan/FreeScript/main/MaouNewLib.lua"))()
local WS = game.Workspace
local LP = game.Players.LocalPlayer
local UI = lib.new("King Piece")
local weapon,Targets = {},{}
getrenv()._G.RenderDist1 = 20000
--[[==Icon==]]
--[[
Profile = 5012544693
Mics = 5012544961
]]
--[[==Icon==]]
local myPart = Instance.new("Part", workspace)
myPart.CFrame = CFrame.new(6224,28,-2104)
myPart.Size = Vector3.new(1,1,1)
myPart.Transparency = 1
----------------UI Page-----------------------
local M = UI:addPage("AutoFarm", 5012544693)
local Z = UI:addPage("Mics.", 5012544693)
local PP = UI:addPage("LocalPlayer", 5012544693)
local ser = UI:addPage("Setting", 5012544693)
spawn(function()
for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
if v:FindFirstChild("Main") then
    v.Main.Parent.Enabled = false
end
end
end)
----------------Setting-----------------------
local Server = ser:addSection("Server")
Server:addButton("Rejoin",function()
    game:GetService("TeleportService"):Teleport(game.PlaceId , LocalPlayer)
end)
Server:addButton("Server Hop",function()
 local x = {}
	for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
			x[#x + 1] = v.id
		end
	end
	if #x > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
	else
		return notify("Serverhop","Couldn't find a server.")
	end
end)
Server:addKeybind("ToggleUI", Enum.KeyCode.RightControl, function()
	lib:ToggleUI()
end)
Server:addButton("Destroy UI",function()
    lib:DestroyUI()
end)
----------------Main-----------------------
local w = M:addSection("Setting")
local Mobs = {}
local Quest = {}
local NPC = {}
local MonAndBoss = {}
local tar,equ
local af,aq,invis = false,false,false
local QuestM = require(game:GetService("ReplicatedStorage").Modules.QuestManager)

for i,v in pairs(QuestM) do
    Quest[tostring(v.Mob)] = tostring(i)
end
for i,v in pairs(QuestM) do
   NPC[tostring(v.Mob)]  = tostring(v.Level)
end
for i,v in pairs(QuestM) do
   MonAndBoss[tostring(v.Mob)]  = tonumber(v.Ammount)
end
function GetTargetType()
local type
for i,v in pairs(MonAndBoss) do
   if i == tar then
      if v > 1 then
         type = "Mon" 
      elseif v <= 1 then
          type = "Boss" 
      end
   end
end
return type
end
function GetTarget()
    local funmoy = {}
    for i,v in pairs(game:GetService("Workspace").Monster[GetTargetType()]:GetChildren()) do
        if v.Name == tar and v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") then
       table.insert(funmoy,v)
       end
    end
return #funmoy > 0 and funmoy or false
end
function GetNPC()
local NPCN
for i,v in pairs(NPC) do
if tar == tostring(i) then
if tostring(v) == tostring(0) then
    NPCN = "QuestLvl1"
elseif tostring(v) ~= tostring(0) then
    NPCN = "QuestLvl"..v
end
end
end
return NPCN
end
spawn(function()
if Edit == false then
local input = game:GetService("UserInputService")
local con = false
local StarterGui = game.StarterGui
input.InputBegan:connect(function(inp)
if inp.KeyCode == Enum.KeyCode.F9 then
if con == false then
StarterGui:SetCore("DevConsoleVisible",false)
StarterGui:SetCore("DeveloperConsoleVisible",true)
con = true
else
StarterGui:SetCore("DevConsoleVisible",false)
StarterGui:SetCore("DeveloperConsoleVisible",false)
con = false
end
end
end)
end
end)
function GetQuest()
if LP.CurrentQuest.Value == "" then
LP.Character.HumanoidRootPart.CFrame  = game:GetService("Workspace").AntiTPNPC:FindFirstChild(GetNPC()).Head.CFrame
local userdata_1 = game:GetService("Workspace").AntiTPNPC:FindFirstChild(GetNPC());
local Target = game:GetService("ReplicatedStorage").Remotes.Functions.CheckQuest;
Target:InvokeServer(userdata_1);
if pcall(function() return LP.PlayerGui[GetNPC()] end) then
local button = LP.PlayerGui[GetNPC()].Dialogue.Accept
if button.Visible == true  then
button.Position = UDim2.new(-5,0,-5,0)
button.Size = UDim2.new(10,10,10,10)
wait()
VU:CaptureController()
VU:ClickButton1(Vector2.new(0,5))
end
end
elseif LP.CurrentQuest.Value ~= rawget(Quest,tar) then
local button = LP.PlayerGui.Quest.QuestBoard.Close
if button.Visible == true then
button.Position = UDim2.new(-5,0,-5,0)
button.Size = UDim2.new(999,999,9999,999)
wait()
VU:CaptureController()
VU:ClickButton1(Vector2.new(0,5))
wait()
button.Position = UDim2.new(0.876,0,0.045,0)
button.Size = UDim2.new(0.093741,0,0.140079007,0)
end
end
end
for i,v in pairs(QuestM) do
if string.match(v.Mob,"Lv. ") then
   table.insert(Mobs,tostring(v.Mob))
end
end
table.sort(Mobs,function(fi,se)
    return tonumber(rawget(NPC,fi)) < tonumber(rawget(NPC,se))
end)
w:addDropdown("Select Target",Mobs,function(op)
    tar = op
end)
local weapon ={}
local weap
for i,v in pairs(LP.Backpack:GetChildren()) do
    if v:IsA("Tool") and LP.Character.Humanoid.Health > 0 then
         table.insert(weapon, v.Name)
        end
end
for i,v in pairs(LP.Character:GetChildren()) do
    if v:IsA("Tool") and LP.Character.Humanoid.Health > 0 then
         table.insert(weapon, v.Name)
        end
end
local weapons = w:addDropdown("Select Weapon",weapon,function(op)
    weap = op
end)
w:addButton("Refesh Tools Dropdown", function()
weapon = {}
for i,v in pairs(LP.Character:GetChildren()) do
        if v:IsA("Tool") then
        table.insert(weapon,v.Name)
        end
end
for i,v in pairs(LP.Backpack:GetChildren()) do
        if v:IsA("Tool") then
        table.insert(weapon,v.Name)
        end
end
wait()
w:updateDropdown(weapons,"Select Weapon",weapon,function(op)
weap = op
end)
end)
local dis = 4
w:addSlider("Distance ",4,4,10,function(op)
    dis = op
end)
w:addToggle("Buso",false,function(op)
Buso = op
spawn(function()
    while Buso do
pcall(function()
if LP.Character.Haki.Value < 1 and af == true then
LP.Character.Services.Client.Armament:FireServer()
end
end)
        wait()
end
end)
end)
w:addToggle("Ken",false,function(op)
Ken = op
spawn(function()
    while Ken do
pcall(function()
if (LP.Character.KenHaki.Value == 8 or LP.Character.KenHaki.Value == 0) and af == true then
local A_1 = true
LP.Character.Services.Client.KenEvent:InvokeServer(A_1)
end
end)
        wait(0.2)
end
end)
end)
w:addToggle("Invisable",false,function(op)
    invis = op
spawn(function()
    while invis do
pcall(function()
if af == true and pcall(function() return LP.Character.LowerTorso end) and LP.Character.Humanoid.Health > 0  then
repeat
LP.Character.HumanoidRootPart.CFrame = CFrame.new(6224, 28, -2104)     
wait(0.2)
game.Players.LocalPlayer.Character.LowerTorso:Destroy() 
until (myPart.Position - LP.Character.HumanoidRootPart.Position).magnitude <= 10
wait(1.25)
end
end)
        wait()
    end
end)
end)
local po = M:addSection("AutoFarm")
po:addToggle("AutoFarm",false,function(op)
af = op
_G.Noclip = op
spawn(function ()
game:GetService('RunService').Stepped:connect(function()
if _G.Noclip == true and LP.Character.Humanoid.Health > 0 then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
end)
spawn(function()
while af do
pcall(function()
    for i,v in pairs(GetTarget()) do
       while af and v.Humanoid.Health > 0 and LP.Character.Humanoid.Health > 0 do
spawn(function()
if not pcall(function() return LP.Character[weap] end) then
for i,v in pairs(LP.Backpack:GetChildren()) do
    if v.Name == weap then
v.Parent = LP.Character
end
end
else
spawn(function()
if (v.Head.Position - LP.Character.HumanoidRootPart.Position).magnitude <= 20 then
LP.Character[weap]:Activate()
end
end)
end
end)
if LP.CurrentQuest.Value == rawget(Quest,tar) and aq == true and invis == true and not pcall(function() return game.Players.LocalPlayer.Character.LowerTorso end) then
spawn(function()
workspace.CurrentCamera.CameraSubject = v.Humanoid
camera.CFrame = CFrame.new(camera.CFrame.Position,v.HumanoidRootPart.Position)
camera.Focus = CFrame.new(v.HumanoidRootPart.Position)       
end)
spawn(function()
            LP.Character.HumanoidRootPart.CFrame = (v.Head.CFrame*CFrame.new(0,dis,0))*CFrame.Angles(80,0,0)
end) 
elseif aq == false and invis == true and not pcall(function() return game.Players.LocalPlayer.Character.LowerTorso end) then
spawn(function()
workspace.CurrentCamera.CameraSubject = v.Humanoid
camera.CFrame = CFrame.new(camera.CFrame.Position,v.HumanoidRootPart.Position)
camera.Focus = CFrame.new(v.HumanoidRootPart.Position)       
end)
spawn(function()
            LP.Character.HumanoidRootPart.CFrame = (v.Head.CFrame*CFrame.new(0,dis,0))*CFrame.Angles(80,0,0)
end) 
elseif LP.CurrentQuest.Value == rawget(Quest,tar) and aq == true and invis == false then
spawn(function()
workspace.CurrentCamera.CameraSubject = v.Humanoid
camera.CFrame = CFrame.new(camera.CFrame.Position,v.HumanoidRootPart.Position)
camera.Focus = CFrame.new(v.HumanoidRootPart.Position)       
end)
spawn(function()
            LP.Character.HumanoidRootPart.CFrame = (v.Head.CFrame*CFrame.new(0,dis,0))*CFrame.Angles(80,0,0)
end) 
elseif aq == false and invis == false then
spawn(function()
workspace.CurrentCamera.CameraSubject = v.Humanoid
camera.CFrame = CFrame.new(camera.CFrame.Position,v.HumanoidRootPart.Position)
camera.Focus = CFrame.new(v.HumanoidRootPart.Position)       
end)
spawn(function()
            LP.Character.HumanoidRootPart.CFrame = (v.Head.CFrame*CFrame.new(0,dis,0))*CFrame.Angles(80,0,0)
end) 
end
wait()
       end
workspace.CurrentCamera.CameraSubject = LP.Character.Humanoid
    end
end)
    wait()
end
end)
wait()
spawn(function()
if op == false then
workspace.CurrentCamera.CameraSubject = LP.Character.Humanoid
end    
end)
end)
po:addToggle("AutoQuest",false,function(op)
aq = op
spawn(function()
    while aq do
pcall(function()
GetQuest()
end)
pcall(function()
for i,v in pairs(LP.PlayerGui:GetChildren()) do
if string.match(v.Name,"QuestL") and v.Name ~= GetNPC() then
local button = v.Dialogue.Decline
if button.Visible == true  then
button.Position = UDim2.new(-5,0,-5,0)
button.Size = UDim2.new(999,999,1,70)
wait()
VU:CaptureController()
VU:ClickButton1(Vector2.new(0,5))
end
       end
    end
end)
wait()
end
end)
end)
local sk = M:addSection("Skills")
sk:addToggle("Skill Z",false,function(op)
sz = op
spawn(function()
    while sz do
pcall(function()
for i,v in pairs(GetTarget()) do
    spawn(function()
if (v.Head.Position - LP.Character.HumanoidRootPart.Position).magnitude <= 15 and af == true then
local Skill = {game.Players.LocalPlayer:GetMouse().Hit, "Down"}
for i,z in pairs(Skill) do
spawn(function()
local A_1 = z
LP.Character[weap]:FindFirstChild("Z"):InvokeServer(A_1)
end)
end
end
end)
end
end)
        wait()
    end
end)
end)
sk:addToggle("Skill X",false,function(op)
sx = op
spawn(function()
    while sx do
pcall(function()
for i,v in pairs(GetTarget()) do
    spawn(function()
if (v.Head.Position - LP.Character.HumanoidRootPart.Position).magnitude <= 15 and af == true then
local Skill = {game.Players.LocalPlayer:GetMouse().Hit, "Down"}
for i,z in pairs(Skill) do
spawn(function()
local A_1 = z
LP.Character[weap]:FindFirstChild("X"):InvokeServer(A_1)
end)
end
end
end)
end
end)
        wait()
    end
end)
end)
sk:addToggle("Skill C",false,function(op)
sc = op
spawn(function()
    while sc do
pcall(function()
for i,v in pairs(GetTarget()) do
    spawn(function()
if (v.Head.Position - LP.Character.HumanoidRootPart.Position).magnitude <= 15 and af == true then
local Skill = {game.Players.LocalPlayer:GetMouse().Hit, "Down"}
for i,z in pairs(Skill) do
spawn(function()
local A_1 = z
LP.Character[weap]:FindFirstChild("C"):InvokeServer(A_1)
end)
end
end
end)
end
end)
        wait()
    end
end)
end)
sk:addToggle("Skill V",false,function(op)
sv = op
spawn(function()
    while sv do
pcall(function()
for i,v in pairs(GetTarget()) do
    spawn(function()
if (v.Head.Position - LP.Character.HumanoidRootPart.Position).magnitude <= 15 and af == true then
local Skill = {game.Players.LocalPlayer:GetMouse().Hit, "Down"}
for i,z in pairs(Skill) do
spawn(function()
local A_1 = z
LP.Character[weap]:FindFirstChild("V"):InvokeServer(A_1)
end)
end
end
end)
end
end)
        wait()
    end
end)
end)
sk:addToggle("Skill B",false,function(op)
sb = op
spawn(function()
    while sb do
pcall(function()
for i,v in pairs(GetTarget()) do
    spawn(function()
if (v.Head.Position - LP.Character.HumanoidRootPart.Position).magnitude <= 15 and af == true then
local Skill = {game.Players.LocalPlayer:GetMouse().Hit, "Down"}
for i,z in pairs(Skill) do
spawn(function()
local A_1 = z
LP.Character[weap]:FindFirstChild("B"):InvokeServer(A_1)
end)
end
end
end)
end
end)
        wait()
    end
end)
end)
sk:addToggle("Skill E",false,function(op)
se = op
spawn(function()
    while se do
pcall(function()
for i,v in pairs(GetTarget()) do
    spawn(function()
if (v.Head.Position - LP.Character.HumanoidRootPart.Position).magnitude <= 15 and af == true then
local Skill = {game.Players.LocalPlayer:GetMouse().Hit, "Down"}
for i,z in pairs(Skill) do
spawn(function()
local A_1 = z
LP.Character[weap]:FindFirstChild("E"):InvokeServer(A_1)
end)
end
end
end)
end
end)
        wait()
    end
end)
end)
local Island = {
    ["Starter"] = "Spawn1",
    ["Pirate"] = "Spawn2",
    ["Soldier"] = "Spawn3",
    ["Snow"] = "Spawn4",
    ["Desert"] = "Spawn5",
    ["Shark"] = "Spawn6",
    ["Chef"] = "Spawn7",
    ["Bubble"] = "Spawn8",
    ["Sky"] = "Spawn9",
    ["Lobby"] = "Spawn10",
    ["Zombie"] = "Spawn11",
    ["War"] = "Spawn12",
    ["Fish"] = "Spawn13"
}
local islands = {}
for i,v in pairs(Island) do
    table.insert(islands,i)
end
local SellerNPC = {}
local Quest = Z:addSection("Etc. Quest")
local EQuest = {}
local QuestM = require(game:GetService("ReplicatedStorage").Modules.QuestManager)
table.insert(EQuest,"FindGoldenKeyQuest")
table.insert(EQuest,"FindDiamondQuest")
table.insert(EQuest,"FindChickenQuest")
table.insert(EQuest,"FindAncientQuest")
local TEQUEST = {
   ["Find 1 Golden Key"] = "Golden Key",
   ["Find 3 Diamonds"] = "Diamond",
   ["Find 3 Fry Chicken"] = "Fry Chicken",
   ["Find 2 Ancient Item"] = "Ancient"
}
local TQuest = {
    ["FindGoldenKeyQuest"] = "Find 1 Golden Key", 
    ["FindDiamondQuest"]  = "Find 3 Diamonds",
    ["FindChickenQuest"] =  "Find 3 Fry Chicken",
    ["FindAncientQuest"] = "Find 2 Ancient Item"
}
local qequ
function GetEtcQuest()
if LP.CurrentQuest.Value == "" then
LP.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").AntiTPNPC[equ].Head.CFrame
wait(0.2)
local userdata_1 = game:GetService("Workspace").AntiTPNPC[equ];
local Target = game:GetService("ReplicatedStorage").Remotes.Functions.CheckQuest;
Target:InvokeServer(userdata_1);
wait()
if pcall(function() return LP.PlayerGui[equ] end) then
local button = LP.PlayerGui[equ].Dialogue.Accept
if button.Visible == true then
button.Position = UDim2.new(-5,0,-5,0)
button.Size = UDim2.new(9999,9999,9999,9999)
wait()
    VU:CaptureController()
    VU:ClickButton1(Vector2.new(0,0))
end
end
elseif LP.CurrentQuest.Value ~= qequ then
local button = LP.PlayerGui.Quest.QuestBoard.Close
if button.Visible == true then
button.Position = UDim2.new(-5,0,-5,0)
button.Size = UDim2.new(99,99,99,99)
wait()
    VU:CaptureController()
    VU:ClickButton1(Vector2.new(0,0))
wait()
button.Position = UDim2.new(0.876,0,0.045,0)
button.Size = UDim2.new(0.093741,0,0.140079007,0)
end
end
end
Quest:addDropdown("Select",EQuest,function(op)
    
equ = op
spawn(function()
wait()
for i,v in pairs(TEQUEST) do
   if i == rawget(TQuest,equ) then 
      qequ = tostring(i)
   end
end
wait()
repeat
pcall(function()
GetEtcQuest()
end)
wait()
until LP.CurrentQuest.Value == qequ
wait()
for i,v in pairs(game:GetService("Workspace").SpawnItem:GetChildren()) do
if rawget(TEQUEST,qequ) == "Ancient" and (v:FindFirstChild("Ancient1") or v:FindFirstChild("Ancient2") or v:FindFirstChild("Ancient3") or v:FindFirstChild("Ancient4")) then
       LP.Character.HumanoidRootPart.CFrame = v:FindFirstChildWhichIsA("Model").Parent.CFrame
       wait(0.2)
       fireclickdetector(v:FindFirstChildWhichIsA("Model").ClickDetector)
       wait(0.1)
    elseif rawget(TEQUEST,qequ) ~= "Ancient" and v:FindFirstChild(rawget(TEQUEST,qequ)) then
       LP.Character.HumanoidRootPart.CFrame = v:FindFirstChildWhichIsA("Model").Parent.CFrame
       wait(0.2)
       fireclickdetector(v:FindFirstChildWhichIsA("Model").ClickDetector)
       wait(0.1)
    end
end

end)
end)
local Npco = {
"WhiteMan",
"ResetStatsShop",
"ARandomFruit",
"BeautyGirl",
"Elite Pirate",
"ARandomAppearance",
"ShopRemoveFruit",
"Traveler",
"RedBirdTalk",
"FatOtaku"
}
for i,v in pairs(game:GetService("Workspace").AntiTPNPC:GetChildren()) do
    if v.Name == "DFruitShop"     then
       v.Name = v.Name..tostring(i)
       table.insert(Npco,v.Name)
    end
end
local TP = Z:addSection("Teleport")
TP:addDropdown("Teleport NPCs",SellerNPC,function(op)
spawn(function()
if op ~= ("BeautyGirl" and "ResetStatsShop" and "Elite Pirate" and "ARandomAppearance" and "ShopRemoveFruit" and "Traveler" and "RedBirdTalk" and "FatOtaku") then
for i,v in pairs(game:GetService("Workspace").AntiTPNPC:GetDescendants()) do
   if v:IsA("StringValue") and v.Name == "NameWeapon" and string.match(v.Parent.Parent.Name,"Shop") and v.Value == op then
       LP.Character.HumanoidRootPart.CFrame = v.Parent.Parent.Head.CFrame
   end
end
else
LP.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").AntiTPNPC:FindFirstChild(op).Head.Position)
end
end)
end)
TP:addDropdown("Teleport Island",islands,function(op)
    is = op
    for i,v in pairs(Island) do
        if i == is then
        tars = rawget(Island,is)
        end
    end
    LP.Character.HumanoidRootPart.CFrame = WS["SpawnPoints"][tars].CFrame
end)
function GetNearShip()
local funmoy = {}
for i,v in pairs(game:GetService("Workspace").ShipSpawnPoints:GetChildren())    do
 if v:FindFirstChild("CoffinBoat") then
    table.insert(funmoy,v.CoffinBoat) 
 end
end
table.sort(funmoy,function(fi,se)
    return (fi.Position - LP.Character.HumanoidRootPart.Position).magnitude < (se.Position - LP.Character.HumanoidRootPart.Position).magnitude
end)
return funmoy[1].Parent.Name
end
local PC = Z:addSection("Player")
local Code = {
"Peodiz",--100K
"BeckyStyle",--100K
"REDBIRD",--350K
"300MVISITS",--100K
"DinoxLive",--100K
"GasGas",--1Gem
"500KFAV",--100K
"SORRYFORSHUTDOWN",--3Gem
"KingPieceComeBack",--100K
}
PC:addButton("Code",function()
spawn(function()
for i,v in pairs(Code) do
local A_1 = v
game:GetService("ReplicatedStorage").Remotes.Functions.redeemcode:InvokeServer(A_1)
end
end)    
end)
PC:addButton("Free Buso & Ken & Soru & CoffinBoat",function()
LP.PlayerStats.RealExpX2.Value = 2
LP.PlayerStats.RealBeliX2.Value = 2
LP.PlayerStats.HAOHAKI.Value= "HAOYOUHAVEIT"
LP.PlayerStats.haogamepass.Value= "HAOYOUHAVEIT"
LP.PlayerStats.BusoShopValue.Value = "BusoHaki"
LP.PlayerStats.KenShopValue.Value = "KenHaki"
LP.PlayerStats.Soru.Value = "Soru"
LP.PlayerStats.CoffinBoat.Value = "true"
end)
PC:addToggle("No Water",false,function(op)
    NW = op
    spawn(function()
    while NW do
pcall(function()
local A_1 = "out"
LP.Backpack.SwimScript.RemoteEvent:FireServer(A_1)
end)
       wait() 
    end
    end)
end)
PC:addButton("Spawn CoffinBoat",function()
local string_1 = "CoffinBoat";
local string_2 = GetNearShip();
local Target = game:GetService("ReplicatedStorage").Remotes.Events.Ship;
Target:FireServer(string_1, string_2);
end)
PC:addSlider("RunSpeed",36,36,200,function(op)
    getrenv()._G.WalkSpeedClient = op
end)
PC:addToggle("Dash No Cooldown",false,function(op)
    dashx = op
spawn(function()
    while dashx do
    pcall(function()
local player = game:service'Players'.LocalPlayer;
local dash = player.Backpack.Dash;
local gep = player.Backpack.GeppoNew
local constCheck = {
    [0.3]=true;
    [0.8]=true;
}
function sDash()
    for _,func in pairs(getgc()) do 
        if type(func)=='function' then
            local scr = getfenv(func).script;
            if scr==dash then
                for idx,const in pairs(debug.getconstants(func)) do 
                    if const == 0.8 then
                        debug.setconstant(func, idx, 0.00001);
                    end;
                end;
            end
        end;
    end;
end;
function UnDash()
    for _,func in pairs(getgc()) do 
        if type(func)=='function' then
            local scr = getfenv(func).script;
            if scr==dash then
                for idx,const in pairs(debug.getconstants(func)) do 
                    if const == 0.00001 then
                        debug.setconstant(func, idx, 0.8);
                    end;
                end;
            end
        end;
    end;
end
        if dashx == true then
            sDash()
        elseif dashx == false then
            UnDash()
        end
    end)
    wait()
    end
    end)
            if dashx == true then
            sDash()
        elseif dashx == false then
            UnDash()
        end
    end)
PC:addToggle("INF Geppo",false,function(op)
    ig = op
    spawn(function()
    while ig do
        LP.Backpack.GeppoNew.cds.Value = 6
        wait()
        end
    end)
end)
TP:addToggle("Bring Fruit",false,function(op)
gt = op
spawn(function()
while gt do
local LP = game.Players.LocalPlayer
local Character = LP.Character
--[[
GetDescendants
GetChildren
firetouchinterest
fireclickdetector
magnitude
FindFirstChildWhichIsA
]]
pcall(function()
    	local Human = LP.Character:FindFirstChildWhichIsA("Humanoid")
	for _, v in ipairs(workspace:GetChildren()) do
		if LP.Character and v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
			Human:EquipTool(v)
			wait(0.15)
			Human:UnequipTools()
		end
	end
end)
pcall(function()
    	local Human = LP.Character:FindFirstChildWhichIsA("Humanoid")
    for i,x in pairs(workspace:GetChildren()) do
     if x:IsA("Folder") then
	for _, v in ipairs(x:GetChildren()) do
		if LP.Character and v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
			Human:EquipTool(v)
			wait(0.15)
			Human:UnequipTools()
		end
	end
     end
end
end)
wait()
end    
end)
end)
----------------LocalPlayer-----------------------
local Player = PP:addSection("Player")
Players = {}
for i,v in pairs(game.Players:GetPlayers()) do
    if v.Name ~= LP.Name then
    table.insert(Players,v.Name)
    end
    end
local dropdown1 = Player:addDropdown("Players", Players, function(op)
_G.Pla = op
LP.Character.HumanoidRootPart.CFrame = game.Players[_G.Pla].Character.HumanoidRootPart.CFrame*CFrame.new(0,10,10)
end)
Player:addButton("Refesh Players Dropdown",function()
    for i,v in pairs(Players) do
        spawn(function()
        table.remove(Players)
        end)
        Players ={}
    end
    for i,v in pairs(game.Players:GetPlayers()) do
        spawn(function()
        if v.Name ~= LP.Name then
        table.insert(Players,v.Name)
        Player:updateDropdown(dropdown1,_G.Pla,Players, function(op)
            _G.Pla = op
            LP.Character.HumanoidRootPart.CFrame = game.Players[_G.Pla].Character.HumanoidRootPart.CFrame*CFrame.new(0,10,10)
            end)
        end
        end)
        end
end)
Player:addSlider("Walkspeed", 16, 16, 150, function(v)
    speed = v
    LP.Character.Humanoid.WalkSpeed = speed
end)
Player:addSlider("JumpPower", 50, 50, 150, function(v)
    JumpPower = v
    LP.Character.Humanoid.JumpPower = JumpPower
end)
------------------------------------------------------
-- GUI End
wait(1)
for i,v in pairs(game:GetService("Workspace").AntiTPNPC:GetDescendants()) do
   if v:IsA("StringValue") and v.Name == "NameWeapon" and string.match(v.Parent.Parent.Name,"Shop") then
      table.insert(SellerNPC,v.Value)
   end
end
for i,v in pairs(Npco) do
   table.insert(SellerNPC,v) 
end
pcall(function()
for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
if v:FindFirstChild("Main") then
    v.Main.Parent.Enabled = true
end
end
wait()
lib:SelectPage(M, true)
end)
