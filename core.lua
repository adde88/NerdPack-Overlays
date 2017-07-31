local name, Overlays  = ...
Overlays.Version      = 2.0
local NeP             = NeP
local F               = function(key, default) return NeP.Interface:Fetch(name, key, default or false) end
local LibDraw         = LibStub('LibDraw-1.0')
local ObjectPosition  = ObjectPosition
local UnitName        = UnitName
local UnitGUID        = UnitGUID
local UnitCombatReach = UnitCombatReach
local UnitTarget      = UnitTarget
local UnitExists      = UnitExists
local ReloadUI        = ReloadUI

local config = {
	key = name,
	title = name,
	subtitle = 'Settings',
	width = 200,
	height = 500,
	config = {

		-- General
		{ type = 'header', text = 'General' },
		{ type = 'input', text = 'Refresh rate', key = 'refresh', default = 0.01 },
		{ type = 'spacer' },
		{ type = 'button', text = 'Apply', align = 'TOP', width = 150,  callback = function() ReloadUI() end },
		{ type = 'spacer' },{ type = 'ruler' },

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
		{ type = 'checkspin', text = 'Enable', key = 'e_MASTER', check = false, spin = 50 },
		{ type = 'checkbox', text = 'Name', key = 'e_NAME', default = false },
		{ type = 'checkbox', text = 'Distance', key = 'e_DIS', default = false },
		{ type = 'checkbox', text = 'TTD', key = 'e_TTD', default = false },
		{ type = 'checkbox', text = 'Target lines', key = 'e_TLINES', default = false },
		{ type = 'checkbox', text = 'IDs', key = 'e_IDs', default = false },
		{ type = 'spacer' },{ type = 'ruler' },

		-- Friendly
		{ type = 'header', text = 'Friendly' },
		{ type = 'checkspin', text = 'Enable', key = 'f_MASTER', check = false, spin = 50 },
		{ type = 'checkbox', text = 'Name', key = 'f_NAME', default = false },
		{ type = 'checkbox', text = 'Distance', key = 'f_DIS', default = false },
		{ type = 'checkbox', text = 'TTD', key = 'f_TTD', default = false },
		{ type = 'checkbox', text = 'Target lines', key = 'f_TLINES', default = false },
		{ type = 'checkbox', text = 'IDs', key = 'f_IDs', default = false },
		{ type = 'spacer' },{ type = 'ruler' },

		-- Objects
		{ type = 'header', text = 'Objects' },
		{ type = 'checkspin', text = 'Enable', key = 'o_MASTER', check = false, spin = 50 },
		{ type = 'checkbox', text = 'Name', key = 'o_NAME', default = false },
		{ type = 'checkbox', text = 'Distance', key = 'o_DIS', default = false },
		{ type = 'checkbox', text = 'IDs', key = 'o_IDs', default = false },
	}
}

-- Create the GUI and add it to NeP
Overlays.GUI = NeP.Interface:BuildGUI(config)
NeP.Interface:Add(name..' V:'..Overlays.Version, function() Overlays.GUI.parent:Show() end)
Overlays.GUI.parent:Hide()

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
		if F('p_MELEE') and UnitExists('target') then
			local range = UnitCombatReach('player') + UnitCombatReach('target') + 1.5
			Overlays:Circle('player', range)
		end
		-- Melee range
		if F('p_RANGED' and UnitExists('target')) then
			local range = UnitCombatReach('player') + UnitCombatReach('target') + 40
			Overlays:Circle('player', range)
		end
		-- Targets
		if F('p_TLINES') and UnitExists('target') then
				Overlays:DrawLine('player', 'target')
		end
end)

-- target
LibDraw.Sync(function()
		if not UnitExists('target') then return end
		-- Melee range
		if F('t_MELEE') then
			local range = UnitCombatReach('player') + UnitCombatReach('target') + 1.5
			Overlays:Circle('target', range)
		end
		-- Melee range
		if F('t_RANGED') then
			local range = UnitCombatReach('player') + UnitCombatReach('target') + 40
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
			-- All Targets
			if F('e_TLINES') then
				local ObjTarget = UnitTarget(Obj.key)
				if ObjTarget then
					Overlays:DrawLine(Obj.key, ObjTarget)
				end
			end
			-- IDs
			if F('e_IDs') then
				Overlays:SetText(Obj.key, Obj.id)
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
			-- IDs
			if F('f_IDs') then
				Overlays:SetText(Obj.key, Obj.id)
			end
		end
	end
end)

-- Objects
LibDraw.Sync(function()
	if not F('o_MASTER_check') then return end
	for GUID, Obj in pairs(NeP.OM:Get('Objects')) do
		Texts[GUID] = ''
		if Obj.distance <= F('o_MASTER_spin') then
			-- Distance
			if F('o_NAME') then
				local Name = UnitName(Obj.key)
				local Color = '|cffFFFFFF'
				Overlays:SetText(Obj.key, Color..Name)
			end
			-- Distance
			if F('o_DIS') then
				local distance = NeP.Core:Round(Obj.distance)
				Overlays:SetText(Obj.key, distance..' yards')
			end
			-- IDs
			if F('o_IDs') then
				Overlays:SetText(Obj.key, Obj.id)
			end
		end
	end
end)

NeP.Listener:Add(name, "PLAYER_LOGIN", function()
	-- The refresh speed
	local input = F('refresh', 0.01)
	LibDraw.Enable(tonumber(input))
end)
