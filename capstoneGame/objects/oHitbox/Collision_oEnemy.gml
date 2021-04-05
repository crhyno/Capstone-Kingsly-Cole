if (creator == noone || creator == other) exit;

other.hp -= damage;
audio_play_sound(mHit,500,0);
