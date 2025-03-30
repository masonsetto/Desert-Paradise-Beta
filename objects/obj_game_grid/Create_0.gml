global.grid_size = 32;

global.grid_width = ceil(room_width div global.grid_size);
global.grid_height = ceil(room_height div global.grid_size);

global.grid = array_create(global.grid_width);
for (var i = 0; i < global.grid_width; i++)
{
	global.grid[i] = array_create(global.grid_height, 0);
}
