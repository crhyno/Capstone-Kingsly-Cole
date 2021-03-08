hsp = dir * walksp;
vsp += grv;

switch (state) {
	
	case "idle":
	#region Idle State
	
		sprite_index = sGoblin;
		image_xscale = sign(oPlayer.x - x);
		
		if (image_xscale == 0) image_xscale = 1;
	
		//Vertical collision
		if (place_meeting(x,y+vsp,oWall)) 
		{
			Collision(x, y+vsp);
			vsp = 0;

		}
		y = y + vsp;
				
		if (image_xscale == 1) {
			if (x + 400 <= oPlayer.x) state = "chase";
		}
		if (image_xscale == -1) {
			if (x - 400 <= oPlayer.x) state = "chase";
		}
				
	#endregion
	break;
	
	case "chase":
	#region Chase State
	
		sprite_index = sGoblinR
		image_xscale = sign(oPlayer.x - x);
		
		if (image_xscale == 0) image_xscale = 1;
		
		distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
		
		if (distance_to_player > 120)
		{
			EnemyMoveAndCollide(image_xscale * 1, 0)
		}
		if (distance_to_player <= 120) state = "attack"
		
	#endregion
	break;
	
	case "attack":
	#region Attack State
		SpriteStateSet(sGoblinA, 0);			
	#endregion
	break;
	
}