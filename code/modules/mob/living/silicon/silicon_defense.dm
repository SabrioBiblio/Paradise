/mob/living/silicon/grippedby(mob/living/grabber, grab_state_override)
	return FALSE //can't upgrade a simple pull into a more aggressive grab.

/mob/living/silicon/attack_alien(mob/living/carbon/alien/humanoid/M)
	if(..()) //if harm or disarm intent
		var/damage = M.attack_damage
		if(prob(90))
			playsound(loc, 'sound/weapons/slash.ogg', 25, 1, -1)
			visible_message("<span class='danger'>[M] has slashed at [src]!</span>", "<span class='userdanger'>[M] has slashed at [src]!</span>")
			if(prob(8))
				flash_eyes(affect_silicon = 1)
			add_attack_logs(M, src, "Alien attacked")
			adjustBruteLoss(damage)
			updatehealth()
		else
			playsound(loc, 'sound/weapons/slashmiss.ogg', 25, 1, -1)
			visible_message("<span class='danger'>[M] took a swipe at [src]!</span>", \
							"<span class='userdanger'>[M] took a swipe at [src]!</span>")
	return

/mob/living/silicon/attack_animal(mob/living/simple_animal/M)
	. = ..()
	if(.)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		switch(M.melee_damage_type)
			if(BRUTE)
				adjustBruteLoss(damage)
			if(BURN)
				adjustFireLoss(damage)
			if(TOX)
				adjustToxLoss(damage)
			if(OXY)
				adjustOxyLoss(damage)
			if(CLONE)
				adjustCloneLoss(damage)
			if(STAMINA)
				adjustStaminaLoss(damage)
		updatehealth()

/mob/living/silicon/attack_larva(mob/living/carbon/alien/larva/L)
	if(L.a_intent == INTENT_HELP)
		visible_message("<span class='notice'>[L.name] rubs its head against [src].</span>")

/mob/living/silicon/attack_hand(mob/living/carbon/human/M)
	switch(M.a_intent)
		if(INTENT_HELP)
			M.visible_message("<span class='notice'>[M] pets [src]!</span>", \
							"<span class='notice'>You pet [src]!</span>")
			playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
		if(INTENT_GRAB)
			remove_from_head(M)
			grabbedby(M)
		else
			M.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
			playsound(loc, 'sound/effects/bang.ogg', 10, 1)
			visible_message("<span class='notice'>[M] punches [src], but doesn't leave a dent.</span>", \
						"<span class='notice'>[M] punches [src], but doesn't leave a dent.</span>")
	return FALSE
