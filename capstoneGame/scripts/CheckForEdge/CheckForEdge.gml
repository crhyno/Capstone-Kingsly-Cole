//Script that if at a ledge, sets atLedge to true, state back to idle, if not sets at ledge
// to false and continues to chase the player
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