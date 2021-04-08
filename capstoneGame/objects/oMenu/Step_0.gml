/// @description Menu
menu_move = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up); //returns 1 if down -1 if up

menu_index += menu_move;
if (menu_index < 0) menu_index = buttons - 1;
if (menu_index > buttons - 1) menu_index = 0;

if(menu_index != last_selected) audio_play_sound(mMenuMove, 1, 0);

last_selected = menu_index;


