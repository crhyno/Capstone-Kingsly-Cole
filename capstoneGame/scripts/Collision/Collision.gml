//Script thats used from player collision to check for walls while jumping and falling
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