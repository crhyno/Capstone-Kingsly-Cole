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
			
			
			if (atLedge == 1 && facingLedge != sign(oPlayer.x - x)) state = "chase";
			else if (atLedge != 1) {
				
				distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
				if (distance_to_player < chase_range) state = "chase";
			}
		}
				
	#endregion
	break;
	
	case "chase":
	#region Chase State
	
		
		if (instance_exists(oPlayer)) 
		{
			CheckForEdge(x+hsp + (sprite_width / 2), y+1);
			
			distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
			if (distance_to_player > chase_range) state = "idle";		
			else {	
			
				SpriteStateSet(chaseSprite, 0)																		
				image_xscale = sign(oPlayer.x - x);
		
				if (image_xscale == 0) image_xscale = -1;
		
				distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
		
				if (distance_to_player < attack_range) state = "attack";
				else EnemyMoveAndCollide(image_xscale * walksp, 0);
			}
		} else {			
			vsp = 0;
			state = "idle";
		}

	
	#endregion
	break;
	
	case "attack":
	#region Attack State
		SpriteStateSet(attackSprite, 0);
		
		if (AnimationFrameHit(attackFrameHit))
		{
			CreateHitbox(x, y, self, attackHitBoxSprite, 4, 2, damage, image_xscale);
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
	