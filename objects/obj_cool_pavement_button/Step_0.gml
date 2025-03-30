hovering = position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id);

if (hovering && mouse_check_button_pressed(mb_left))
{
	clicked = true;
}

if (mouse_check_button_released(mb_left))
{
	clicked = false;
}

var mouse_x_pos = device_mouse_x_to_gui(0);
var mouse_y_pos = device_mouse_y_to_gui(0);

// all of this makes it so that the button "flashes" when clicked
if (clicked)
{
	image_index = 2;
	global.placing_cool_pavement = true;
}
else if (hovering)
{
	image_index = 1;
}
else
{
	image_index = 0;
}