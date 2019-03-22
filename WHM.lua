require 'helpers'

function get_sets()
	sets.Idle = {
		main="Homestead Wand",
		sub="Sors Shield",
		ammo="Homiliary",
		head="Weath. Corona +1",
		body="Gendewitha Bliaut",
		hands="Weath. Cuffs +1",
		legs="Weath. Pants +1",
		feet="Weath. Souliers +1",
		neck="Justice Badge",
		waist="Twinthread Obi",
		left_ear="Flashward Earring",
		right_ear="Spellbreaker Earring",
		left_ring="Perception Ring",
		right_ring="Chrysoberyl Ring",
		back="Pahtli Cape",
	}

	sets.Magic = {}
	sets.Magic.Precast = {}
	sets.Magic.Precast.Base = set_combine(sets.Idle, {})

	-- TODO: Differentiate offensive and defensive Cure
	sets.Magic.Precast.Cure = set_combine(sets.Magic.Precast.Base, {})

	sets.Magic.Midcast = {}
	sets.Magic.Midcast.Base = set_combine(sets.Idle, {
		head="Telchine Cap",
		body="Weather. Robe +1",
		back="Dew Silk Cape +1",
	})
	-- TODO: Single target vs AOE heals once I have healing vs MND gear
	sets.Magic.Midcast.Cure = set_combine(sets.Magic.Midcast.Base, {
		head="Marduk's Tiara +1",
		body="Gendewitha Bliaut",
	})
	sets.Magic.Midcast.Regen = set_combine(sets.Magic.Midcast.Base, {
		head="Marduk's Tiara +1",
	})
	
	sets.Resting = set_combine(sets.Idle, { waist="Qiqirn Sash" })

	-- TODO: WS set
	sets.TP = set_combine(sets.Idle, {
		head="Telchine Cap",
		neck="Focus Collar",
		body="Weather. Robe +1",
		left_ear="Fang Earring",
		right_ear="Tortoise Earring",
		left_ring="Oneiros Annulet",
		right_ring="Enlivened Ring",
		back="Dew Silk Cape +1"
	})
end

function precast(spell)
	if isCure(spell.en) then
		equip(sets.Magic.Precast.Cure)
	else
		equip(sets.Magic.Precast.Base)
	end
end

function midcast(spell)
	if isCure(spell.en) then
		equip(sets.Magic.Midcast.Cure)
	elseif string.startsWith(spell.en, "Regen") then
		equip(sets.Magic.Midcast.Regen)
	else
		equip(sets.Magic.Midcast.Base)
	end
end

function aftercast(spell)
	if player.status == "Engaged" then
		equip(sets.TP)
	else
		equip(sets.Idle)
	end
end

function status_change(new, old)
	if new == "Resting" then
		equip(sets.Resting)
	elseif new == "Engaged" then
		equip(sets.TP)
	elseif new == "Idle" then
		equip(sets.Idle)
	end
end

function isCure(spellname)
	return string.startsWith(spellname, "Cure") or string.startsWith(spellname, "Cura")
end