local Alpha = 100
local LibDraw = LibStub('LibDraw-1.0')
local F = function(key) return NeP.Interface.fetchKey('NePOverlays', key, false) end

LibDraw.Sync(function()
	if ObjectPosition then
		local pX, pY, pZ = ObjectPosition('player')
		LibDraw.SetColorRaw(1, 1, 1, Alpha)
		LibDraw.SetWidth(2)
		for i=1,#NeP.OM.unitFriend do
			local Obj = NeP.OM.unitFriend[i]
			if ObjectExists(Obj.key) then

				-- All Targets
				if F('F_TARGET') then
					local ObjTarget = UnitTarget(Obj.key)
					if ObjectExists(ObjTarget) then
						local oX, oY, oZ = ObjectPosition(Obj.key)
						local tX, tY, tZ = ObjectPosition(ObjTarget)
						if not NeP.Engine.LineOfSight(Obj.key, ObjTarget) then
							LibDraw.SetColor(255, 87, 87, 70)
						end
						LibDraw.Line(oX, oY, oZ, tX, tY, tZ)
					end
				end
						
				-- Textures
				if F('Draw_FRIENDLY_PLAYERS') and UnitIsPlayer(Obj.key) then
					local factionGroup, factionName = UnitFactionGroup(Obj.key)
					if factionGroup == 'Alliance' then
						local tempT = NeP.Overlays.Textures['ALLIANCE']
						NeP.Overlays.SetTexture(Obj.key, tempT)
					elseif factionGroup == 'Horde' then
						local tempT = NeP.Overlays.Textures['HORDE']
						NeP.Overlays.SetTexture(Obj.key, tempT)
					end
				end

			end
		end
	end
end)