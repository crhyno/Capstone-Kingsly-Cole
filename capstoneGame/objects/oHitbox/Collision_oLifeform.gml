//Ckecks to see if the hitbox hit any lifeform or if its already in the ds_list
if (creator == noone || creator == other || ds_list_find_index(hit_objects, other) != -1) exit;

//Deals damage to the lifeform hit based on the damage of the attack, and adds the lifeform to
// the ds_list
other.hp -= damage;
audio_play_sound(mHit,500,0);
ds_list_add(hit_objects, other);

//Sets the state to hit and the knockback based on the direction of the hit lifeform and 
// the knockback value within the creation of the hitbox
other.state = "hit";
other.knockback_speed = knockback * image_xscale;
