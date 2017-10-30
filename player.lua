local _, gbl = ...

function gbl:PlayerSync()
	-- Melee range
	if self:F('p_MELEE') and NeP.Protected.ObjectExists('target') then
		self:Circle('player', self:CombatReach('player', 'target') + 1.5)
	end
	-- Melee range
	if self:F('p_RANGED') and NeP.Protected.ObjectExists('target') and _G.ObjectIsVisible('target') then
		self:Circle('player', self:CombatReach('player', 'target') + 40)
	end
	-- Targets
	if self:F('p_TLINES') and NeP.Protected.ObjectExists('target') and _G.ObjectIsVisible('target') then
			self:DrawLine('player', 'target')
	end
end
