local n_name, gbl = ...

local config = {
	key = n_name,
	title = n_name,
	subtitle = 'Settings',
	width = 200,
	height = 400,
	profiles = true,
	config = {

		-- General
		{ type = 'header', text = 'General' },
		{ type = 'checkspin', text = 'Enable', key = 'MASTER', check = false, spin = 100, max = 200,
			desc = "Slide the spinner to control the maximum distance"},
		{ type = 'input', text = 'Refresh rate', key = 'refresh', default = 0.01 },
		{ type = 'spacer' },{ type = 'ruler' },

		-- Player
		{ type = 'header', text = 'Player' },
		{ type = 'checkbox', text = 'Melee', key = 'p_MELEE', default = false },
		{ type = 'checkbox', text = 'Ranged', key = 'p_RANGED', default = false },
		{ type = 'checkbox', text = 'Target lines', key = 'p_TLINES', default = false },
		{ type = 'spacer' },{ type = 'ruler' },

		-- target
		{ type = 'header', text = 'Target' },
		{ type = 'checkbox', text = 'Melee', key = 't_MELEE', default = false },
		{ type = 'checkbox', text = 'Ranged', key = 't_RANGED', default = false },
		{ type = 'checkbox', text = 'Target lines', key = 't_TLINES', default = false },
		{ type = 'spacer' },{ type = 'ruler' },

		-- Enemies
		{ type = 'header', text = 'Enemies' },
		{ type = 'checkbox', text = 'Enable', key = 'e_MASTER', default = false },
		{ type = 'checkbox', text = 'Name', key = 'e_NAME', default = false },
		{ type = 'checkbox', text = 'Distance', key = 'e_DIS', default = false },
		{ type = 'checkbox', text = 'TTD', key = 'e_TTD', default = false },
		{ type = 'checkbox', text = 'Target lines', key = 'e_TLINES', default = false },
		{ type = 'checkbox', text = 'IDs', key = 'e_IDs', default = false },
		{ type = 'spacer' },{ type = 'ruler' },

		-- Friendly
		{ type = 'header', text = 'Friendly' },
		{ type = 'checkbox', text = 'Enable', key = 'f_MASTER', default = false },
		{ type = 'checkbox', text = 'Name', key = 'f_NAME', default = false },
		{ type = 'checkbox', text = 'Distance', key = 'f_DIS', default = false },
		{ type = 'checkbox', text = 'TTD', key = 'f_TTD', default = false },
		{ type = 'checkbox', text = 'Target lines', key = 'f_TLINES', default = false },
		{ type = 'checkbox', text = 'IDs', key = 'f_IDs', default = false },
		{ type = 'spacer' },{ type = 'ruler' },

		--tracker
		{ type = 'header', text = 'Tracker' },
		{ type = 'checkbox', text = 'Enable', key = 'tr_MASTER', default = false },
		{ type = 'checkbox', text = 'Track Mana Shards', key = 'tr_ManaShards', default = false },
		{ type = 'checkbox', text = 'Track Fish Pools', key = 'tr_FishPoles', default = false },
		{ type = 'checkbox', text = 'Track Mining Ores', key = 'tr_MiningOres', default = false },
		{ type = 'checkbox', text = 'Track Ephemeral Crystals', key = 'tr_EphemeralCrystals', default = false },
		{ type = 'checkbox', text = 'Track Treasures', key = 'tr_Treasures', default = false },
		{ type = 'checkbox', text = 'Track Wyrmtongue Caches', key = 'tr_Wyrmtongue', default = false },
		{ type = 'checkbox', text = 'Track Argus Chests', key = 'tr_ArgusChests', default = false },
		{ type = 'checkbox', text = 'Track Legion War Supplies', key = 'tr_WarSuppplies', default = false },

		{ type = 'spacer' },{ type = 'ruler' },

		-- Objects
		{ type = 'header', text = 'Objects' },
		{ type = 'checkbox', text = 'Enable', key = 'o_MASTER', default = false },
		{ type = 'checkbox', text = 'Name', key = 'o_NAME', default = false },
		{ type = 'checkbox', text = 'Distance', key = 'o_DIS', default = false },
		{ type = 'checkbox', text = 'IDs', key = 'o_IDs', default = false },
	}
}

-- Create the GUI and add it to NeP
gbl.GUI = _G.NeP.Interface:BuildGUI(config)
_G.NeP.Interface:Add(n_name..' V:'..gbl.Version, function() gbl.GUI.parent:Show() end)
gbl.GUI.parent:Hide()
