local name, Overlays = ...

Overlays.MiningOres = {
	texture = 'Interface\\Icons\\inv_ore_copper_01',
	ids = {
		--	Legion Ores
		--		Leystones
		[241726] = 'Leystone Deposit',
		[253280] = 'Leystone Seam',
		[247916] = 'Ancient Leystone Deposit',
		[247910] = 'Fine Leystone Deposit',
		[247938] = 'Gleaming Leystone Outcropping',
		[247908] = 'Glowing Leystone Deposit',
		[247937] = 'Luminous Leystone Outcropping',
		[245324] = 'Rich Leystone Deposit',
		[247909] = 'Smooth Leystone Deposit',
		[247904] = 'Bright Leystone Deposit',
		[247936] = 'Coarse Leystone Outcropping',
		[247340] = 'Crude Leystone Seam',
		[247906] = 'Fiery Leystone Deposit',
		[247352] = 'Hard Leystone Deposit',
		[247907] = 'Massive Leystone Deposit',
		[247366] = 'Rough Leystone Outcropping',
		[247911] = 'Charged Leystone Deposit',
		[247905] = 'Warm Leystone Deposit',
		[247917] = 'Dark Leystone Deposit',
		[247941] = 'Dense Leystone Outcropping',
		[247918] = 'Stormy Leystone Deposit',
		[247915] = 'Striking Leystone Deposit',
		[247989] = 'Wild Leystone Seam',
		[247912] = 'Exquisite Leystone Deposit',
		[247940] = 'Hardened Leystone Outcropping',
		[247913] = 'Magnificent Leystone Deposit',
		[247939] = 'Radiant Leystone Outcropping',
		[247988] = 'Raw Leystone Seam',
		[247914] = 'Superior Leystone Deposit',
		--		Others
		[247075] = 'Secreted Wax Glob',
		[251181] = 'Azure Ore',
		--		Felslate
		[241743] = 'Felslate Deposit',
		[255344] = 'Felslate Seam',
		[245325] = 'Rich Felslate Deposit',
		[247923] = 'Darkened Felslate Deposit',
		[247925] = 'Heavy Felslate Deposit',
		[247699] = 'Primordial Felslate Deposit',
		[247698] = 'Shattered Felslate Seam',
		--		Brimstone Destroyer Cores
		[247370] = 'Brimstone Destroyer Core',
		[247969] = 'Brimstone Destroyer Core',
		[247968] = 'Brimstone Destroyer Core',
		[247967] = 'Brimstone Destroyer Core',
		[247966] = 'Brimstone Destroyer Core',
		[247965] = 'Brimstone Destroyer Core',
		[247964] = 'Brimstone Destroyer Core',
		[247963] = 'Brimstone Destroyer Core',
		[247962] = 'Brimstone Destroyer Core',
		[247961] = 'Brimstone Destroyer Core',
		[247960] = 'Brimstone Destroyer Core',
		[247959] = 'Brimstone Destroyer Core',
		[247958] = 'Brimstone Destroyer Core'
	}
}

Overlays.ManaShards = {
	texture = 'Interface\\Icons\\inv_leycrystalsmall',
	ids = {
		--[[ //// Legion //// ]]
		[260249] = 'Ancient Mana Shard',
		[260248] = 'Ancient Mana Shard',
		[252774] = 'Ancient Mana Crystal',
		[252772] = 'Ancient Mana Chunk',
		[252408] = 'Ancient Mana Shard',
		[252450] = 'Shimmering Ancient Mana Cluster',
		[252449] = 'Shimmering Ancient Mana Cluster',
		[252448] = 'Shimmering Ancient Mana Cluster',
		[252447] = 'Shimmering Ancient Mana Cluster',
		[252446] = 'Shimmering Ancient Mana Cluster',
		[252423] = 'Shimmering Ancient Mana Cluster',
		[251416] = 'Ancient Mana Chunk',
		[245126] = 'Crystallized Ancient Mana',
		[260498] = 'Leypetal Blossom'
	}
}

Overlays.FishPoles = {
	texture = 'Interface\\AddOns\\'..name..'\\media\\mob.blp', -- FIXME: needs a new icon
	ids = {
		--[[ //// WOD //// ]]
		[229072] = 'Abyssal Gulper School',
		[229073] = 'Blackwater Whiptail School',
		[229069] = 'Blind Lake Sturgeon School',
		[229068] = 'Fat Sleeper School',
		[243325] = 'Felmouth Frenzy School',
		[243354] = 'Felmouth Frenzy School',
		[229070] = 'Fire Ammonite School',
		[229067] = 'Jawless Skulker School',
		[236756] = 'Oily Abyssal Gulper School',
		[237295] = 'Oily Sea Scorpion School',
		[229071] = 'Sea Scorpion School',
		[246492] = 'Runescale Koi Scool'
	}
}

Overlays.EphemeralCrystals = {
	texture = 'Interface\\AddOns\\'..name..'\\media\\mob.blp', -- FIXME: needs a new icon
	ids = {
		[251183] = 'Ephemeral Crystal',
		[251185] = 'Ephemeral Crystal',
		[251186] = 'Ephemeral Crystal',
		[251187] = 'Ephemeral Crystal',
		[251168] = 'Ephemeral Crystal'
	}
}

Overlays.WymrtongueCaches = {
	texture = 'Interface\\AddOns\\'..name..'\\media\\wyrmtongue.blp',
	ids = {
		[268468] = 'Hidden Wyrmtongue Cache',
		[271227] = 'Hidden Wyrmtongue Cache'
	}
}

Overlays.LegionWarSupplies = {
	texture = 'Interface\\AddOns\\'..name..'\\media\\wyrmtongue.blp',
	ids = {
		[273524] = 'Legion War Supplies'
	}
}

Overlays.Treasures = {
	texture = 'Interface\\AddOns\\'..name..'\\media\\mob.blp', -- FIXME: needs a new icon
	ids = {
		[251954] = 'Small Treasure Chest',
		[251743] = 'Glimmering Treasure Chest',
		[268468] = 'Hidden Wyrmtongue Cache'
	}
}

Overlays.Textures = {
	['HORDE'] = 'Interface\\AddOns\\NerdPack-Overlays\\media\\horde.blp', -- FIXME: needs a new icon
	['ALLIANCE'] = 'Interface\\AddOns\\NerdPack-Overlays\\media\\alliance.blp', -- FIXME: needs a new icon
	['BOSS'] = 'Interface\\AddOns\\NerdPack-Overlays\\media\\boss.blp', -- FIXME: needs a new icon
	['MOB'] = 'Interface\\AddOns\\NerdPack-Overlays\\media\\mob.blp', -- FIXME: needs a new icon
	['RARE'] = 'Interface\\AddOns\\NerdPack-Overlays\\media\\mob.blp' -- FIXME: needs a new icon
}
