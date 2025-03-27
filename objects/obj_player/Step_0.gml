// current bugs:
// placing trees while camera is anywhere other than its original position does not work
// placement preview that follows mouse not working
// currently the camera is set to see the entire map, but we may want it to be zoomed in and follow player, which we can do easily by changing how big the camera is but placement doesn't work
// we also need to put all this placement on a grid system so each tile snaps to the grid

right_key = keyboard_check(ord("D"));
left_key = keyboard_check(ord("A"));
up_key = keyboard_check(ord("W"));
down_key = keyboard_check(ord("S"));

xspeed = (right_key - left_key) * move_speed;
yspeed = (down_key - up_key) * move_speed;

//Collisions
if place_meeting(x + xspeed, y, obj_wall)
{
	xspeed = 0;
}

if place_meeting(x, y + yspeed, obj_wall)
{
	yspeed = 0;
}

x += xspeed;
y += yspeed;

if (!variable_global_exists("placing_tree"))
{
	global.placing_tree = false;
}

if (!variable_global_exists("placing_road"))
{
	global.placing_road = false;
}

if (!variable_global_exists("placing_house"))
{
	global.placing_house = false;
}

if (global.placing_tree)
{
	draw_sprite_ext(spr_tree, 0, camera_get_view_x(view_camera[0]) + mouse_x, camera_get_view_y(view_camera[0]) + mouse_y, 1, 1, 0, c_white, 0.5);
	
	if (mouse_check_button_pressed(mb_left))
	{
		instance_create_layer(mouse_x + camera_get_view_x(view_camera[0]), mouse_y + camera_get_view_y(view_camera[0]), "Instances", obj_tree);
		global.placing_tree = false;
	}
}

if (global.placing_road)
{
	draw_sprite_ext(spr_road, 0, camera_get_view_x(view_camera[0]) + mouse_x, camera_get_view_y(view_camera[0]) + mouse_y, 1, 1, 0, c_white, 0.5);
	
	if (mouse_check_button_pressed(mb_left))
	{
		instance_create_layer(mouse_x + camera_get_view_x(view_camera[0]), mouse_y + camera_get_view_y(view_camera[0]), "Instances", obj_road);
		global.placing_road = false;
	}
}

if (global.placing_house)
{
	draw_sprite_ext(spr_house, 0, camera_get_view_x(view_camera[0]) + mouse_x, camera_get_view_y(view_camera[0]) + mouse_y, 1, 1, 0, c_white, 0.5);
	
	if (mouse_check_button_pressed(mb_left))
	{
		instance_create_layer(mouse_x + camera_get_view_x(view_camera[0]), mouse_y + camera_get_view_y(view_camera[0]), "Instances", obj_house);
		global.placing_house = false;
	}
}