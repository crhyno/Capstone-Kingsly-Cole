/// @description Insert description here



switch(menu_index){

	case 0:
		audio_stop_sound(mMainMenu);
		audio_play_sound(mSelect,1,0);
		room_goto_next();	
		break;
	case 1:
		game_end();
		break;
}
