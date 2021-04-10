//Gets the players input
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
	
			if (vsp == 0) 
			{
				if (key_attack == 1) 
				{
					if (image_xscale == 1) {
					
						if (!place_meeting(x + 10, y, oWall)) {
							state = "attack one";
							image_index = 0;
						}
					}
					if (image_xscale == -1) {
					
						if (!place_meeting(x - 10, y, oWall)) {
							state = "attack one";
							image_index = 0;
						}
					}
				}
				if (key_roll == 1) {
					image_index = 0;
					state = "roll";
				}
			}
			
		
		#endregion
		break;
		
	case "roll":
		#region Roll State
		
			SpriteStateSet(sPlayerRO, 0);
	
			if (!place_meeting(x + 1, y, oWall) || !place_meeting(x - 1, y, oWall)) 
			{				
				
				image_speed = 1.5;
				if (image_xscale == -1) x -= 6;
				if (image_xscale == 1) x += 6;
				
				if (!place_meeting(x,y + 50,oWall)) 
				{
					state = "move";
				}
			
				if (AnimationFrameHit(8)) state = "move";
				
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
	
			SpriteStateSet(sPlayerA, 0);
			
			if (AnimationFrameHit(2))
			{
				CreateHitbox(x, y, self, sPlayerAHB, 24, 1, 5, image_xscale);
				audio_play_sound(mSwordFast,500,0)
			}
			
			if (key_attack2 == 1) && LifeformAnimationFramesHit(4, 6)
			{
				state = "attack two";
			}
		#endregion
		break;
	
	case "attack two":
		#region Attack Two State
		
			SpriteStateSet(sPlayerA2, 0);
		
			if (AnimationFrameHit(2))
			{
				CreateHitbox(x, y, self, sPlayerA2HB, 24, 1, 5, image_xscale);
				audio_play_sound(mSwordFast,550,0)
			}
		
			if (key_attack3 == 1) && LifeformAnimationFramesHit(4, 8) {
				state = "attack three";
			}
		
		#endregion
		break;
	
	case "attack three":
		#region Attack Three State
		
			SpriteStateSet(sPlayerA3, 0);
		
			if (AnimationFrameHit(3))
			{
				CreateHitbox(x, y, self, sPlayerA3HB, 40, 1, 8, image_xscale);
				audio_play_sound(mSwordHeavy,700,0)
			}
		
		#endregion
		break;
		
	case "hit":
		#region Hit State
		
			SpriteStateSet(sPlayerH, 0);
			
			EnemyMoveAndCollide(knockback_speed , 0);
			knockback_speed = Approach(knockback_speed, 0, 0.5);
			
			if (knockback_speed == 0) 
			{
				if (AnimationFrameHit(2)) {
					knockback_speed = 0;
					state = "move";
				}
			}
		
		#endregion
		break;
	
	default:
		show_debug_message("State " + state + " does not exsist");
		state = "move";
		break;
}
