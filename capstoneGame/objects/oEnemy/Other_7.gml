if (state == "attack") 
{
	if (instance_exists(oPlayer)) 
	{	
		distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);	
		
		if (distance_to_player > attack_range) state = "chase";
		else {
			image_index = 0;
			state = "attack";
		}
	} else {
		
		image_index = 0;
		state = "idle";
	}
	
}