
local MainESP, CullingSystem = loadstring(game:HttpGet('https://raw.githubusercontent.com/Breadido/Main/refs/heads/master/utils/esp/source.lua'))() 
MainESP.Options = {
    Enabled = false,              -- Master toggle for player ESP
    Box = false,                  -- Show bounding boxes
    Health = false,               -- Show health bars
    Tracer = false,               -- Show tracer lines
    TracerOrigin = "Bottom",      -- Tracer origin point
    Name = false,                 -- Show player names
    Distance = false,             -- Show distance
    Direction = false,            -- Show facing direction
    Skeleton = false,             -- Show skeleton
    TextOutline = false,          -- Add text outlines
    Color = Color3.new(1, 1, 1),  -- Default ESP color
    UseTeamColor = true,          -- Use team colors
    Rainbow = false,              -- Rainbow color mode
    Font = 1,                     -- Text font (0-3)
    FontSize = 15,                -- Text size
    TeamCheck = false,            -- Hide teammates
    BoxThickness = 0,             -- Box line thickness
    TracerThickness = 0,          -- Tracer line thickness
    DirectionThickness = 0,       -- Direction arrow thickness
    SkeletonThickness = 0,        -- Skeleton line thickness
}
CullingSystem.maxRenderDistance = 20000
CullingSystem.nearDistance = 10000
CullingSystem.farDistance = 15000

local key, jbremote = loadstring(game:HttpGet('https://raw.githubusercontent.com/Introvert1337/RobloxReleases/refs/heads/main/Scripts/Jailbreak/KeyFetcher.lua'))() -- temporary
local oldjbremote = getupvalue(network.FireServer, 1)
configs = {
    player = {
		walktog = false;
		walkval = 0;
		infjump = false;
		autoescape = false;
		nofall = false;
		norag = false;
		noislow = false;
		nosky = false;
		nostun = false;
		norwait = false;
		nocslow = false;
		nocircwait = false;
		nopwait = false;
		bypasskd = false;
		alwayssilentp = false;
		alwaysp = false;
		alwayssp = false;
		juiced = false;
		crawlequip = false;
		backbone = false;
		dogs = {
			dogshephardsp = 50;
			bulldogsp = 40;
			instantleadattack = false;
			alwaysbarking = false;
		};
	};
    vehicle = {
		fspeed = 10;
		ftog = false;
		fx = 0;
		fy = 0;
		fz = 0; 
		engine = false;
		enginesp = 0;
		brake = false;
		brakesp = 0;
		suspension = false;
		suspensionhe = 0;
		turnsp = 0;
		turn = false;
		inftrac= false;
		reducebounce = false;
		tirepop = false;
		alwayshij = false;
		infnitro = false;
		rinfnitro = false;
		autoflip = false;
		helibreak = false;
		helienginesp = 0;
		heliverticalsp = 0;
		heliturnsp = 0;
		heliengine = false;
		helipick = false;
		-- helivertical = false;
		-- heliturn = false;
		heliheight = false;
		instanttow = false;
		driveonwater = false;
	};
    combat = {
		hitboxradius = 3;
		noequipt = false;
		nospread = false;
		norecoil = false;
		nobulletg = false;
		alwaysauto = false;
		alwaysheadshot = false;
		pistolswat = false;
		snipernoblur = false;
		snipernogui = false;
		wallbang = false;
		nogrenadesmoke = false;
		tasermodz = false;
		instantrocketseek = false;
		forcefieldnomiss = false;
		increasetakedowndamage = false;
		increaseforcedamage = false;
		forcefieldreload = false;
		shootthroughforce =false;
		instantc4throw = false;
		antic4limit = false;
		instantbullethit = false;
		silentaim = {
			enabled = false;
			includetaser = false;
			includeplasma = false;
			radius = 250;
			wallcheck = false;
			fovcirc = false;
			fovthick = 5;
			fovtransp = 0;
		};
		arrestaura = {
			enabled = false;
			showtargeted = false;
		};
		batonsword = {
			noreloadtime = false;
			spamlunge = false;
			spamswoosh = false;
		};
	};
    teleportation = {}; -- soon not yet lmfao
    robberies = {
		guardnodmg = false;
	};
    nametags = {};
	others = {
		disablehometurret = false;
	};
}
local client = {
	tankdata = {};
	lastvehiclestats = {
		GarageEngineSpeed = nil;
		Height = nil;
		TurnSpeed = nil;
	};
	lastvehiclemodel = nil;
	vehicleEntered = false;
	originalequippeddata = {};
	doorAddedFunction = getconnections(game:GetService("CollectionService"):GetInstanceAddedSignal("Door"))[1].Function;
	activeaction = {};
	ori = {
		hookNearest = require(game:GetService("ReplicatedStorage").VehicleLink.VehicleLinkBinder)._constructor._hookNearest;
		bulletemitteronlocalhitplayer = require(game:GetService("ReplicatedStorage").Game.Item.Gun).BulletEmitterOnLocalHitPlayer;
		updateseeking = require(game:GetService("ReplicatedStorage").VehicleLink.VehicleLinkBinder)._constructor._updateSeeking;
		hittargetwithspeed = require(game:GetService("ReplicatedStorage").Module.SimulatedPhysicsProjectile).HitTargetWithSpeed;
		isflying = require(game:GetService("ReplicatedStorage").Game.Paraglide).IsFlying;
		tase = require(game:GetService("ReplicatedStorage").Game.Item.Taser).Tase;
		doesplayerowncached = require(game:GetService("ReplicatedStorage").Game.Gamepass.GamepassSystem).doesPlayerOwnCached;
		update = require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Update;
		getequiptime = require(game:GetService("ReplicatedStorage").Game.GunShop.GunUtils).getEquipTime;
		rayignorenon = require(game:GetService("ReplicatedStorage").Module.RayCast).RayIgnoreNonCollide;
		plasmashootother = require(game:GetService("ReplicatedStorage").Game.Item.PlasmaGun).ShootOther;
		pistolsetupmodel = require(game:GetService("ReplicatedStorage").Game.Item.Pistol).SetupModel;
		rayignore = require(game:GetService("ReplicatedStorage").Module.RayCast).RayIgnoreNonCollideWithIgnoreList;
		shoot = require(game:GetService("ReplicatedStorage").Game.Item.Gun).Shoot;
		attemptToggleCrawling = getupvalue(require(game:GetService("ReplicatedStorage").Game.DefaultActions).crawlButton.onPressed,1).attemptToggleCrawling;
	};
	simulatedphysicsprojectile = require(game:GetService("ReplicatedStorage").Module.SimulatedPhysicsProjectile);
	guardnpcbinder = require(game:GetService("ReplicatedStorage").GuardNPC.GuardNPCBinder);
	combatconst = require(game:GetService("ReplicatedStorage").Combat.CombatConsts);
	militaryturretconst= require(game:GetService("ReplicatedStorage").Game.MilitaryTurret.MilitaryTurretConsts);
	dogconst = require(game:GetService("ReplicatedStorage").Game.Dog.DogConsts);
	combatutils = require(game:GetService("ReplicatedStorage").Combat.CombatUtils);
	playerutil = require(game:GetService("ReplicatedStorage").Game.PlayerUtils);
	actionbuttonservice = require(game:GetService("ReplicatedStorage").ActionButton.ActionButtonService);
	settingss = require(game:GetService("ReplicatedStorage").Resource.Settings);
	characterutil = require(game:GetService("ReplicatedStorage").Game.CharacterUtil);
	paraglide = require(game:GetService("ReplicatedStorage").Game.Paraglide);
	alexchassis = require(game:GetService("ReplicatedStorage").Module.AlexChassis);
	dog = require(game:GetService("ReplicatedStorage").Game.Dog.Dog);
    dogsystem = require(game:GetService("ReplicatedStorage").Game.Dog.DogSystem);
	itemgun = require(game:GetService("ReplicatedStorage").Game.Item.Gun);
	itemsys = require(game:GetService("ReplicatedStorage").Game.ItemSystem.ItemSystem);
	gunutil = require(game:GetService("ReplicatedStorage").Game.GunShop.GunUtils);
	gamepasssystem = require(game:GetService("ReplicatedStorage").Game.Gamepass.GamepassSystem);
	pistolitem = require(game:GetService("ReplicatedStorage").Game.Item.Pistol);
	smokegrenadeitem = require(game:GetService("ReplicatedStorage").Game.SmokeGrenade.SmokeGrenade);
	movementrollservice = require(game:GetService("ReplicatedStorage").MovementRoll.MovementRollService);
	circleac = require(game:GetService("ReplicatedStorage").Module.UI).CircleAction;
	tase = require(game:GetService("ReplicatedStorage").Game.Item.Taser);
	plasmagun = require(game:GetService("ReplicatedStorage").Game.Item.PlasmaGun);
	geomUtils = require(game:GetService("ReplicatedStorage"):WaitForChild("Std"):WaitForChild("GeomUtils"));
    vehiclelinkbinder = require(game:GetService("ReplicatedStorage").VehicleLink.VehicleLinkBinder);
	duck = require(game:GetService("ReplicatedStorage").Game.Robbery.TombRobbery.TombRobberySystem).duck;
	onvehicleentered = require(game:GetService("ReplicatedStorage").Vehicle.VehicleUtils).OnVehicleEntered;
	onvehicleexited = require(game:GetService("ReplicatedStorage").Vehicle.VehicleUtils).OnVehicleExited;
	onlocalitemequipped = require(game:GetService("ReplicatedStorage").Game.ItemSystem.ItemSystem).OnLocalItemEquipped;
	onlocalitemunequipped = require(game:GetService("ReplicatedStorage").Game.ItemSystem.ItemSystem).OnLocalItemUnequipped;
	raycast = require(game:GetService("ReplicatedStorage").Module.RayCast);
	bulletemitter = require(game:GetService("ReplicatedStorage").Game.ItemSystem.BulletEmitter);
	c4 = require(game:GetService("ReplicatedStorage").Game.Item.C4);
	wheel = require(game:GetService("ReplicatedStorage").Module.Wheel.Wheel);
	localization = require(game:GetService("ReplicatedStorage").Module.Localization);
	rocketconsts = require(game:GetService("ReplicatedStorage").RocketLauncher.RocketLauncherConsts);
}

client.getnumactivec4 = getupvalue(client.c4.ShootBegin, 4)
client.gethrowablesmokegrenade = getupvalue(require(game:GetService("ReplicatedStorage").Game.Item.SmokeGrenade).ShootBegin, 1)
client.getnearestplayer = getupvalue(require(game:GetService("ReplicatedStorage").Home.HomeItem.Fabricate.Turret).setup, 12)

client.rollratelimiter = getupvalue(client.movementrollservice.attemptRoll, 6)
client.vclasses = getupvalue(client.alexchassis.UpdateEngine, 19).Classes
client.ori.heliupdate = client.vclasses.Heli.Update
client.door = {
	openDoor = getupvalue(getproto(getupvalue(client.doorAddedFunction, 2), 1, true)[1], 7);
	doors = getupvalue(client.doorAddedFunction, 1);
}

setreadonly(client.combatconst, isreadonly(client.combatconst) and false)
setreadonly(client.militaryturretconst, isreadonly(client.militaryturretconst) and false)
setreadonly(client.dogconst, isreadonly(client.dogconst) and false)
setreadonly(client.rocketconsts, isreadonly(client.rocketconsts) and false)

-- i realized that i can just do table value storing but uhhh yea uhh yea uh u-u-u-ultraman
local itemConfigClone = game:GetService("ReplicatedStorage").Game.ItemConfig:Clone()
itemConfigClone.Name = "ItemConfigBackup"

local Circle = MainESP.CreateCircle()
Circle.Radius = configs.combat.silentaim.radius
Circle.Color = Color3.fromRGB(255,255,255)
Circle.Position = MainESP.TracerOrigins.Middle
Circle.NumSides = 50

for i,v in next, getgc() do 
	if type(v) == "function" and islclosure(v) then
		local infoname = tostring(getinfo(v).name) 
		if tostring(getfenv(v).script) == "LocalScript" then
			if table.find(getconstants(v), "StartRagdolling") then
				client.stunnedragdoll = v
			end
			if infoname == "AttemptArrest" then 
				client.attemptarrest = v
			end
			if infoname == "StartNitro" then
				client.startnitro = v
				client.nitro = getupvalue(v, 8)
			end
			if infoname == "StopNitro" then
				client.stopnitro = v
			end
			if infoname:find("CheatCheck") then -- shit didn't work
				hookfunction(v, function()  end)
			end
		end
	end
end

for i,v in next, getconnections(game:GetService("RunService").Heartbeat) do
    if v.Function and islclosure(v.Function) then
        if getconstants(v.Function)[13] == "Time/UI" then
            client.walkspeedfun = getupvalue(v.Function,6)
        end
    end
end

for i,v in next, client.actionbuttonservice.active do
	if table.find(v.keyCodes, Enum.KeyCode.V) then
		client.activeaction.flip = v
	end
	if table.find(v.keyCodes, Enum.KeyCode.LeftControl) then
		client.activeaction.roll = v
	end
end

client.duckLoop = (function()
	repeat 
		client.duck()
		task.wait(2)
	until configs.player.backbone == false
end)

client.flipLoop = (function()
	repeat task.wait(.1)
		pcall(function()
			for i,v in next, client.actionbuttonservice.active do
				if table.find(v.keyCodes, Enum.KeyCode.V) then
					v.onPressed(true)
				end
			end
		end)
	until configs.vehicle.autoflip == false
end)
client.hasKeyHook = (function(boolean)
	if boolean then
		hookfunction(client.playerutil.hasKey, function()
			return true
		end)
	else
		if isfunctionhooked(client.playerutil.hasKey) then restorefunction(client.playerutil.hasKey) end
	end
end)
client.smokeGrenadeHook = (function(boolean)
	if boolean then
		hookfunction(client.smokegrenadeitem._playExplosionFx, function() end)
	else
		if isfunctionhooked(client.smokegrenadeitem._playExplosionFx) then restorefunction(client.smokegrenadeitem._playExplosionFx) end
	end
end)
client.getNearestPlayerHook = (function(boolean)
	if boolean then
		hookfunction(client.getnearestplayer, function() return nil end)
	else
		if isfunctionhooked(client.smokegrenadeitem.getnearestplayer) then restorefunction(client.smokegrenadeitem.getnearestplayer) end
	end
end)
client.isCrawlingLoop = (function()
	repeat task.wait(.1)
		client.characterutil.IsCrawling = false
	until configs.player.crawlequip == false
end)
client.hijackLoop = (function()
	repeat task.wait(.1)
		for i,v in next, client.circleac.Specs do
			if v.Name == client.localization:FormatByKey("Action.Hijack") then
				v:Callback(true)
			end
		end
	until configs.vehicle.alwayshij == false
end)
client.nitroLoop = (function()
	repeat task.wait()
		client.nitro.NitroLastMax = 250
		client.nitro.Nitro = configs.vehicle.rinfnitro and math.random(10, 249) or 249
		client.nitro.NitroForceUIUpdate = true
	until configs.vehicle.infnitro == false
end)
client.sprintLoop = (function()
	repeat task.wait()
		setupvalue(client.walkspeedfun, 9, true)
	until not configs.player.alwayssp
end)
client.launchVehicleFlight = (function()
	local BodyGyro = Instance.new("BodyGyro", game:GetService("Players").LocalPlayer.Character.HumanoidRootPart)
	local BodyVelocity = Instance.new("BodyVelocity", game:GetService("Players").LocalPlayer.Character.HumanoidRootPart)
	local Camera = workspace.CurrentCamera
	BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	BodyGyro.D = 50000
	BodyGyro.P = 1500000000
	repeat task.wait()
		BodyGyro.CFrame = Camera.CFrame * CFrame.Angles(math.rad(configs.vehicle.fx), math.rad(configs.vehicle.fy), math.rad(configs.vehicle.fz))
		workspace.CurrentCamera.CameraType = Enum.CameraType.Track
		BodyVelocity.Velocity = Vector3.new()
		local direction = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector()
		if direction.X > 0 then
			BodyVelocity.Velocity = BodyVelocity.Velocity + Camera.CFrame.RightVector * direction.X
		end
		if direction.X < 0 then
			BodyVelocity.Velocity = BodyVelocity.Velocity + Camera.CFrame.RightVector * direction.X
		end
		if direction.Z > 0 then
			BodyVelocity.Velocity = BodyVelocity.Velocity - Camera.CFrame.LookVector * direction.Z
		end
		if direction.Z < 0 then
			BodyVelocity.Velocity = BodyVelocity.Velocity - Camera.CFrame.LookVector * direction.Z
		end
		BodyVelocity.Velocity = BodyVelocity.Velocity * configs.vehicle.fspeed
	until client.vehicleEntered == false or configs.vehicle.ftog == false
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	BodyGyro:Destroy()
	BodyVelocity:Destroy()
end)
client.getOldWeaponData = (function(name, dataname)
	return rawget(require(itemConfigClone[name]), dataname)
end)
client.setBatonSwordTime = (function(bool)
	local baton = require(game:GetService("ReplicatedStorage").Game.Item.Baton)
	local sword = require(game:GetService("ReplicatedStorage").Game.Item.Sword)
	getupvalue(baton.new,2).ReloadTime = bool and 0 or 0.5
	getupvalue(sword.new,2).ReloadTime = bool and 0 or 0.5
end)
client.spamBatonSwordSwoosh = (function()
	repeat task.wait()
		local a = client.itemsys.GetLocalEquipped()
		if a and (a.__ClassName == "Sword" or a.__ClassName == "Baton") then
			require(game:GetService("ReplicatedStorage").Game.Item[a.__ClassName]).SwingSwoosh(a)
		end
	until configs.combat.batonsword.spamswoosh == false
end)
client.spamBatonSwordLunge = (function()
	repeat task.wait()
		local a = client.itemsys.GetLocalEquipped()
		if a and (a.__ClassName == "Sword" or a.__ClassName == "Baton") then
			require(game:GetService("ReplicatedStorage").Game.Item[a.__ClassName]).SwingLunge(a)
		end
	until configs.combat.batonsword.spamlunge == false
end)

client.notInWall = (function(i,v,wallCheck)
	if wallCheck then
        local ray = Ray.new(game:GetService("Workspace").CurrentCamera.CFrame.p, i - game:GetService("Workspace").CurrentCamera.CFrame.p)
        local result = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(ray, v)
        return result == nil
    else
        return true
    end
end)

client.isEnemies = (function(a,b)
    local a, b = tostring(a), tostring(b)
    if a == "Criminal" and b == "Police" then
        return true
    elseif a == "Criminal" and b == "Prisoner" then
        return false
    elseif a == "Police" and b == "Criminal" then
        return true
    elseif a == "Police" and b == "Prisoner" then
        return false
    elseif a == "Prisoner" and b == "Police" then
        return true
    elseif a == "Prisoner" and b == "Criminal" then
        return false
    end
end)
client.getNearestToCursor = (function()
    local Target = nil
	local notInWall = client.notInWall
	local isEnemies = client.isEnemies
	local middlepos = MainESP.TracerOrigins.Middle
    for i,v in next, game:GetService("Players"):GetPlayers() do
        if isEnemies(game:GetService("Players").LocalPlayer.Team, v.Team) and v ~= game:GetService("Players").LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 then
			local magnitude = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
			if magnitude < 300 then -- max bullet distance of all gun is probably around 300 studs. correct me if i'm wrong please
				local Point, OnScreen = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
				if OnScreen and notInWall(v.Character.HumanoidRootPart.Position,{game:GetService("Players").LocalPlayer.Character, v.Character}, configs.combat.silentaim.wallcheck) then
					local Distance =(Vector2.new(Point.X, Point.Y) - Vector2.new(middlepos.X, middlepos.Y)).magnitude
					if Distance < configs.combat.silentaim.radius then
						Target = v
						return Target
					end
				end
			end
        end
    end
    return Target
end)
client.getDog = (function()
    for i,v in next, client.dogsystem.getAll() do
        if tostring(client.dog.GetOwner(v)) == game:GetService("Players").LocalPlayer.Name then
            return v   
        end
    end
    return nil
end)
client.getPlayerVehicle = (function(plrname)
	local uh = nil
	for i,v in next, game:GetService("CollectionService"):GetTagged("Vehicle") do
		for i2,v2 in next, v:GetChildren() do
			if v2.Name == "Seat" or v2.Name == "Passenger" then
				local whateverSeatName = v2:FindFirstChild("PlayerName")
				if whateverSeatName and whateverSeatName.Value == plrname then
					return uh
				end
			end
		end
	end
	return uh
end)

client.getNearestVehicle = (function()
	local char = game:GetService("Players").LocalPlayer.Character
	local target, distance = nil, 100
	for i,v in next, game:GetService("CollectionService"):GetTagged("Vehicle") do
		if v:FindFirstChild("Seat") or v:FindFirstChild("Passenger") then
			local targetDistance = (char:FindFirstChild("HumanoidRootPart").Position-v:GetModelCFrame().Position).magnitude
			if targetDistance < distance then
				distance = targetDistance
				target = v
			end
		end
	end
	return target
end)

client.getNearestPlayerNoCuffed = (function() 
    local maxdistance = 18
    local player = nil;
    for i,v in next, game:GetService("Players"):GetPlayers() do
        if tostring(v.Team) == "Criminal" then
            local character = v.Character or nil
            if character ~= nil and not v.Character:GetAttribute("Handcuffs") then
                local hrp = character:FindFirstChild("Head") or nil
                local hum = character:FindFirstChild("Humanoid") or nil
                if hrp ~= nil and hum ~= nil then
                    local mag = (game:GetService("Players").LocalPlayer.Character:GetModelCFrame().Position - hrp.Position).magnitude
                    if mag < maxdistance then
                        player = v
                        if player ~= nil then
                            return player
                        end
                    end
                end
            end
        end
    end
	return false
end)
client.launchArrestAura = (function()
	local getNearestPlayerNoCuffed = client.getNearestPlayerNoCuffed
	repeat task.wait(0.15)
        pcall(function()
            local plr = getNearestPlayerNoCuffed()
            if plr then
                client.attemptarrest(game:GetService("Players"):FindFirstChild(tostring(plr)))		
                --print(game:GetService("Players"):FindFirstChild(tostring(plr)))	
            end
        end)
	until configs.combat.arrestaura.enabled == false
end)

client.updateToOriginalChassisStats = (function()
	local gvp = require(game:GetService("ReplicatedStorage").Vehicle.VehicleUtils).GetLocalVehiclePacket() 
	if gvp ~= nil and client.lastvehiclestats ~= nil and client.lastvehiclemodel ~= nil and gvp.Model ~= gvp.lastvehiclemodel then
		local stats = client.lastvehiclestats
		if configs.vehicle.engine == false then
			gvp.GarageEngineSpeed = stats.GarageEngineSpeed
		end
		-- if configs.vehicle.brake == false then
		-- 	gvp.GarageBrakes = stats.GarageBrakes
		-- end
		if configs.vehicle.suspension == false then
			gvp.Height = stats.Height
		end
		if configs.vehicle.turn == false then
			gvp.TurnSpeed = stats.TurnSpeed
		end
	end

end)

client.changeHitboxRadius = (function(radius)
	-- setreadonly(client.combatconst, isreadonly(client.combatconst) and false)
	-- client.combatconst.DEFAULT_ROOT_PART_HIT_RADIUS = radius
end)

client.onHitSurfaceHook = (function()
	local a = client.itemsys.GetLocalEquipped()
	a.FakeName = "Sniper"
	if configs.combat.increasetakedowndamage and a.BulletEmitter ~= nil then
		for i,v in next, getconstants(a.BulletEmitter.OnHitSurface._handlerListHead._fn) do
			if v == "__ClassName" then
				setconstant(a.BulletEmitter.OnHitSurface._handlerListHead._fn, i, "FakeName")
			end
		end			
	elseif configs.combat.increasetakedowndamage == false and a.BulletEmitter ~= nil then
		for i,v in next, getconstants(a.BulletEmitter.OnHitSurface._handlerListHead._fn) do
			if v == "FakeName" then
				setconstant(a.BulletEmitter.OnHitSurface._handlerListHead._fn, i, "__ClassName")
			end
		end			
	end
end)

task.spawn(function()
	-- Hooking
    hookfunction(getcallbackvalue(game:GetService("ReplicatedStorage").HawkeyeRemoteFunction, "OnClientInvoke"), function() end)
	local old
	old = hookfunction(Instance.new("RemoteEvent").FireServer, function(...)
		local args = {...}
		if #args == 4 and debug.traceback():find("LocalScript:1349") then
			getgenv().acbypassed = true
			return
		end
		return old(...)
	end)
	client.simulatedphysicsprojectile.HitTargetWithSpeed = (function(...)
		local args = {...}
		if configs.combat.forcefieldnomiss and args[3] == 75 then
			args[3] = 1
		end
		return client.ori.hittargetwithspeed(unpack(args))
	end)	

	client.itemgun.BulletEmitterOnLocalHitPlayer = (function(...)
		local args = {...}
		if configs.combat.alwaysheadshot then
			args[15].isHeadshot = true
			args[15].isWallbang = false
		end
		return client.ori.bulletemitteronlocalhitplayer(unpack(args))
	end)

	client.itemgun.Shoot = (function(self,a)
		if configs.combat.silentaim.enabled then
			local character = client.getNearestToCursor() and client.getNearestToCursor().Character
			local hrp = character and character:FindFirstChild("HumanoidRootPart")
			if hrp then
				self.TipDirection = (hrp.Position - self.Tip.Position).Unit
			end
		end
		local oldLastUpdate = self.BulletEmitter.LastUpdate
		self.BulletEmitter.LastUpdate = configs.combat.instantbullethit and -9e9 or oldLastUpdate
		client.ori.shoot(self, a)
	end)

	client.plasmagun.ShootOther = (function(self,a)
		if configs.combat.silentaim.enabled and configs.combat.silentaim.includeplasma then
			local character = client.getNearestToCursor() and client.getNearestToCursor().Character
			local hrp = character and character:FindFirstChild("HumanoidRootPart")
			if hrp then
				self.TipDirection = (hrp.Position - self.Tip.Position).Unit
			end
		end
		client.ori.plasmashootother(self,a)
	end)

	client.tase.Tase = (function(self,...)
		if configs.combat.tasermodz then 
			self._lastDraw = 0 
		end
		return client.ori.tase(self,...)
	end)

	client.raycast.RayIgnoreNonCollideWithIgnoreList = (function(...)
		-- yes this is actually from min & brizzy silent aim script cuz i'm starting to get lazy soo yea credits to him!
		-- maybe if i'm not lazy then i will start to make my own
		if debug.traceback():find("Taser") and configs.combat.silentaim.enabled and configs.combat.silentaim.includetaser then
			local character = client.getNearestToCursor() and client.getNearestToCursor().Character
			local hrp = character and character:FindFirstChild("HumanoidRootPart")
			if hrp then
				return hrp, hrp.Position, hrp.Position, ... -- not doing args table thing cuz that didn't work for some reason (skill issue tbh)
			end
		end
		return client.ori.rayignore(...)
	end)

	client.raycast.RayIgnoreNonCollide = (function(...)
		local args = {...}
		if configs.vehicle.driveonwater and debug.traceback():find("AlexChassis") then
			args[6] = true
		end
		return client.ori.rayignorenon(unpack(args))
	end)

	client.gamepasssystem.doesPlayerOwnCached = (function(...)
		local args = {...}
		if configs.combat.pistolswat and tostring(args[1]) == game:GetService("Players").LocalPlayer.Name and debug.traceback():find("tem.Pistol") then
			return true
		end
		return client.ori.doesplayerowncached(...)
	end)

	client.gunutil.getEquipTime = (function(...)
		return configs.combat.noequipt and 0 or client.ori.getequiptime(...)
	end)

	client.circleac.Update = (function(...) -- i might change it later 
		local uh = ...
		pcall(function()
			client.ori.update(uh)
			if configs.player.nocircwait then
				client.circleac.Spec.PressedAt = 0.01
			end
		end)
	end)

	client.paraglide.IsFlying = (function(...)
		return configs.player.nosky and debug.traceback():find("Falling") and true or client.ori.isflying(...)
	end)

	client.vehiclelinkbinder._constructor._hookNearest = (function(...)
		local args = {...}
		local rope = args[1].obj
		local obj = args[1].nearestObj
		local requestLink = args[1].manifest.reqLinkRemote
		if configs.vehicle.helipick and rope.Name == "RopePull" then
			local cf = obj.PrimaryPart.CFrame:PointToObjectSpace(client.geomUtils.closestPointInPart(obj.PrimaryPart, rope.Position), rope.Position)
			requestLink:FireServer(obj, cf)
			return
		elseif configs.vehicle.instanttow and rope.Name == "MetalHook" then
			local cf = obj.PrimaryPart.CFrame:PointToObjectSpace(client.geomUtils.closestPointInPart(obj.PrimaryPart, rope.Position), rope.Position)
			requestLink:FireServer(obj, cf)
			return
		end
		return client.ori.hookNearest(...)
	end)

	client.vclasses.Heli.Update = (function(self,...)
		--Vector3.new(configs.vehicle.helienginesp, configs.vehicle.heliverticalsp, configs.vehicle.helienginesp)
		client.ori.heliupdate(self,...)
		if configs.vehicle.heliengine then
			self.Velocity.Velocity *= Vector3.new(configs.vehicle.helienginesp,  configs.vehicle.heliverticalsp, configs.vehicle.helienginesp)
			--self.Rotate.AngularVelocity *= Vector3.new(configs.vehicle.heliturnsp, configs.vehicle.heliturnsp, configs.vehicle.heliturnsp)
		end
	end)

	-- game:GetService("Players").LocalPlayer:GetMouse().Move:Connect(function()
	-- 	local Mouse = game:GetService"UserInputService":GetMouseLocation()
	-- 	Circle.Position = Vector2.new(Mouse.X, Mouse.Y)
	-- end)
    game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
        local hrp = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        if hrp then
            if configs.player.nofall then 
                hrp:AddTag("NoFallDamage")
			end
            if configs.player.norag then
                hrp:AddTag("NoRagdoll")
            end
        end
		--[[
		task.wait(0.1)
		for i,v in next, getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid.StateChanged) do -- useless
			if v.Function ~= nil and tostring(getfenv(v.Function).script) == "LocalScript" then
				setconstant(v.Function, 2, "EasingStyle") -- i did this cuz it's funni :>
				setconstant(v.Function, 3, "Linear")
			end
		end
		--]]
    end)
	game:GetService("UserInputService").JumpRequest:Connect(function()
		if configs.player.infjump then
			game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
		end
	end)
	game.Lighting.ChildAdded:connect(function(mama)
		if configs.combat.snipernoblur and mama.Name == "Blur" then
			mama:GetPropertyChangedSignal("Size"):connect(function()
				mama.Enabled = false
			end)
		end
	end)
	client.onvehicleentered:Connect(function(arg1)
		client.vehicleEntered = true
		if arg1.Model ~= client.lastvehiclemodel and arg1.Type == "Chassis" then
			client.lastvehiclemodel = arg1.Model
			client.lastvehiclestats.GarageEngineSpeed = arg1.GarageEngineSpeed
			client.lastvehiclestats.TurnSpeed = arg1.TurnSpeed
			client.lastvehiclestats.Height = arg1.Height
		end
		if configs.vehicle.ftog then
			client.launchVehicleFlight()
		end
		if arg1.Type == "Heli" then
			arg1.MaxHeight = configs.vehicle.heliheight and 9e9 or 400
			arg1.FallOutOfSkyDuration = configs.vehicle.helibreak and 0 or 10
			arg1.DisableDuration = configs.vehicle.helibreak and 0 or 10
		elseif arg1.Type == "Chassis" then
			arg1.TirePopDuration = configs.vehicle.nopop and 0 or 7.5
			arg1.DisableDuration = configs.vehicle.nopop and 0 or 7.5
			arg1.TirePopProportion = configs.vehicle.nopop and 0 or 0.5
		end
	end)
	client.onvehicleexited:Connect(function()
		client.vehicleEntered = false
	end)
	client.onlocalitemequipped:Connect(function(equippeddata) 
		--client.originalequippeddata = equippeddata
		local getdata = client.getOldWeaponData
		local a = client.itemsys.GetLocalEquipped()
		a.FakeName = "Sniper"
		task.spawn(function()
			client.onHitSurfaceHook()
		end)
		if getdata(a.__ClassName, "FireAuto") ~= nil then
			a.Config.FireAuto = configs.combat.alwaysauto and true or getdata(a.__ClassName, "FireAuto") 
		end
		if getdata(a.__ClassName, "BulletSpread") ~= nil then
			a.Config.BulletSpread = configs.combat.nospread and 0 or getdata(a.__ClassName, "BulletSpread")
		end
		if getdata(a.__ClassName, "CamShakeMagnitude") ~= nil then
			a.Config.CamShakeMagnitude = configs.combat.norecoil and 0 or getdata(a.__ClassName, "CamShakeMagnitude")
		end
		if a.__ClassName == "Taser" and getdata(a.__ClassName, "ReloadTimeHit") ~= nil and getdata(a.__ClassName, "ReloadTime") ~= nil then
			a.Config.ReloadTimeHit = configs.combat.tasermodz and 0 or getdata(a.__ClassName, "ReloadTimeHit")
			a.Config.ReloadTime = configs.combat.tasermodz and 0 or getdata(a.__ClassName, "ReloadTime")
		end
		if a and a.BulletEmitter and a.BulletEmitter.GravityVector then
			a.BulletEmitter.GravityVector = configs.combat.nobulletg and nil or Vector3.new(0, -workspace.Gravity / 10, 0)
		end
		if a.__ClassName == "ForcefieldLauncher" then
			a.Config.Reload = configs.combat.forcefieldreload and 0 or 4
		end
	end)
	
	task.spawn(function()
		while true do task.wait(.1)
			pcall(function()
				local humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid or nil
				local gvp = require(game:GetService("ReplicatedStorage").Vehicle.VehicleUtils).GetLocalVehiclePacket() or nil
				if humanoid ~= nil and gvp ~= nil and client.vehicleEntered then
					if gvp.Type == "Chassis" then
						if configs.vehicle.engine then
							gvp.GarageEngineSpeed = configs.vehicle.enginesp
						end
						-- if configs.vehicle.brake then
						-- 	gvp.GarageBrakes = configs.vehicle.brakesp
						-- end
						if configs.vehicle.suspension then
							gvp.Height = configs.vehicle.suspensionhe
						end
						if configs.vehicle.turn then
							gvp.TurnSpeed = configs.vehicle.turnsp
						end
					end
				end
				if configs.player.norwait then
					table.clear(client.movementrollservice.mapLastRollTime)
				end
			end)
		end
	end)
end)

AddToggle = (function(groupboxes, txt, clbck, default, tootip) -- just to make thingz easier and cleaner
    default = default or false
	tootip = type(tootip) == "string" and tootip or false
	local tbl = {
        Text = txt;
        Default = default;
        Callback = clbck;
		Tooltip = tootip;
    }
	if tootip == false then 
		table.remove(tbl, 4) 
	end
    groupboxes:AddToggle(string.gsub(txt, " ", ""), tbl)
end)

AddSlider = (function(groupboxes, txt, clbck, default, min, max, round, tootip)
    default = default or false
	tootip = tootip or nil
	round = round or 0
	local tbl = {
        Text = txt;
        Default = default;
		Max = max;
		Min = min;
		Rounding  = round;
        Callback = clbck;
		Tooltip = tootip;
    }
	if tootip == nil then 
		table.remove(tbl, 4) 
	end
    groupboxes:AddSlider(string.gsub(txt, " ", ""), tbl)
end)

local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles

Library.ShowToggleFrameInKeybinds = true 
Library.ShowCustomCursor = false
Library.NotifySide = "Left"
Library.Font = Enum.Font.Code

local Window = Library:CreateWindow({
	Title = 'Codecoat',
	Center = true,
	AutoShow = true,
	Resizable = true,
	ShowCustomCursor = false,
	NotifySide = "Left",
	TabPadding = 1,
	MenuFadeTime = 0.2,
    Size = UDim2.fromOffset(500, 385)
})

local tab = Window:AddTab("Player")

local group = tab:AddLeftGroupbox("Utilities")

-- AddToggle(group, "Automatic Escape", function(a)
-- 	print(a)
-- end)
AddToggle(group, "Anti Ragdoll", function(a)
	configs.player.norag = a
	local hrp = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart") or nil
	if configs.player.norag == false and hrp ~= nil then
		hrp:RemoveTag("NoRagdoll")
	elseif configs.player.norag == true and hrp ~= nil then
		hrp:AddTag("NoRagdoll")
	end
end)
AddToggle(group, "Anti Fall Injury", function(a)
	configs.player.nofall = a
	local hrp = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart") or nil
	if configs.player.nofall == false and hrp ~= nil then
		hrp:RemoveTag("NoFallDamage")
	elseif configs.player.nofall == true and hrp ~= nil then
		hrp:AddTag("NoFallDamage")
	end
end)
AddToggle(group, "Anti Skydiving", function(a)
	configs.player.nosky = a
end)
AddToggle(group, "Anti Ragdoll Stun", function(a)
	configs.player.nostun = a
	client.settingss.Time.Stunned = configs.player.nostun and 0 or 5
	setupvalue(client.stunnedragdoll, 1, configs.player.nostun and nil)
end)
AddToggle(group, "Anti Injury Slow", function(a)
	configs.player.noislow = a
	setconstant(client.walkspeedfun, 8, configs.player.noislow and 1 or 0.5)
end)
AddToggle(group, "Anti Crawling Slow", function(a)
	configs.player.nocslow = a
	setconstant(client.walkspeedfun, 16, configs.player.nocslow and 1 or 0.4)
end)
AddToggle(group, "Anti Spotlight Slow", function(a) -- might be not working but... whatevahh 
	configs.player.nopslow = a
	setconstant(client.walkspeedfun, 31, configs.player.nospslow and "hey_plainrocky123" or "IsLocalInSpotlight")
	setconstant(client.walkspeedfun, 33, configs.player.nospslow and "yourmomma" or "IsInTrackingSpotlight")
end)
AddToggle(group, "No Circle Hold", function(a)
	configs.player.nocircwait = a
end)
AddToggle(group, "No Roll Cooldown", function(a)
	configs.player.norwait = a
	client.activeaction.roll.useEvery = configs.player.norwait and 0 or 5
	client.rollratelimiter._budgetPerWindow = configs.player.norwait and 9e9 or 10
	client.rollratelimiter._budgetWindowDuration = configs.player.norwait and 9e9 or 10
end)
AddToggle(group, "Always Sprinting", function(a) -- might be not working but... whatevahh 
	configs.player.alwayssp = a
	if a then
		client.sprintLoop()
	end
end)
AddToggle(group, "Infinite Jump", function(a)
	configs.player.infjump = a
end)
AddToggle(group, "Bypass Keycard Door", function(a)
	configs.player.bypasskd = a
	client.hasKeyHook(configs.player.bypasskd)
end)
AddToggle(group, "Allow Equip When Crawling", function(a)
	configs.player.crawlequip = a
	if configs.player.crawlequip then
		client.isCrawlingLoop()
	end
end)
AddToggle(group, "Break Your Back Bone", function(a)
	configs.player.backbone = a
	if configs.player.backbone then
		client.duckLoop()
	end
end)

--local group = tab:AddRightGroupbox("Dogs") -- soon :>>>>
-- AddSlider(group, "Walk uhh", function(a) 
	
-- end, default, min, max, round)


local tab = Window:AddTab("Vehicle")

local group = tab:AddLeftGroupbox("Car")
AddSlider(group, "Engine Speed", function(a) 
	configs.vehicle.enginesp = a
end, configs.vehicle.enginesp, 1, 200, 0)
AddToggle(group, "Apply Engine Speed", function(a)
	configs.vehicle.engine = a
	if configs.vehicle.engine == false then
		client.updateToOriginalChassisStats()
	end
end)
AddSlider(group, "Suspension Height", function(a) 
	configs.vehicle.suspensionhe = a
end, configs.vehicle.suspensionhe, 1, 200, 0)
AddToggle(group, "Apply Suspension Height", function(a)
	configs.vehicle.suspension = a
	if configs.vehicle.suspension == false then
		client.updateToOriginalChassisStats()
	end
end)
AddSlider(group, "Turn Speed", function(a) 
	configs.vehicle.turnsp = a
end, configs.vehicle.turnsp, 1, 5, 1)
AddToggle(group, "Apply Turn Speed", function(a)
	configs.vehicle.turn = a
	if configs.vehicle.turn == false then
		client.updateToOriginalChassisStats()
	end
end)
-- AddToggle(group, "Infinite Tire Traction", function(a) -- not completed :>>>>>
-- 	configs.vehicle.inftrac = a
-- end, false, "not completred")
AddToggle(group, "Anti Tire Pop", function(a)
	configs.vehicle.nopop = a
end)
AddToggle(group, "Drive On Water", function(a)
	configs.vehicle.driveonwater = a
	setconstant(client.alexchassis.UpdateEngine, 280, configs.vehicle.driveonwater and 1 or 0.625)
end)
AddToggle(group, "Always Flip", function(a)
	configs.vehicle.autoflip = a
	if configs.vehicle.autoflip then
		client.flipLoop()
	end
end)
AddToggle(group, "Instant Tow", function(a)
	configs.vehicle.instanttow = a
end)
local group = tab:AddRightGroupbox("Helicopter")
AddSlider(group, "Engine Forward Speed", function(a) 
	configs.vehicle.helienginesp = a / 10
end, 0, 0, 500, 0)
AddSlider(group, "Engine Vertical Speed", function(a) 
	configs.vehicle.heliverticalsp = a / 10
end, 0, 0, 300, 0)
AddToggle(group, "Apply Modification", function(a)
	configs.vehicle.heliengine = a
end)
AddToggle(group, "Instant Heli Pickup", function(a)
	configs.vehicle.helipick = a
end)
AddToggle(group, "Anti Heli Down", function(a)
	configs.vehicle.helibreak = a
end)

local group = tab:AddRightGroupbox("Utilities")
AddSlider(group, "Flight Speed", function(a) 
	configs.vehicle.fspeed = a
end, 0, 0, 1000, 0)
AddSlider(group, "Flight Rotation X", function(a) 
	configs.vehicle.fx = a
end, 0, 0, 360, 0)
AddSlider(group, "Flight Rotation Y", function(a) 
	configs.vehicle.fy = a
end, 0, 0, 360, 0)
AddSlider(group, "Flight Rotation Z", function(a) 
	configs.vehicle.fz = a
end, 0, 0, 360, 0)
AddToggle(group, "Vehicle Flight", function(a)
	configs.vehicle.ftog = a
	if configs.vehicle.ftog and client.vehicleEntered == true then
		client.launchVehicleFlight()
	end
end)
AddToggle(group, "Infinite Nitro", function(a)
	configs.vehicle.infnitro = a
	if configs.vehicle.infnitro then
		client.nitroLoop()
	end
end)
AddToggle(group, "Anti Vehicle Hijack", function(a)
	configs.vehicle.alwayshij = a
	if configs.vehicle.alwayshij then
		client.hijackLoop()
	end
end)
local tab = Window:AddTab("Combat")

local group = tab:AddLeftGroupbox("Utilities")
AddToggle(group, "Always Auto", function(a)
	configs.combat.alwaysauto = a
end)
AddToggle(group, "Anti Recoil", function(a)
	configs.combat.norecoil = a
end)
AddToggle(group, "Anti Spread", function(a)
	configs.combat.nospread = a
end)
AddToggle(group, "Anti Equip Time", function(a)
	configs.combat.noequipt = a
end)
AddToggle(group, "Bullet Criticals", function(a)
	configs.combat.alwaysheadshot = a
end)
AddToggle(group, "Instant Bullet Hit", function(a)
	configs.combat.instantbullethit = a
end)
AddToggle(group, "Increase Takedown Damage", function(a)
	configs.combat.increasetakedowndamage = a
end)
AddToggle(group, "Increase Forcefield Damage", function(a)
	configs.combat.increaseforcedamage = a
end)
AddToggle(group, "Shoot Through Forcefield", function(a)
	configs.combat.shootthroughforce =a
	setconstant(client.bulletemitter.Update, 26, configs.combat.shootthroughforce and 0 or 1)
end)
AddToggle(group, "Rocket Instant Seek", function(a)
	configs.combat.instantrocketseek = a
	client.rocketconsts.SEEKING_LOCK_MIN_DURATION = configs.combat.instantrocketseek and 0 or 2
end)
AddToggle(group, "Free Pistol Swat", function(a)
	configs.combat.pistolswat = a
end)
AddToggle(group, "Fast Taser", function(a)
	configs.combat.tasermodz = a
end)
AddToggle(group, "Faster Forcefield Reload", function(a)
	configs.combat.forcefieldreload = a
end)
AddToggle(group, "Anti Forcefield Misses", function(a)
	configs.combat.forcefieldnomiss = a
end)

local group = tab:AddLeftGroupbox("Melee")
AddToggle(group, "Anti Reload Time", function(a)
	configs.combat.batonsword.noreloadtime = a
	if configs.combat.batonsword.noreloadtime then
		client.setBatonSwordTime(configs.combat.batonsword.noreloadtime)
	end
end)
AddToggle(group, "Always Swoosh", function(a)
	configs.combat.batonsword.spamswoosh = a
	if configs.combat.batonsword.spamswoosh then
		client.spamBatonSwordSwoosh()
	end
end)
AddToggle(group, "Always Lunge", function(a)
	configs.combat.batonsword.spamlunge = a
	if configs.combat.batonsword.spamlunge then
		client.spamBatonSwordLunge()
	end
end)

local group = tab:AddRightGroupbox("Silent Aim")
AddToggle(group, "Enabled", function(a)
	configs.combat.silentaim.enabled = a
end)
AddToggle(group, "Wallcheck", function(a)
	configs.combat.silentaim.wallcheck = a
end)
AddToggle(group, "Include Taser", function(a)
	configs.combat.silentaim.includetaser = a
end)
AddToggle(group, "Include Plasma", function(a)
	configs.combat.silentaim.includeplasma = a
end)
AddToggle(group, "FOV Circle", function(a)
	configs.combat.silentaim.fovcirc = a
	Circle.Visible = a
end)
AddSlider(group, "Radius", function(a) 
	configs.combat.silentaim.radius = a
	Circle.Radius = a
end, 50, 10, 1000, 0)

local group = tab:AddRightGroupbox("Arrest Aura")
AddToggle(group, "Enabled", function(a)
	configs.combat.arrestaura.enabled = a
	if configs.combat.arrestaura.enabled then
		client.launchArrestAura()
	end	
end)
-- local group = tab:AddRightGroupbox("Hitboxes")
-- AddSlider(group, "Radius", function(a) 
-- 	configs.combat.hitboxradius = a
-- 	client.changeHitboxRadius(configs.combat.hitboxradius)
-- end, 50, 10, 1000, 0)

local tab = Window:AddTab("Visual")
local group = tab:AddLeftGroupbox("ESP Options")
AddToggle(group, "Enabled", function(a)
	MainESP.Options.Enabled = a
end)
AddToggle(group, "Box", function(a)
	MainESP.Options.Box = a
end)
AddToggle(group, "Tracer", function(a)
	MainESP.Options.Tracer = a
end)
AddToggle(group, "Name", function(a)
	MainESP.Options.Name = a
end)
AddToggle(group, "Distance", function(a)
	MainESP.Options.Distance = a
end)
AddToggle(group, "Health", function(a)
	MainESP.Options.Health = a
end)
AddToggle(group, "Skeleton", function(a)
	MainESP.Options.Skeleton = a
end)
local group = tab:AddRightGroupbox("ESP Settings")
AddToggle(group, "Team Check", function(a)
	MainESP.Options.Enabled = a
end)
AddToggle(group, "Use Team Color", function(a)
	MainESP.Options.UseTeamColor = a
end, true)
AddToggle(group, "Rainbow", function(a)
	MainESP.Options.Rainbow = a
end)
AddToggle(group, "Text Outline", function(a)
	MainESP.Options.TextOutline = a
end)
AddSlider(group, "Text Size", function(a) 
	MainESP.FontSize = a
end, 15, 1, 50, 0)
group:AddDropdown('TracerOrigins', {
	Values = {"Top","Middle","Bottom"},
	Default = 1, 
	Multi = false, 
	Text = "Tracer Origins",
	Searchable = false,
	Callback = function(Value)
		MainESP.Options.TracerOrigin = Value
	end,
	Visible = true, -- Will make the dropdown invisible (true / false)
})
-- config system is kinda buggy on linoria soo some features probably won't automatically set to saved config system
local tab = Window:AddTab("⚙️")
local MenuGroup = tab:AddLeftGroupbox("Menu")
MenuGroup:AddToggle("KeybindMenuOpen", { Default = Library.KeybindFrame.Visible, Text = "Open Keybind Menu", Callback = function(value) Library.KeybindFrame.Visible = value end})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
MenuGroup:AddButton("Unload", function() Library:Unload() end)
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
ThemeManager:SetFolder('Codecoat')
SaveManager:SetFolder('Codecoat/Jailbreak')
SaveManager:BuildConfigSection(tab)
ThemeManager:ApplyToTab(tab)
SaveManager:LoadAutoloadConfig()
-- simple fixes for weapon camera lock not working cuz of linoria library having some guibutton modal turned on for some reason
loadstring(game:HttpGet('https://pastebin.pl/view/raw/8e1e69d5'))() -- don't open the link
