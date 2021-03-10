//Gets the players input
if (hasControl) 
{
	key_left = keyboard_check(ord("A"));
	key_right = keyboard_check(ord("D"));
	key_jump = keyboard_check_pressed(ord("W"));
	key_attack = keyboard_check_pressed(ord("Q"));
	key_attack2 = keyboard_check_pressed(ord("Q"));
} 
else 
{
	key_left = 0;
	key_right = 0;
	key_jump = 0;
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
		}
		
	#endregion
	break;
	case "attack one":
	#region Attack One State
	
		sprite_index = sPlayerA;
		
		if (AnimationFrameHit(0))
		{
			CreateHitbox(x, y, self, sPlayerAHB, 4, 5, 1, image_xscale);
		}
			
		if (key_attack2 == 1) && PlayerAnimationFrameHit(4, 6)
		{
			if (image_xscale == 1) {
				
				if (!place_meeting(x + 100, y, oWall)) {
					state = "attack two";
				}
			}
			if (image_xscale == -1) {
				
				if (!place_meeting(x - 100, y, oWall)) {
					state = "attack two";
				}
			}
		}
	#endregion
	break;
	case "attack two":
	
		#region Attack Two State
		SpriteStateSet(sPlayerA2, 0);
		
		if (AnimationFrameHit(0))
		{
			CreateHitbox(x, y, self, sPlayerA2HB, 4, 1, image_xscale);
		}
		
	#endregion
	break;
		
}
