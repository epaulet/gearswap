function get_sets()
	sets.TP = {
		main="Homestead Dagger",
		sub="Eminent Dagger",
		range="Staurobow",
		ammo="Blind Bolt",
		head="Shned. Chapeau +1",
		body="Shned. Tabard +1",
		hands="Shned. Gloves +1",
		legs="Shned. Tights +1",
		feet="Shned. Boots +1",
		neck="Focus Collar",
		waist="Swordbelt",
		left_ear="Fang Earring",
		right_ear="Tortoise Earring",
		left_ring="Oneiros Annulet",
		right_ring="Oneiros Ring",
		back="Meanagh Cape +1",
	}
	
	sets.TA = set_combine(sets.TP, { 
		neck="Crested Torque", 
		left_ring="Jadeite Ring" 
	})
	
	sets.SA = set_combine(sets.TP, { 
		left_ring="Fluorite Ring", 
		right_ring="Enlivened Ring" 
	})
	
	sets.RA = set_combine(sets.TP, {
		neck="Crested Torque",
		left_ring="Jadeite Ring", 
		right_ring="Carapace Ring" 
	})
	
	sets.WS = {}
	sets.WS["Dancing Edge"] = set_combine(sets.TP, { 
		left_ring="Fluorite Ring",
		right_ring = "Enlivened Ring" 
	})
	
	sets.WS.SA = {}
	sets.WS.SA["Shark Bite"] = set_combine(sets.TP, { 
		left_ring="Fluorite Ring", 
		right_ring="Enlivened Ring" 
	})
	
	sets.WS.TA = {}
	sets.WS.TA["Shark Bite"] = set_combine(sets.TP, { 
		left_ring="Fluorite Ring", 
		right_ring="Enlivened Ring" 
	})
	
	sets.Steal = set_combine(sets.TP, {
		head="Rogue's Bonnet",
		hands="Rogue's Armlets",
		legs="Rogue's Culottes",
		feet="Rogue's Poulaines",
	})
	
	sets.Flee = set_combine(sets.TP, { feet="Rogue's Poulaines" })
end

function buff_change(buff, buff_gained)
	if buff == "Trick Attack" then
		if buff_gained then
			equip(sets.TA)
		else
			equip(sets.TP)
		end
	end
	if buff == "Sneak Attack" then
		if buff_gained then
			equip(sets.SA)
		else
			equip(sets.TP)
		end
	end
end

function precast(spell)
	if spell.type == "WeaponSkill" then
		if buffactive["sneak attack"] and sets.WS.SA[spell.english] then
			equip(sets.WS.SA[spell.english])
		elseif buffactive["trick attack"] and sets.WS.TA[spell.english] then
			equip(sets.WS.TA[spell.english])
		elseif sets.WS[spell.english] then
			equip(sets.WS[spell.english])
		end
	elseif spell.type == "JobAbility" then
		if spell.english == "Flee" then
			equip(sets.Flee)
		elseif spell.english == "Steal" then
			equip(sets.Steal)
		end
	end
end

function midcast(spell)
	if spell.action_type == 'Ranged Attack' then
		equip(sets.RA)	
	end
end

function aftercast(spell)
	if spell.action_type == 'Ranged Attack' or spell.type == "WeaponSkill" then
		equip(sets.TP)
	elseif spell.type == "JobAbility" then
		if spell.english == "Flee" or spell.english == "Steal" then
			equip(sets.TP)
		end
	end
end

function status_change(new, old)
	if new == "Engaged" then
		if buffactive["sneak attack"] then
			equip(sets.SA)
		elseif buffactive["trick attack"] then
			equip(sets.TA)
		else
			equip(sets.TP)
		end
	end
end