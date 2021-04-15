//Creates a hitbox for a specific attack animation 
function CreateHitbox(xPos, yPos, creator, sprite, knockback, lifespan, damage, xscale){
	
	var hitbox = instance_create_layer(xPos, yPos, "Entities", oHitbox);
	hitbox.sprite_index = sprite;
	hitbox.creator = creator;
	hitbox.knockback = knockback;
	hitbox.alarm[0] = lifespan;
	hitbox.damage = damage;
	hitbox.image_xscale = xscale;
}