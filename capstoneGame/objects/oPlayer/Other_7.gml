if (state == "attack one" || state == "attack two") {
	if (state == "attack two") {
		
		if (image_xscale < 1) x-= 100;
		else x += 100;
	}
	state = "move";
	image_index = 0;
}
