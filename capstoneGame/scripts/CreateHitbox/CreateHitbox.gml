// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateHitbox(xPos, yPos, creator, sprite, knockback, lifespan, damage, xscale){
	
	var hitBox = instance_create_layer(xPos, yPos, "Entities", oHitbox);
	hitBox.sprite_index = sprite;
	hitBox.creator = creator;
	hitBox.knockback = knockback;
	hitBox.alarm[0] = lifespan;
	hitBox.damage = damage;
	hitBox.image_xscale = xscale;
}