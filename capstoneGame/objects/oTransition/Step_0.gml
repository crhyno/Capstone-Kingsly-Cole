var transTime = 1.5;

if (transMode != "off")
{
	if (transMode == "intro")
	{
		percent = max(0, percent - max((percent / 10), 0.005)); 
	}
	else {
		percent = min(transTime, percent + max(((transTime - percent) / 10), 0.005));
	}
	
	if (percent == transTime || percent == 0)
	{
		switch (transMode)
		{
			case "intro":
				transMode = "off";
			break;
			
			case "next":
				transMode = "intro";
				room_goto_next();
			break;
			
			case "goTo":
				transMode = "intro";
				room_goto(target);
			break;
			
			case "restart":
				game_restart();
			break;
			
		}
	}
}