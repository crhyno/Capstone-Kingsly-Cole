// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CheckForEdge(xspeed, yspeed){
	
	if (afraidOfHeights) && (!place_meeting(xspeed, yspeed, oWall))
	{
		if (image_xscale == -1) {
			x += 20;
		}
		if (image_xscale == 1) {
			x -= 20;
		}
		facingLedge = image_xscale;
		hsp = 0;
		state = "idle";
		atLedge = 1;
	}
	else atLedge = 0;
}