hsp = dir * walksp;
vsp += grv;

switch (state) {
	
	case "idle":
	#region Idle State
	
		if (!instance_exists(oPlayer)) {
			hsp = 0;
			vsp = 0;
			sprite_index = idleSprite;
			SlideTransition("restart");
		}
		else if (atLedge == 1 && facingLedge != sign(oPlayer.x - x)) state = "chase";
		else {	
			
			SpriteStateSet(idleSprite, 0);
			image_xscale = sign(oPlayer.x - x);
		
			if (image_xscale == 0) image_xscale = -1;
	
			//Vertical collision
			if (place_meeting(x,y+vsp,oWall)) 
			{
				Collision(x, y+vsp);
				vsp = 0;
			}
			y = y + vsp;
			
			if (atLedge != 1) {
				if (oPlayer.x <= x + chase_range || oPlayer.x <= x - chase_range) state = "chase";
				else if (oPlayer.y <= y - chase_rangeY || oPlayer.y <= y + chase_rangeY) state = "chase";
				else state = "idle";
			}
		}
				
	#endregion
	break;
	
	case "chase":
	#region Chase State
	
		CheckForEdge(x+hsp + (sprite_width / 2), y+1);
		
		if (instance_exists(oPlayer)) 
		{
			if (oPlayer.x > x + chase_range || oPlayer.x < x - chase_range) state = "idle";
			else if (oPlayer.y > y + chase_rangeY || oPlayer.y < y - chase_rangeY) state = "idle";		
			else {	
			
				SpriteStateSet(chaseSprite, 0)																		
				image_xscale = sign(oPlayer.x - x);
		
				if (image_xscale == 0) image_xscale = -1;
		
				distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
		
				if (distance_to_player < attack_range) state = "attack";
				else EnemyMoveAndCollide(image_xscale * walksp, 0);
			}
		} else {
			atLedge = 0;
			state = "idle";
		}

	
	#endregion
	break;
	
	case "attack":
	#region Attack State
		SpriteStateSet(attackSprite, 0);
		
		if (AnimationFrameHit(attackFrameHit))
		{
			CreateHitbox(x, y, self, attackHitBoxSprite, 4, 2, 0, image_xscale);
		}
	#endregion
	break;
	
	case "hit":
	#region Hit State
		SpriteStateSet(hitSprite, 0);
	#endregion
	break;
	
	case "dead":
	#region Dead State
		SpriteStateSet(deadSprite, 0);
	#endregion
	break;
}
	