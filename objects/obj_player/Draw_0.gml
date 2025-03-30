draw_self();

if (global.placing_tree)
{
	draw_sprite_ext(spr_tree, 0, global.snapped_x, global.snapped_y, 1, 1, 0, c_white, 0.5);
}

if (global.placing_cool_pavement)
{
	draw_sprite_ext(spr_cool_pavement, 0, global.snapped_x, global.snapped_y, 1, 1, 0, c_white, 0.5);
}

if (global.placing_house)
{
	draw_sprite_ext(spr_house, 0, global.snapped_x, global.snapped_y, 1, 1, 0, c_white, 0.5);
}

