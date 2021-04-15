function Approach(current_value, target_value, change_amount){
	if (current_value < target_value)
	{
		current_value += change_amount;
		current_value = min(current_value, target_value);
		
	} else {
		current_value -= change_amount;
		current_value = max(current_value, target_value);
	}
	
	return current_value;
}