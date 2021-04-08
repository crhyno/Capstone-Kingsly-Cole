if (state == "attack") 
{
	if (instance_exists(oPlayer)) 
	{
		if (oPlayer.x > x + attack_range || oPlayer.x < x - attack_range) state = "chase";
		else {
			state = "attack";
		}
	} else state = "idle";
	
}