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
	
			//Jumping
			if (place_meeting(x, y+1, oWall)) && (key_jump)
			{
				vsp = -10;
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
	
			if (!place_meeting(x + 1, y, oWall) || !place_meeting(x - 1, y, oWall)) 
			{				
				SpriteStateSet(sPlayerRO, 0);
				
				if (image_xscale == -1) x -= 5;
				if (image_xscale == 1) x += 5;
				
				if (!place_meeting(x,y + 50,oWall)) 
				{
					state = "move";
				}
				
			} else {
				state = "move";
				x -= 2;
				hsp = 0;
			}
		#endregion
	break;
	case "attack one":
		#region Attack One State	
	
		SpriteStateSet(sPlayerA, 0);
			
		if (AnimationFrameHit(2))
		{
			CreateHitbox(x, y, self, sPlayerAHB, 4, 4, 5, image_xscale);
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
			CreateHitbox(x, y, self, sPlayerA2HB, 4, 4, 5, image_xscale);
		}
		
		if (key_attack3 == 1) && LifeformAnimationFramesHit(4, 8) {
			state = "attack three";
		}
		
		#endregion
	break;
	case "attack three":
		#region Attack Three State
		
		if (AnimationFrameHit(3))
		{
			CreateHitbox(x, y, self, sPlayerA3HB, 4, 4, 8, image_xscale);
		}
		
		SpriteStateSet(sPlayerA3, 0);
		#endregion
	break;	
		
}
