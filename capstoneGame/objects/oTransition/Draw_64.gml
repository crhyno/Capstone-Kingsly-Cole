if (transMode != "off")
{
	draw_set_color(c_black);
	draw_rectangle(0, 0, w, percent * hHalf, false);
	
	draw_rectangle(0, h, w, h - (percent * hHalf), false);
}