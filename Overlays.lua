NeP.Interface.CreatePlugin('Overlays', function() NeP.Interface.ShowGUI('NePOverlays') end)

local LibDraw = LibStub('LibDraw-1.0')

local Round = NeP.Core.Round
local UnitAttackRange = NeP.Core.UnitAttackRange
local fetchKey = NeP.Interface.fetchKey

local _mediaDir = 'Interface\\AddOns\\NerdPack-Overlays\\media\\'
local Alpha = 100
local zOffset = 3
local addonColor = '|cff'..NeP.Interface.addonColor

local config = {
	key = 'NePOverlays',
	profiles = true,
	title = '|T'..NeP.Interface.Logo..':10:10|t'..' '..NeP.Info.Name,
	subtitle = 'Overlays Settings',
	color = NeP.Interface.addonColor,
	width = 250,
	height = 500,
	config = {
		{ type = 'header', text = '|cff'..NeP.Interface.addonColor..'Overlays:', size = 25, align = 'Center' },
			{ type = 'text', text = "|cfffd1c15[Warning]|r Requires FireHack", align = "Center" },
			{ type = 'spacer' },
			{ type = 'checkbox', text = 'Enable Overlays', key = 'Enabled', default = false },
			
		{ type = 'spacer' },{ type = 'rule' },
		{ type = 'header', text = '|cff'..NeP.Interface.addonColor..'Player:', size = 25, align = 'Center' },
			{ type = 'checkbox', text = 'Melee Range', key = 'PlayerMRange', default = false },
			{ type = 'checkbox', text = 'Caster Range', key = 'PlayerCRange', default = false },
			{ type = 'checkbox', text = 'Target Line', key = 'TargetLine', default = false },
			{ type = 'checkbox', text = 'Infront Cone', key = 'PlayerInfrontCone', default = false },
		
		{ type = 'spacer' },{ type = 'rule' },
		{ type = 'header', text = '|cff'..NeP.Interface.addonColor..'Target:', size = 25, align = 'Center' },
			{ type = 'checkbox', text = 'Melee Range', key = 'TargetMRange', default = false },
			{ type = 'checkbox', text = 'Caster Range', key = 'TargetCRange', default = false },
			{ type = 'checkbox', text = 'Infront Cone', key = 'TargetCone', default = false },
			{ type = 'checkbox', text = 'Target\s Target Line', key = 'targetsTargetLine', default = false },
		
		{ type = 'spacer' },{ type = 'rule' },
		{ type = 'header', text = '|cff'..NeP.Interface.addonColor..'Object:', size = 25, align = 'Center' },
			{ type = 'checkbox', text = 'Enemies TimeToDie', key = 'enemieTTD', default = false },
			{ type = 'checkbox', text = 'Friendly TimeToDie', key = 'friendlyTTD', default = false },
			{ type = 'checkbox', text = 'Every Friendly Target', key = 'friendlyTrg', default = false },
			{ type = 'checkbox', text = 'Every Enemie Target', key = 'enemieTrg', default = false },

		{ type = 'spacer' },{ type = 'rule' },
		{ type = 'header', text = '|cff'..NeP.Interface.addonColor..'Tracking:', size = 25, align = 'Center' },
			{ type = 'checkbox', text = 'Friendly Player Units', key = 'objectsFriendlyPlayers', default = false },
			{ type = 'checkbox', text = 'Enemie Player Units', key = 'objectsEnemiePlayers', default = false },
			{ type = 'checkbox', text = 'Rare Units', key = 'objectsRares', default = false },
			{ type = 'checkbox', text = 'WorldBoss Units', key = 'objectsWorldBoss', default = false },
			{ type = 'checkbox', text = 'Elite Units', key = 'objectsElite', default = false },
	}
}

NeP.Interface.buildGUI(config)

local basicMarker = {
	{ 0.1, 0, 0, -0.1, 0, 0},
	{ 0, 0.1, 0, 0, -0.1, 0},
	{ 0, 0, -0.1, 0, 0, 0.1}
}

local Textures = {
	-- Rares
	['rare'] = { texture = _mediaDir..'elite.blp', width = 64, height = 64 },
	['rare_big'] = { texture = _mediaDir..'elite.blp', width = 58, height = 58, scale = 1 },
	['rare_small'] = { texture = _mediaDir..'elite.blp', width = 18, height = 18, scale = 1 },
	-- Mobs
	['mob'] = { texture = _mediaDir..'mob.blp', width = 64, height = 64 },
	['mob_big'] = { texture = _mediaDir..'mob.blp', width = 58, height = 58, scale = 1 },
	['mob_small'] = { texture = _mediaDir..'mob.blp', width = 18, height = 18, scale = 1 },
	-- Units (Not bring used...)
	['unit'] = { texture = _mediaDir..'player.blp', width = 64, height = 64 },
	['unit_big'] = { texture = _mediaDir..'player.blp', width = 58, height = 58, scale = 1 },
	['unit_small'] = { texture = _mediaDir..'player.blp', width = 18, height = 18, scale = 1 },
	-- Horde
	['horde'] = { texture = _mediaDir..'horde.blp', width = 64, height = 64 },
	['horde_big'] = { texture = _mediaDir..'horde.blp', width = 58, height = 58, scale = 1 },
	['horde_small'] = { texture = _mediaDir..'horde.blp', width = 18, height = 18, scale = 1 },
	-- Aliance
	['ally'] = { texture = _mediaDir..'alliance.blp', width = 64, height = 64 },
	['ally_big'] = { texture = _mediaDir..'alliance.blp', width = 58, height = 58, scale = 1 },
	['ally_small'] = { texture = _mediaDir..'alliance.blp', width = 18, height = 18, scale = 1 },
}

local Classifications = {
	['minus'] 		= 1,
	['normal'] 		= 2,
	['elite' ]		= 3,
	['rare'] 		= 4,
	['rareelite' ]	= 5,
	['worldboss' ]	= 6
}

local function infrontCheck(a, b)
	local infront = NeP.Engine.Infront(a, b)
	if infront then
		LibDraw.SetColor(101, 255, 87, 70)
	else
		LibDraw.SetColor(255, 87, 87, 70)
	end
end

local function LoSCheck(a, b)
	local LoS = NeP.Engine.LineOfSight(a, b)
	if not LoS then
		LibDraw.SetColor(255, 87, 87, 70)
	end
end

local function distanceCheck(a, b, type)
	local UnitAttackRange = UnitAttackRange(a, b, type)
	local Distance = NeP.Engine.Distance(a, b)
	if Distance <= UnitAttackRange then
		LibDraw.SetColor(101, 255, 87, 70)
	else
		LibDraw.SetColor(255, 87, 87, 70)
	end
end

local textureOffset = 6
local function textureCheck(texture, Obj)
	local oX, oY, oZ = ObjectPosition(Obj)
	local distance = Round(NeP.Engine.Distance('player', Obj))
	if distance < 50 then
		LibDraw.Texture(Textures[texture..'_big'], oX, oY, oZ + textureOffset, Alpha)
	elseif distance > 200 then
		LibDraw.Texture(Textures[texture..'_small'], oX, oY, oZ + textureOffset, Alpha)
	else
		LibDraw.Texture(Textures[texture], oX, oY, oZ + textureOffset, Alpha)
	end
	LibDraw.Text(addonColor..UnitName(Obj)..'|r\n'..distance..' yards', 'SystemFont_Tiny', oX, oY, oZ + 3)
end

local function ObjTargetCheck(a,b)
	local oX, oY, oZ = ObjectPosition(a)
	local tX, tY, tZ = ObjectPosition(b)
	--local distance = Round(NeP.Engine.Distance(a, b))
	--LibDraw.Text(addonColor..UnitName(a)..'|r\n'..distance..' yards from '..UnitName(b), 'SystemFont_Tiny', oX, oY, oZ)
	LoSCheck(a, b)
	LibDraw.Line(oX, oY, oZ, tX, tY, tZ)
	--LibDraw.Circle(tX, tY, tZ, 1)
end

local function ObjTTD(Obj)
	local oX, oY, oZ = ObjectPosition(Obj)
	local ttd = Round(NeP.DSL.Conditions['ttd'](Obj))
	LibDraw.Text(addonColor..'TTD:|cffFFFFFF '..ttd, 'SystemFont_Tiny', oX, oY, oZ + 1.5)
end

LibDraw.Sync(function()
	
	if FireHack and fetchKey('NePOverlays', 'Enabled') then

		LibDraw.SetWidth(2)

		local pX, pY, pZ = ObjectPosition('player')
		--local cx, cy, cz = GetCameraPosition()

		if UnitGUID('target') ~= nil and ObjectExists('target') then
			
			local tX, tY, tZ = ObjectPosition('target')
			local distance = Round(NeP.Engine.Distance('player', 'target'))
			local name = UnitName('target')

			LibDraw.SetColorRaw(1, 1, 1, Alpha)

			-- Target Line
			if fetchKey('NePOverlays', 'TargetLine', false) then
				ObjTargetCheck('player', 'target')
			end
			-- Target's Target Line
			if fetchKey('NePOverlays', 'targetsTargetLine', false) then
				if ObjectExists('targettarget') then
					ObjTargetCheck('target', 'targettarget')
				end
			end
			-- Target Infront Cone
			if fetchKey('NePOverlays', 'TargetCone', false) then
				local targetRotation = ObjectFacing('target')
				LibDraw.Arc(tX, tY, tZ, 10, 180, targetRotation)
			end
			-- Player Infront Cone
			if fetchKey('NePOverlays', 'PlayerInfrontCone', false) then
				local playerRotation = ObjectFacing('player')
				infrontCheck('player', 'target')
				LibDraw.Arc(pX, pY, pZ, 10, 180, playerRotation)
			end
			-- Player Melee Range
			if fetchKey('NePOverlays', 'PlayerMRange', false) then
				distanceCheck('player', 'target', 'melee')
				LibDraw.Circle(pX, pY, pZ, UnitAttackRange('player', 'target', 'melee'))
			end
			-- Player Caster Range
			if fetchKey('NePOverlays', 'PlayerCRange', false) then
				distanceCheck('player', 'target', 'ranged')
				LibDraw.Circle(pX, pY, pZ, UnitAttackRange('player', 'target', 'ranged'))
			end
			-- Target Melee Range
			if fetchKey('NePOverlays', 'TargetMRange', false) then
				distanceCheck('player', 'target', 'melee')
				LibDraw.Circle(tX, tY, tZ, UnitAttackRange('player', 'target', 'melee'))
			end
			-- Target Caster Range
			if fetchKey('NePOverlays', 'TargetCRange', false) then
				distanceCheck('player', 'target', 'ranged')
				LibDraw.Circle(tX, tY, tZ, UnitAttackRange('player', 'target', 'ranged'))
			end
		end
			
		-- Enemie Units
		for i=1,#NeP.OM.unitEnemie do
			local Obj = NeP.OM.unitEnemie[i]
			if UnitGUID(Obj.key) ~= nil and ObjectExists(Obj.key) then --Calling ObjectExists in FireHack 2.1.4 with nil can crash the client. Fixed in FireHack 2.2.
				
				local _class = Obj.class
				LibDraw.SetColorRaw(1, 1, 1, Alpha)

				-- All Targets
				if fetchKey('NePOverlays', 'enemieTrg', false) then
					local ObjTarget = UnitTarget(Obj.key)
					if ObjTarget ~= nil then
						ObjTargetCheck(Obj.key, ObjTarget)
					end
				end

				-- TDD
				if fetchKey('NePOverlays', 'enemieTTD', false) then
					ObjTTD(Obj.key)
				end
					
				-- Elites
				if _class == Classifications['elite'] then
					if fetchKey('NePOverlays', 'objectsElite', false) then
						textureCheck('mob', Obj.key)
					end
				-- WorldBoss
				elseif _class == Classifications['worldboss'] then
					if fetchKey('NePOverlays', 'objectsWorldBoss', false) then
						textureCheck('mob', Obj.key)
					end
				-- Rares
				elseif _class == Classifications['rareelite'] then
					if fetchKey('NePOverlays', 'objectsRares', false) then
						textureCheck('mob', Obj.key)
					end
				-- Players
				elseif UnitIsPlayer(Obj.key) then
					if fetchKey('NePOverlays', 'objectsEnemiePlayers', false) then
						local factionGroup, factionName = UnitFactionGroup(Obj.key)
						if factionGroup == 'Alliance' then
							textureCheck('ally', Obj.key)
						elseif factionGroup == 'Horde' then
							textureCheck('horde', Obj.key)
						end
					end
				end

			end
		end
			
		-- Friendly Units
		for i=1,#NeP.OM.unitFriend do
			local Obj = NeP.OM.unitFriend[i]
			if UnitGUID(Obj.key) ~= nil and ObjectExists(Obj.key) then

				LibDraw.SetColorRaw(1, 1, 1, Alpha)

				-- All Targets
				if fetchKey('NePOverlays', 'friendlyTrg', false) then
					local ObjTarget = UnitTarget(Obj.key)
					if ObjTarget ~= nil then
						ObjTargetCheck(Obj.key, ObjTarget)
					end
				end

				-- TTD
				if fetchKey('NePOverlays', 'friendlyTTD', false) then
					ObjTTD(Obj.key)
				end

				-- Players
				if UnitIsPlayer(Obj.key) then
					if fetchKey('NePOverlays', 'objectsFriendlyPlayers', false) then
						if not UnitIsUnit('player', Obj.key) then
							local factionGroup, factionName = UnitFactionGroup(Obj.key)
							if factionGroup == 'Alliance' then
								textureCheck('ally', Obj.key)
							elseif factionGroup == 'Horde' then
								textureCheck('horde', Obj.key)
							end
						end
					end
				end

			end
		end

	end
end)