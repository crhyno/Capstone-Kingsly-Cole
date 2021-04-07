/// @description Insert description here
// pause menu
if(keyboard_check_pressed(vk_enter)) {
	if(!pause) {
		pause = true;
		instance_deactivate_all(true);
		audio_pause_all();
	} else {
		pause = false;
		instance_activate_all();
		audio_resume_all();
	}
}
