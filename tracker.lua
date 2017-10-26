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
	-- Treasures
	if self:F('tr_Treasures')
  and self.Treasures.ids[Obj.id] then
		self:SetTexture(Obj.key, self.Treasures.texture, distance)
		self:SetText(Obj.key, Obj.name)
		self:SetText(Obj.key, distance..' yards')
	end
	-- Wyrmtongue Chests
	if self:F('tr_Wyrmtongue')
  and self.WymrtongueCaches.ids[Obj.id] then
		self:SetTexture(Obj.key, self.WymrtongueCaches.texture, distance)
		self:SetText(Obj.key, Obj.name)
		self:SetText(Obj.key, distance..' yards')
	end
	-- Argus Chests
	if self:F('tr_ArgusChests')
  and self.ArgusChests.ids[Obj.id] then
		self:SetTexture(Obj.key, self.ArgusChests.texture, distance)
		self:SetText(Obj.key, Obj.name)
		self:SetText(Obj.key, distance..' yards')
	end
	-- Legion War Supplies
	if self:F('tr_WarSuppplies')
  and self.LegionWarSupplies.ids[Obj.id] then
		self:SetTexture(Obj.key, self.LegionWarSupplies.texture, distance)
		self:SetText(Obj.key, Obj.name)
		self:SetText(Obj.key, distance..' yards')
	end
end
