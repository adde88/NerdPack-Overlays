local name, Overlays = ...
Overlays.Version     = 2.0
local NeP            = NeP
local F              = function(key) return NeP.Interface:Fetch(name, key, false) end
local LibDraw        = LibStub('LibDraw-1.0')
local ObjectPosition = ObjectPosition
local UnitName       = UnitName
local UnitGUID       = UnitGUID

-- The refresh speed
LibDraw.Enable(0.01)

local config = {
	key = name,
	title = name,
	subtitle = 'Settings',
	width = 250,
	height = 500,
	config = {
		-- Enemies
		{ type = 'header', text = 'Enemies' },
		{ type = 'checkspin', text = 'Enable', key = 'e_MASTER', default_check = false, default_spin = 50 },
		{ type = 'checkbox', text = 'Name', key = 'e_NAME', default = false },
		{ type = 'checkbox', text = 'Distance', key = 'e_DIS', default = false },
		{ type = 'checkbox', text = 'TTD', key = 'e_TTD', default = false },
		{ type = 'spacer' },{ type = 'ruler' },

		-- Friendly
		{ type = 'header', text = 'Friendly' },
		{ type = 'checkspin', text = 'Enable', key = 'f_MASTER', default_check = false, default_spin = 50 },
		{ type = 'checkbox', text = 'Name', key = 'f_NAME', default = false },
		{ type = 'checkbox', text = 'Distance', key = 'f_DIS', default = false },
		{ type = 'checkbox', text = 'TTD', key = 'f_TTD', default = false },
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
		end
	end
end)
