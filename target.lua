-- Dont even load if not advanced
if not ObjectPosition then return end

local _, gbl = ...

function gbl:TargetSync()
	-- Melee range
	if self:F('t_MELEE') then
		self:Circle('target', self:CombatReach('player', 'target') + 1.5)
	end
	-- Melee range
	if self:F('t_RANGED') then
		self:Circle('target', self:CombatReach('player', 'target') + 40)
	end
	-- Targets
	if self:F('t_TLINES') and ObjectIsVisible('targettarget') then
			self:DrawLine('target', 'targettarget')
	end
end
