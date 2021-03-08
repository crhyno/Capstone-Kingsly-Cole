// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Collision(xspeed, yspeed){
	
	if (place_meeting(xspeed,y,oWall)) 
	{
		while (!place_meeting(x+sign(hsp), y, oWall)) 
		{
			x = x + sign(hsp);
		}
	}
	
	if (place_meeting(x,yspeed,oWall)) 
	{
		while (!place_meeting(x, y+sign(vsp), oWall)) 
		{
			y = y + sign(vsp);
		}
	}
}