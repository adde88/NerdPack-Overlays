-- Dont even load if not advanced
if not ObjectPosition then return end

local _, gbl = ...

function gbl:TrackerSync(Obj)
	local distance = self:Round(Obj.distance)
	-- ManaShards
	if self:F('tr_ManaShards')
  and self.ManaShards.ids[Obj.id] then
		self:SetTexture(Obj.key, self.ManaShards.texture, distance)
		self:SetText(Obj.key, Obj.name)
		self:SetText(Obj.key, distance..' yards')
	end
	-- FishingPoles
	if self:F('tr_FishPoles')
  and self.FishPoles.ids[Obj.id] then
		self:SetTexture(Obj.key, self.FishPoles.texture, distance)
		self:SetText(Obj.key, Obj.name)
		self:SetText(Obj.key, distance..' yards')
	end
	-- MiningOres
	if self:F('tr_MiningOres')
  and self.MiningOres.ids[Obj.id] then
		self:SetTexture(Obj.key, self.MiningOres.texture, distance)
		self:SetText(Obj.key, Obj.name)
		self:SetText(Obj.key, distance..' yards')
	end
	-- Ephemeral Crystal
	if self:F('tr_EphemeralCrystals')
  and self.EphemeralCrystals.ids[Obj.id] then
		self:SetTexture(Obj.key, self.EphemeralCrystals.texture, distance)
		self:SetText(Obj.key, Obj.name)
		self:SetText(Obj.key, distance..' yards')
	end
	-- Tresures
	if self:F('tr_Tresures')
  and self.Tresures.ids[Obj.id] then
		self:SetTexture(Obj.key, self.Tresures.texture, distance)
		self:SetText(Obj.key, Obj.name)
		self:SetText(Obj.key, distance..' yards')
	end
end
