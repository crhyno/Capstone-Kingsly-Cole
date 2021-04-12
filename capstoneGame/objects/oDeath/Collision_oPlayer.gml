with (oPlayer)
{
	if (hasControl)
	{
		hasControl = 0;
		SlideTransition("goTo", other.targetLevel);
	}
}
audio_stop_all();
