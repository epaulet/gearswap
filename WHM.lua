require 'helpers'

function get_sets()
	sets.Idle = {
		main="Homestead Wand",
		sub="Hoplon",
		head="Weath. Corona +1",
		body="Weather. Robe +1",
		hands="Weath. Cuffs +1",
		legs="Weath. Pants +1",
		feet="Weath. Souliers +1",
		neck="Justice Badge",
		waist="Twinthread Obi",
		left_ear="Flashward Earring",
		right_ear="Spellbreaker Earring",
		left_ring="Perception Ring",
		right_ring="Chrysoberyl Ring",
		back="Dew Silk Cape +1",
	}

	sets.Magic = {}
	sets.Magic.Precast = set_combine(sets.Idle, {})
	sets.Magic.Cure = set_combine(sets.Idle, {
		head="Marduk's Tiara +1",
	})
	sets.Magic.Regen = set_combine(sets.Idle, {
		head="Marduk's Tiara +1",
	})
	sets.Magic.Enfeebling = set_combine(sets.Idle, {})
	
	sets.Resting = set_combine(sets.Idle, { waist="Qiqirn Sash" })
	sets.TP = set_combine(sets.Idle, { 
		neck="Focus Collar", 
		left_ear="Fang Earring",
		right_ear="Tortoise Earring",
		left_ring="Oneiros Annulet",
		right_ring="Enlivened Ring",
	})
end

function precast(spell)
	equip(sets.Magic.Precast)
end

function midcast(spell)
	if string.startsWith(spell.en, "Cure") or string.startsWith(spell.en, "Cura") then
		equip(sets.Magic.Cure)
	elseif string.startsWith(spell.en, "Regen") then
		equip(sets.Magic.Regen)
	elseif spell.skill == "Enfeebling Magic" then
		equip(sets.Magic.Enfeebling)
	else
		equip(sets.Idle)
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