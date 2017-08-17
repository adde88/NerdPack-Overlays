local _, gbl = ...

function gbl:ObjectsSync(Obj)
	-- Name
	if self:F('o_NAME') then
		self:SetText(Obj.key, '|cffFFFFFF'..Obj.name)
	end
	-- Distance
	if self:F('o_DIS') then
		self:SetText(Obj.key, self:Round(Obj.distance)..' yards')
	end
	-- IDs
	if self:F('o_IDs') then
		self:SetText(Obj.key, Obj.id)
	end
end
