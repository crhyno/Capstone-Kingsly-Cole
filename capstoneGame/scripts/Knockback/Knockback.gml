// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Knockback(selectedHitSprite, nextState){
	
	SpriteStateSet(selectedHitSprite, 0);
			
	EnemyMoveAndCollide(knockback_speed , 0);
	knockback_speed = Approach(knockback_speed, 0, 0.5);
			
	if (knockback_speed == 0) 
	{
		if (AnimationFrameHit(hitFrame)) {
			knockback_speed = 0;
			state = nextState;
		}
	}
}