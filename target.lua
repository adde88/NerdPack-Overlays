local _, gbl = ...

function gbl:TargetSync()
	-- Melee range
	if self:F('t_MELEE') and NeP.Protected.ObjectExists('target') and _G.ObjectIsVisible('target') then
		self:Circle('target', self:CombatReach('player', 'target') + 1.5)
	end
	-- Melee range
	if self:F('t_RANGED') and NeP.Protected.ObjectExists('target') and _G.ObjectIsVisible('target') then
		self:Circle('target', self:CombatReach('player', 'target') + 40)
	end
	-- Targets
	if self:F('t_TLINES') and NeP.Protected.ObjectExists('targettarget') and _G.ObjectIsVisible('targettarget') then
			self:DrawLine('target', 'targettarget')
	end
end
