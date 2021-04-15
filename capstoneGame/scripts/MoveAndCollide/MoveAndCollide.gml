//Collision checking for enemy movement or when lifeform is in hit state
function MoveAndCollide(xspeed, yspeed){
	if (!place_meeting(x+xspeed, y, oWall)) {		
		x += xspeed;
	}
	
	if (!place_meeting(x, y+yspeed, oWall)) {
		y += yspeed;
	}
}