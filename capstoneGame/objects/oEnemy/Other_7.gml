//At the end of the attack animation
if (state == "attack") 
{
	//If the player still exists
	if (instance_exists(oPlayer)) 
	{	
		distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);	
		
		//Continue to attack the player is the player is not out of the attack range, if so
		// set state back to chase
		if (distance_to_player > attack_range) state = "chase";
		else {
			state = "attack";
		}
	} else {
		
		state = "idle";
	}
	
}
if (state == "hit") 
{
	distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
	
	if (distance_to_player > attack_range) state = "chase";
		else {
			state = "attack";
		}
}