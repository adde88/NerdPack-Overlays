local Alpha = 100
local LibDraw = LibStub('LibDraw-1.0')
local F = function(key) return NeP.Interface.fetchKey('NePOverlays', key, false) end
local Round = NeP.Core.Round

LibDraw.Sync(function()
	if ObjectPosition then

		local pX, pY, pZ = ObjectPosition('player')
		LibDraw.SetColorRaw(1, 1, 1, Alpha)
		LibDraw.SetWidth(2)

		for i=1, #NeP.OM.GameObjects do
			local Obj = NeP.OM.GameObjects[i]
			if UnitGUID(Obj.key) and ObjectExists(Obj.key) then
				
				local oX, oY, oZ = ObjectPosition(Obj.key)
				local distance = Round(Obj.distance)

				if F('MANA_SHARDS') and NeP.Overlays.ManaShards.ids[Obj.id] then
					local tempT = NeP.Overlays.ManaShards.texture
					NeP.Overlays.SetTexture(Obj.key, tempT)
				elseif F('FISHING_POOLS') and NeP.Overlays.Fish.ids[Obj.id] then
					local tempT = NeP.Overlays.Fish.texture
					NeP.Overlays.SetTexture(Obj.key, tempT)
				end

			end
		end

	end
end)