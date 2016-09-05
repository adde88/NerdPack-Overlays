local Alpha = 100
local LibDraw = LibStub('LibDraw-1.0')
local F = function(key) return NeP.Interface.fetchKey('NePOverlays', key, false) end

LibDraw.Sync(function()
	if ObjectPosition then
		LibDraw.SetColorRaw(1, 1, 1, Alpha)
		LibDraw.SetWidth(2)

		-- Target Line
		if F('P_TargetLine') and ObjectExists('target') then
			local oX, oY, oZ = ObjectPosition('player')
			local tX, tY, tZ = ObjectPosition('target')
			if not NeP.Engine.LineOfSight('player', 'target') then
				LibDraw.SetColor(255, 87, 87, 70)
			end
			LibDraw.Line(oX, oY, oZ, tX, tY, tZ)
		end
	end
end)