if (state == "attack") 
{
	if (instance_exists(oPlayer)) 
	{
		distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
		if (distance_to_player > 90) {
			state = "chase";
		}
		image_index = 0;
	} else state = "idle";
	
}