-- Dont even load if not advanced
if not ObjectPosition then return end

local _, gbl = ...
local NeP = NeP
local UnitTarget = UnitTarget

function gbl:FriendlySync(Obj)
	-- Distance
	if self:F('f_NAME') then
		self:SetText(Obj.key, '|cff'..Obj.color..Obj.name)
	end
	-- Distance
	if self:F('f_DIS') then
		self:SetText(Obj.key, self:Round(Obj.distance)..' yards')
	end
	-- TTD
	if self:F('f_TTD') then
		self:SetText(Obj.key, 'TTD: '..NeP.DSL:Get('ttd')(Obj.key))
	end
	-- All Targets
	if self:F('f_TLINES') then
		local ObjTarget = UnitTarget(Obj.key)
		if ObjTarget then
			self:DrawLine(Obj.key, ObjTarget)
		end
	end
	-- IDs
	if self:F('f_IDs') then
		self:SetText(Obj.key, 'ID: '..Obj.id)
	end
end
