hsp = dir * walksp;
vsp += grv;

switch (state) {
	
	case "idle":
		#region Idle State
	
			//If the player deos not exist, restart game
			if (!instance_exists(oPlayer)) {
				hsp = 0;
				vsp = 0;
				sprite_index = idleSprite;
				SlideTransition("restart");
			}
			else {	
			
				//Sets sprite and frame, direction depending on where player is
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
			
			
				//Checks to see if the enemy is at a ledge and if the player is the opposite direction of
				// the direction of the ledge, if so set state to chase
				if (atLedge == 1 && facingLedge != sign(oPlayer.x - x)) state = "chase";
				//if the enemy is not at a ledge and the distance to the player is less than the chase range,
				// set the state to chase
				else if (atLedge != 1) {
				
					distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
					if (distance_to_player < chase_range) state = "chase";
				}
			}
				
		#endregion
		break;
	
	case "chase":
		#region Chase State
		
			//If the player exists
			if (instance_exists(oPlayer)) 
			{
				//Checks to see if the enemy is at a ledge
				CheckForEdge(x+hsp + (sprite_width / 2), y+1);
			
				//If the player is out of the chase range, set state to idle
				distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
				if (distance_to_player > chase_range) state = "idle";		
				else {	
			
					//Set sprite and frame, direction the animation is facing
					SpriteStateSet(chaseSprite, 0)																		
					image_xscale = sign(oPlayer.x - x);
		
					if (image_xscale == 0) image_xscale = -1;
		
					distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
		
					//If the player is within the attack range, set state to attack, if not
					// continue to move and collide
					if (distance_to_player < attack_range) state = "attack";
					else MoveAndCollide(image_xscale * walksp, 0);
				}
			//Set state to idle
			} else {			
				state = "idle";
			}

	
		#endregion
		break;
	
	case "attack":
		#region Attack State
			//Set sprite and frame
			SpriteStateSet(attackSprite, 0);
		
			//If a specific fram eis hit, create a hitbox
			if (AnimationFrameHit(attackFrameHit))
			{
				CreateHitbox(x, y, self, attackHitBoxSprite, knockbackDistance, 1, damage, image_xscale);
			}
		#endregion
		break;
	
	case "hit":
		#region Hit State
				
			Knockback(hitSprite, "chase");

		#endregion
		break;
	
	default:
		show_debug_message("State " + state + " does not exsist");
		state = "chase";
}
	