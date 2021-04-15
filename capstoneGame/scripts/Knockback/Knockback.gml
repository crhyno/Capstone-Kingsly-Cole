
function Knockback(selectedHitSprite, nextState){
	
	//Sets sprite and frame
	SpriteStateSet(selectedHitSprite, 0);
			
	//Checks for collisions using the script below
	MoveAndCollide(knockback_speed , 0);
	//Sets knockback based the value returned through the Approach script
	knockback_speed = Approach(knockback_speed, 0, 0.5);
			
	//If the lifeform is no longer being knocked back, change state back to move based
	// on specific animation frame
	if (knockback_speed == 0) 
	{
		if (AnimationFrameHit(hitFrame)) {
			knockback_speed = 0;
			state = nextState;
		}
	}
}