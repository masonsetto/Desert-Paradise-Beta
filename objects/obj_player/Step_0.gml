// current bugs:
// placing trees while camera is anywhere other than its original position does not work
// currently the camera is set to see the entire map, but we may want it to be zoomed in and follow player, which we can do easily by changing how big the camera is but placement doesn't work
// we also need to put all this placement on a grid system so each tile snaps to the grid

// ideas:
// have a road system already laid out on the map for the player to build around- this way the thrid object being built is turning existing roads into cool pavement instead of building another road
// two ways to cool down city because default roads generate heat: cool pavement or planting trees near road

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

if (!variable_global_exists("placing_cool_pavement"))
{
	global.placing_cool_pavement = false;
}

if (!variable_global_exists("placing_house"))
{
	global.placing_house = false;
}

var world_mouse_x = mouse_x + camera_get_view_x(view_camera[0]);
var world_mouse_y = mouse_y + camera_get_view_y(view_camera[0]);

var grid_x = world_mouse_x div global.grid_size;
var grid_y = world_mouse_y div global.grid_size;

global.snapped_x = grid_x * global.grid_size;
global.snapped_y = grid_y * global.grid_size;

if (global.placing_tree)
{
	if (mouse_check_button_pressed(mb_left))
	{
		var placement_x = grid_x * global.grid_size;
		var placement_y = grid_y * global.grid_size;
		
		var house_width = sprite_get_width(spr_tree);
		var house_height = sprite_get_height(spr_tree);
		
		var collision_present = collision_rectangle(placement_x, placement_y, placement_x + sprite_get_width(spr_tree), placement_y + sprite_get_width(spr_tree), obj_tree, false, false) ||
								collision_rectangle(placement_x, placement_y, placement_x + sprite_get_width(spr_tree), placement_y + sprite_get_width(spr_tree), obj_house, false, false) ||
								collision_rectangle(placement_x, placement_y, placement_x + sprite_get_width(spr_tree), placement_y + sprite_get_width(spr_tree), obj_road, false, false);
		
		if (!collision_present && global.grid[grid_x, grid_y] == 0)
		{
			instance_create_layer(grid_x * global.grid_size, grid_y * global.grid_size, "Instances", obj_tree);
			global.grid[grid_x, grid_y] = 1;
			global.placing_tree = false;
		}
	}
}

if (global.placing_cool_pavement)
{
	if (mouse_check_button_pressed(mb_left))
	{
		var placement_x = grid_x * global.grid_size;
		var placement_y = grid_y * global.grid_size;
		
		var cool_pavement_width = sprite_get_width(spr_cool_pavement);
		var cool_pavement_height = sprite_get_height(spr_cool_pavement);
		
		var road_collision_present = collision_rectangle(placement_x, placement_y, placement_x + sprite_get_width(spr_cool_pavement), placement_y + sprite_get_width(spr_cool_pavement), obj_road, false, false);
		var cool_pavement_collision_present = collision_rectangle(placement_x, placement_y, placement_x + sprite_get_width(spr_cool_pavement), placement_y + sprite_get_width(spr_cool_pavement), obj_cool_pavement, false, false);
		
		if (road_collision_present && !cool_pavement_collision_present)
		{
			instance_create_layer(grid_x * global.grid_size, grid_y * global.grid_size, "Instances", obj_cool_pavement);
			global.grid[grid_x, grid_y] = 1;
			global.placing_cool_pavement = false;
		}
	}
}

if (global.placing_house)
{
	if (mouse_check_button_pressed(mb_left))
	{
		var placement_x = grid_x * global.grid_size;
		var placement_y = grid_y * global.grid_size;
		
		var house_width = sprite_get_width(spr_house);
		var house_height = sprite_get_height(spr_house);
		
		var collision_present = collision_rectangle(placement_x, placement_y, placement_x + sprite_get_width(spr_house), placement_y + sprite_get_width(spr_house), obj_tree, false, false) ||
								collision_rectangle(placement_x, placement_y, placement_x + sprite_get_width(spr_house), placement_y + sprite_get_width(spr_house), obj_house, false, false) ||
								collision_rectangle(placement_x, placement_y, placement_x + sprite_get_width(spr_house), placement_y + sprite_get_width(spr_house), obj_road, false, false);
		
		if (!collision_present && global.grid[grid_x, grid_y] == 0)
		{
			instance_create_layer(grid_x * global.grid_size, grid_y * global.grid_size, "Instances", obj_house);
			global.grid[grid_x, grid_y] = 1;
			global.placing_house = false;
		}
	}
}