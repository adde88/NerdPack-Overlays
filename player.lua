local _, gbl = ...

function gbl:PlayerSync()
	-- Melee range
	if self:F('p_MELEE') then
		self:Circle('player', self:CombatReach('player', 'target') + 1.5)
	end
	-- Melee range
	if self:F('p_RANGED') then
		self:Circle('player', self:CombatReach('player', 'target') + 40)
	end
	-- Targets
	if self:F('p_TLINES') then
			self:DrawLine('player', 'target')
	end
end
