local _, gbl = ...
local NeP = NeP
local UnitTarget = UnitTarget

function gbl:EnemiesSync(Obj)
	-- Distance
	if self:F('e_NAME') then
		self:SetText(Obj.key, '|cff'..Obj.color..Obj.name)
	end
	-- Distance
	if self:F('e_DIS') then
		local distance = self:Round(Obj.distance)
		self:SetText(Obj.key, distance..' yards')
	end
	-- TTD
	if self:F('e_TTD') then
		self:SetText(Obj.key, 'TTD: '..NeP.DSL:Get('ttd')(Obj.key))
	end
	-- All Targets
	if self:F('e_TLINES') then
		local ObjTarget = UnitTarget(Obj.key)
		if ObjTarget then
			self:DrawLine(Obj.key, ObjTarget)
		end
	end
	-- IDs
	if self:F('e_IDs') then
		self:SetText(Obj.key, 'ID: '..Obj.id)
	end
end
