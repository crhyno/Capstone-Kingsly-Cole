// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EnemyMoveAndCollide(xspeed, yspeed){
	if (!place_meeting(x+xspeed, y, oWall)) {
		x += xspeed;
	}
	
	if (!place_meeting(x, y+yspeed, oWall)) {
		y += yspeed;
	}
}