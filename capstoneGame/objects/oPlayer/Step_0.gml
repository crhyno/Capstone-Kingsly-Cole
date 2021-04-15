//Gets the players input if the player has control
if (hasControl) 
{
	key_left = keyboard_check(ord("A"));
	key_right = keyboard_check(ord("D"));
	key_jump = keyboard_check_pressed(ord("W"));
	key_roll = keyboard_check_pressed(vk_space);
	key_attack = keyboard_check_pressed(ord("Q"));
	key_attack2 = keyboard_check_pressed(ord("Q"));
	key_attack3 = keyboard_check_pressed(ord("E"));
} 
else 
{
	key_left = 0;
	key_right = 0;
	key_jump = 0;
	key_roll = 0;
}

//Calculate movement
var move = key_right - key_left;

hsp = move * walksp;
vsp = vsp + grv;

switch (state) 
{
	case "move":
		#region Move State
	
			image_speed = 1;
			//Jumping
			if (place_meeting(x, y+1, oWall)) && (key_jump)
			{
				vsp = -10;
				audio_play_sound(mJump,100,0)
			}

			//Horizontal collision
			if (place_meeting(x+hsp,y,oWall)) 
			{
				Collision(x+hsp, y);
				hsp = 0;
			}
			x = x + hsp;

			//Vertical collision
			if (place_meeting(x,y+vsp,oWall)) 
			{
				Collision(x, y+vsp);
				vsp = 0;
			}
			y = y + vsp;

			//Animation
			if (!place_meeting(x, y+1, oWall)) 
			{
				sprite_index = sPlayerJ;
				if (sign(vsp) > 0) sprite_index = sPlayerF;
				else if (sign(vsp) < 0) sprite_index = sPlayerJ;
			}
			else 
			{
				if (hsp == 0) 
				{
					sprite_index = sPlayer;
				}
				else {
					sprite_index = sPlayerR;
				}
			}

			if (hsp != 0) image_xscale = sign(hsp);
	
			//If vertical speed equals zero check to see if attack1 key is hit and depending on
			// the direction the player is facing and if the player is not too close to a wall,
			// switch state to attack one
			if (vsp == 0) 
			{
				if (key_attack == 1) 
				{
					if (image_xscale == 1) {
					
						if (!place_meeting(x + 10, y, oWall)) {
							state = "attack one";
						}
					}
					if (image_xscale == -1) {
					
						if (!place_meeting(x - 10, y, oWall)) {
							state = "attack one";
						}
					}
				}
				//If roll key is hit, change state to roll
				if (key_roll == 1) {
					state = "roll";
				}
			}
			
		
		#endregion
		break;
		
	case "roll":
		#region Roll State
		
			//Sets sprite and frame
			SpriteStateSet(sPlayerRO, 0);
			
			//Checks to see if too close to wall
			if (!place_meeting(x + 1, y, oWall) || !place_meeting(x - 1, y, oWall)) 
			{				
				
				//Based on direction of player, move horizontally based on current x position
				image_speed = 1.5;
				if (image_xscale == -1) x -= 6;
				if (image_xscale == 1) x += 6;
				
				//If the player hits wall in the middle of roll, change state back to move
				if (!place_meeting(x,y + 40,oWall)) 
				{
					state = "move";
				}
			
				//If a specific frame is hit, change state to move
				if (AnimationFrameHit(8)) state = "move";
			
			//Change state back to move and push player back from wall
			} else {
				state = "move";
				if (image_xscale == -1) x += 2;
				if (image_xscale == 1) x -= 2; 
				hsp = 0;
			}
			
		#endregion
		break;
		
	case "attack one":
		#region Attack One State	
	
			//Sets sprite and frame
			SpriteStateSet(sPlayerA, 0);
			
			//Creates a hitbox object based on a specific frame hit within the animation
			if (AnimationFrameHit(2))
			{
				CreateHitbox(x, y, self, sPlayerAHB, 8, 1, 5, image_xscale);
				audio_play_sound(mSwordFast,500,0)
			}
			
			//Checks to see if the next attack key is hit between specific frames, if so
			// change state to attack two
			if (key_attack2 == 1) && LifeformAnimationFramesHit(4, 6)
			{
				state = "attack two";
			}
		#endregion
		break;
	
	case "attack two":
		#region Attack Two State
		
			//Sets sprite and frame
			SpriteStateSet(sPlayerA2, 0);
		
			//Creates a hitbox object based on a specific frame hit within the animation
			if (AnimationFrameHit(2))
			{
				CreateHitbox(x, y, self, sPlayerA2HB, 8, 1, 5, image_xscale);
				audio_play_sound(mSwordFast,550,0)
			}
			
			//Checks to see if the next attack key is hit between specific frames, if so
			// change state to attack three
			if (key_attack3 == 1) && LifeformAnimationFramesHit(4, 8) {
				state = "attack three";
			}
		
		#endregion
		break;
	
	case "attack three":
		#region Attack Three State
		
			//Sets sprite and frame
			SpriteStateSet(sPlayerA3, 0);
		
			//Creates a hitbox object based on a specific frame hit within the animation
			if (AnimationFrameHit(3))
			{
				CreateHitbox(x, y, self, sPlayerA3HB, 15, 1, 8, image_xscale);
				audio_play_sound(mSwordHeavy,700,0)
			}
		
		#endregion
		break;
		
	case "hit":
		#region Hit State
		
		Knockback(sPlayerH, "move");
		
		#endregion
		break;
	
	default:
		show_debug_message("State " + state + " does not exsist");
		state = "move";
		break;
}
