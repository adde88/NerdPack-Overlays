local name, Overlays  = ...
Overlays.Version      = 2.0
local NeP             = NeP
local F               = function(key) return NeP.Interface:Fetch(name, key, false) end
local LibDraw         = LibStub('LibDraw-1.0')
local ObjectPosition  = ObjectPosition
local UnitName        = UnitName
local UnitGUID        = UnitGUID
local UnitCombatReach = UnitCombatReach
local UnitTarget      = UnitTarget
local UnitExists      = UnitExists

-- The refresh speed
LibDraw.Enable(0.01)

local config = {
	key = name,
	title = name,
	subtitle = 'Settings',
	width = 250,
	height = 500,
	config = {

		-- Player
		{ type = 'header', text = 'Player' },
		{ type = 'checkbox', text = 'Melee', key = 'p_MELEE', default = false },
		{ type = 'checkbox', text = 'Ranged', key = 'p_RANGED', default = false },
		{ type = 'checkbox', text = 'Target lines', key = 'p_TLINES', default = false },
		{ type = 'spacer' },{ type = 'ruler' },

		-- target
		{ type = 'header', text = 'Target' },
		{ type = 'checkbox', text = 'Melee', key = 't_MELEE', default = false },
		{ type = 'checkbox', text = 'Ranged', key = 't_RANGED', default = false },
		{ type = 'checkbox', text = 'Target lines', key = 't_TLINES', default = false },
		{ type = 'spacer' },{ type = 'ruler' },

		-- Enemies
		{ type = 'header', text = 'Enemies' },
		{ type = 'checkspin', text = 'Enable', key = 'e_MASTER', default_check = false, default_spin = 50 },
		{ type = 'checkbox', text = 'Name', key = 'e_NAME', default = false },
		{ type = 'checkbox', text = 'Distance', key = 'e_DIS', default = false },
		{ type = 'checkbox', text = 'TTD', key = 'e_TTD', default = false },
		{ type = 'checkbox', text = 'Target lines', key = 'e_TLINES', default = false },
		{ type = 'spacer' },{ type = 'ruler' },

		-- Friendly
		{ type = 'header', text = 'Friendly' },
		{ type = 'checkspin', text = 'Enable', key = 'f_MASTER', default_check = false, default_spin = 50 },
		{ type = 'checkbox', text = 'Name', key = 'f_NAME', default = false },
		{ type = 'checkbox', text = 'Distance', key = 'f_DIS', default = false },
		{ type = 'checkbox', text = 'TTD', key = 'f_TTD', default = false },
		{ type = 'checkbox', text = 'Target lines', key = 'f_TLINES', default = false },
		{ type = 'spacer' },{ type = 'ruler' }
	}
}

Overlays.GUI = NeP.Interface:BuildGUI(config)
NeP.Interface:Add(name..' V:'..Overlays.Version, function() Overlays.GUI:Show() end)

Overlays.Classifications = {
	['minus'] 		= 1,
	['normal'] 		= 2,
	['elite' ]		= 3,
	['rare'] 		= 4,
	['rareelite' ]	= 5,
	['worldboss' ]	= 6
}

local Texts = {}
function Overlays:SetText(Obj, text)
	local oX, oY, oZ = ObjectPosition(Obj)
	-- This tracks how many texts a unit has for offsers
	local GUID = UnitGUID(Obj)
	Texts[GUID] = Texts[GUID]..'\n|cffFFFFFF'..text
	LibDraw.Text(Texts[GUID], 'SystemFont_Tiny', oX, oY, oZ + 3)
end

function Overlays:Circle(Obj, radius)
	local oX, oY, oZ = ObjectPosition(Obj)
	LibDraw.Circle(oX, oY, oZ, radius)
end

function Overlays:DrawLine(a, b)
	local oX, oY, oZ = ObjectPosition(a)
	local tX, tY, tZ = ObjectPosition(b)
	LibDraw.Line(oX, oY, oZ, tX, tY, tZ)
end

-- player
LibDraw.Sync(function()
		-- Melee range
		if F('p_MELEE') then
			local range = UnitCombatReach('player') + 1.5
			Overlays:Circle('player', range)
		end
		-- Melee range
		if F('p_RANGED') then
			local range = UnitCombatReach('player') + 40
			Overlays:Circle('player', range)
		end
		-- Targets
		if F('p_TLINES') and UnitExists('target') then
				Overlays:DrawLine('player', 'target')
		end
end)

-- Enemies
LibDraw.Sync(function()
		-- Melee range
		if F('t_MELEE') then
			local range = UnitCombatReach('target') + 1.5
			Overlays:Circle('target', range)
		end
		-- Melee range
		if F('t_RANGED') then
			local range = UnitCombatReach('target') + 40
			Overlays:Circle('target', range)
		end
		-- Targets
		if F('t_TLINES') and UnitExists('targettarget') then
				Overlays:DrawLine('target', 'targettarget')
		end
end)

-- Enemies
LibDraw.Sync(function()
	if not F('e_MASTER_check') then return end
	for GUID, Obj in pairs(NeP.OM:Get('Enemy')) do
		Texts[GUID] = ''
		if Obj.distance <= F('e_MASTER_spin') then
			-- Distance
			if F('e_NAME') then
				local Name = UnitName(Obj.key)
				local Color = '|cff'..NeP.Core:ClassColor(Obj.key)
				Overlays:SetText(Obj.key, Color..Name)
			end
			-- Distance
			if F('e_DIS') then
				local distance = NeP.Core:Round(Obj.distance)
				Overlays:SetText(Obj.key, distance..' yards')
			end
			-- TTD
			if F('e_TTD') then
				local ttd = NeP.DSL:Get('ttd')(Obj.key)
				Overlays:SetText(Obj.key, ttd)
			end
			-- Melee range
			if F('e_MELEE') then
				local range = UnitCombatReach(Obj.key) + 1.5
				Overlays:Circle(Obj.key, range)
			end
			-- Melee range
			if F('e_RANGED') then
				local range = UnitCombatReach(Obj.key) + 40
				Overlays:Circle(Obj.key, range)
			end
			-- All Targets
			if F('e_TLINES') then
				local ObjTarget = UnitTarget(Obj.key)
				if ObjTarget then
					Overlays:DrawLine(Obj.key, ObjTarget)
				end
			end
		end
	end
end)

-- Friendly
LibDraw.Sync(function()
	if not F('f_MASTER_check') then return end
	for GUID, Obj in pairs(NeP.OM:Get('Friendly')) do
		Texts[GUID] = ''
		if Obj.distance <= F('f_MASTER_spin') then
			-- Distance
			if F('f_NAME') then
				local Name = UnitName(Obj.key)
				local Color = '|cff'..NeP.Core:ClassColor(Obj.key)
				Overlays:SetText(Obj.key, Color..Name)
			end
			-- Distance
			if F('f_DIS') then
				local distance = NeP.Core:Round(Obj.distance)
				Overlays:SetText(Obj.key, distance..' yards')
			end
			-- TTD
			if F('f_TTD') then
				local ttd = NeP.DSL:Get('ttd')(Obj.key)
				Overlays:SetText(Obj.key, ttd)
			end
			-- All Targets
			if F('f_TLINES') then
				local ObjTarget = UnitTarget(Obj.key)
				if ObjTarget then
					Overlays:DrawLine(Obj.key, ObjTarget)
				end
			end
		end
	end
end)
