NeP.Overlays = {}

NeP.Interface.CreatePlugin('Overlays', function() NeP.Interface.ShowGUI('NePOverlays') end)

local Round = NeP.Core.Round
local UnitAttackRange = NeP.Core.UnitAttackRange
local F = function(key) return NeP.Interface.fetchKey('NePOverlays', key, false) end
local addonColor = '|cff'..NeP.Interface.addonColor
local Round = NeP.Core.Round
local LibDraw = LibStub('LibDraw-1.0')

LibDraw.Enable(0.01)

local config = {
	key = 'NePOverlays',
	profiles = true,
	title = '|T'..NeP.Interface.Logo..':10:10|t'..' '..NeP.Info.Name,
	subtitle = 'Overlays Settings',
	color = NeP.Interface.addonColor,
	width = 250,
	height = 500,
	config = {
		{ type = 'header', text = 'Tracker:', size = 25, align = 'Center' },
			{ type = 'checkbox', text = 'Find Mana Shards', key = 'MANA_SHARDS', default = false },
			{ type = 'checkbox', text = 'Find Fishing Pools', key = 'FISHING_POOLS', default = false },
			{ type = 'checkbox', text = 'Find Boss\'s', key = 'Draw_BOSS', default = false },
			{ type = 'checkbox', text = 'Find Rares', key = 'Draw_RARE', default = false },

		{ type = 'spacer' },{ type = 'rule' },
		{ type = 'header', text = 'Player:', size = 25, align = 'Center' },
			{ type = 'checkbox', text = 'Draw target line', key = 'P_TargetLine', default = false },

		{ type = 'spacer' },{ type = 'rule' },
		{ type = 'header', text = 'Enemies:', size = 25, align = 'Center' },
			{ type = 'checkbox', text = 'Draw textures', key = 'Draw_ENEMIE_PLAYERS', default = false },
			{ type = 'checkbox', text = 'Draw target line', key = 'E_TARGET', default = false },

		{ type = 'spacer' },{ type = 'rule' },
		{ type = 'header', text = 'Frendly:', size = 25, align = 'Center' },
			{ type = 'checkbox', text = 'Draw textures', key = 'Draw_FRIENDLY_PLAYERS', default = false },
			{ type = 'checkbox', text = 'Draw target line', key = 'F_TARGET', default = false },
		
	}
}

NeP.Interface.buildGUI(config)

local basicMarker = {
	{ 0.1, 0, 0, -0.1, 0, 0},
	{ 0, 0.1, 0, 0, -0.1, 0},
	{ 0, 0, -0.1, 0, 0, 0.1}
}

local Classifications = {
	['minus'] 		= 1,
	['normal'] 		= 2,
	['elite' ]		= 3,
	['rare'] 		= 4,
	['rareelite' ]	= 5,
	['worldboss' ]	= 6
}

function NeP.Overlays.SetTexture(Obj, TextureLoc)
	local oX, oY, oZ = ObjectPosition(Obj)
	local distance = Round(NeP.Engine.Distance('player', Obj))
	if distance < 50 then
		-- BIG
		local tempT = { texture = TextureLoc, width = 58, height = 58, scale = 1 }
		LibDraw.Texture(tempT, oX, oY, oZ + 6, 100)
	elseif distance > 200 then
		-- SMALL
		local tempT = { texture = TextureLoc, width = 18, height = 18, scale = 1 }
		LibDraw.Texture(tempT, oX, oY, oZ + 6, 100)
	else
		-- NORMAL
		local tempT = { texture = TextureLoc, width = 64, height = 64 }
		LibDraw.Texture(tempT, oX, oY, oZ + 6, 100)
	end
	LibDraw.Text(UnitName(Obj)..'|r\n'..distance..' yards', 'SystemFont_Tiny', oX, oY, oZ + 3)
end