-- Dont even load if not advanced
if not ObjectPosition then return end

local n_name, gbl = ...
local LibDraw = LibStub('LibDraw-1.0')

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
function gbl:SetText(Obj, text)
	local oX, oY, oZ = ObjectPosition(Obj)
	-- This tracks how many texts a unit has for offsers
	local GUID = UnitGUID(Obj)
	Texts[GUID] = Texts[GUID]..'\n|cffFFFFFF'..text
	LibDraw.Text(Texts[GUID], 'SystemFont_Tiny', oX, oY, oZ + 3)
end

function gbl:CombatReach(a,b)
	return UnitCombatReach(a) + UnitCombatReach(b)
end

function gbl:SetTexture(Obj, texture, distance)
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
	local oX, oY, oZ = ObjectPosition(Obj)
	LibDraw.Texture(tempT, oX, oY, oZ + offset, 100)
end

function gbl:Circle(Obj, radius)
	local oX, oY, oZ = ObjectPosition(Obj)
	LibDraw.Circle(oX, oY, oZ, radius)
end

function gbl:DrawLine(a, b)
	local oX, oY, oZ = ObjectPosition(a)
	local tX, tY, tZ = ObjectPosition(b)
	LibDraw.Line(oX, oY, oZ, tX, tY, tZ)
end

-- Objects
LibDraw.Sync(function()

	gbl:PlayerSync()

	if ObjectIsVisible("target") then
		gbl:TargetSync()
	end

	-- Friendly
	if gbl:F('f_MASTER') then
		for GUID, Obj in pairs(NeP.OM:Get('Friendly')) do
			if Obj.distance <= gbl:F('MASTER_spin')
			and ObjectIsVisible(Obj.key) then
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
			and ObjectIsVisible(Obj.key) then
				Texts[GUID] = ''
				Obj.color = NeP.Core:ClassColor(Obj.key)
				gbl:EnemiesSync(Obj)
			end
		end
	end

	--Objects
	for GUID, Obj in pairs(NeP.OM:Get('Objects')) do
		if Obj.distance <= gbl:F('MASTER_spin')
		and ObjectIsVisible(Obj.key) then
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
