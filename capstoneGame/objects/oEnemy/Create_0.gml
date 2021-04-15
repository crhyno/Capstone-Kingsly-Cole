event_inherited();

//Sprites for the enemy
idleSprite = sEmpty;
chaseSprite = sEmpty;
attackSprite = sEmpty;
attackHitBoxSprite = sEmpty;
hitSprite = sEmpty;
deadSprite = sEmpty;

//Variables for specific enemy values
attackFrameHit = 0;
hitFrame = 0;
hp = 25;
damage = 5;
knockbackDistance = 40;

//General enemy variables
hsp = 0;
vsp = 0;
grv = 0.5;
walksp = 3;
dir = -1;

//Distance to player, set chase and attack ranges (different for specific enemies)
distance_to_player = 0;
chase_range = 300;
attack_range = 120;

//Ledge checking variables 
afraidOfHeights = 1;
atLedge = 0;
facingLedge = 0;

//Default state
state = "idle";

