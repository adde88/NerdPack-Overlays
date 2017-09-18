local n_name, gbl = ...
local _G = _G
local NeP = _G.NeP
local LibDraw = _G.LibStub('LibDraw-1.0')

gbl.Version = 2.0
gbl.Round = NeP.Core.Round

function gbl.F(_, key, default)
	return NeP.Interface:Fetch(n_name, key, default or false)
end

gbl.Classifications = {
	['minus'] 		= 1,
	['normal'] 		= 2,
	['elite' ]		= 3,
	['rare'] 		= 4,
	['rareelite' ]	= 5,
	['worldboss' ]	= 6
}

local Texts = {}
function gbl.SetText(_, Obj, text)
	local oX, oY, oZ = _G.ObjectPosition(Obj)
	-- This tracks how many texts a unit has for offsers
	local GUID = _G.UnitGUID(Obj)
	Texts[GUID] = Texts[GUID]..'\n|cffFFFFFF'..text
	LibDraw.Text(Texts[GUID], 'SystemFont_Tiny', oX, oY, oZ + 3)
end

function gbl.CombatReach(_, a,b)
	return _G.UnitCombatReach(a) + _G.UnitCombatReach(b)
end

function gbl.SetTexture(_, Obj, texture, distance)
	local offset = 4
	local tempT = { texture = texture, width = 64, height = 64, scale = 1 }
	if distance > 30 then
		offset = 4
		tempT.width = 32
		tempT.height = 32
	end
	if distance > 60 then
		offset = 3
		tempT.width = 16
		tempT.height = 16
	end
	local oX, oY, oZ = _G.ObjectPosition(Obj)
	LibDraw.Texture(tempT, oX, oY, oZ + offset, 100)
end

function gbl.Circle(_, Obj, radius)
	local oX, oY, oZ = _G.ObjectPosition(Obj)
	LibDraw.Circle(oX, oY, oZ, radius)
end

function gbl.DrawLine(_, a, b)
	local oX, oY, oZ = _G.ObjectPosition(a)
	local tX, tY, tZ = _G.ObjectPosition(b)
	LibDraw.Line(oX, oY, oZ, tX, tY, tZ)
end

-- Objects
LibDraw.Sync(function()

	-- Dont even load if not advanced
	if not _G.ObjectPosition then return end

	gbl:PlayerSync()

	if NeP.Protected.ObjectExists("target") then
		gbl:TargetSync()
	end

	-- Friendly
	if gbl:F('f_MASTER') then
		for GUID, Obj in pairs(NeP.OM:Get('Friendly')) do
			if Obj.distance <= gbl:F('MASTER_spin')
			and NeP.Protected.ObjectExists(Obj.key) then
				Texts[GUID] = ''
				Obj.color = NeP.Core:ClassColor(Obj.key)
				gbl:FriendlySync(Obj)
			end
		end
	end

	-- Enemy
	if gbl:F('e_MASTER') then
		for GUID, Obj in pairs(NeP.OM:Get('Enemy')) do
			if Obj.distance <= gbl:F('MASTER_spin')
			and NeP.Protected.ObjectExists(Obj.key) then
				Texts[GUID] = ''
				Obj.color = NeP.Core:ClassColor(Obj.key)
				gbl:EnemiesSync(Obj)
			end
		end
	end

	--Objects
	for GUID, Obj in pairs(NeP.OM:Get('Objects')) do
		if Obj.distance <= gbl:F('MASTER_spin')
		and NeP.Protected.ObjectExists(Obj.key) then
			Texts[GUID] = ''
			if gbl:F('o_MASTER') then
				gbl:ObjectsSync(Obj)
			end
			if gbl:F('tr_MASTER') then
				gbl:TrackerSync(Obj)
			end
		end
	end

end)

-- refresh speed
NeP.Listener:Add(n_name, "PLAYER_LOGIN", function()
	local input = gbl:F('refresh', 0.01)
	LibDraw.Enable(tonumber(input))
end)
