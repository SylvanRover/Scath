///glr_occlusion_add(sprite, sub, x, y, xscale, yscale, rot);
var l = ds_list_create();
l[| 0] = argument0;
l[| 1] = argument1;
l[| 2] = argument2;
l[| 3] = argument3;
l[| 4] = argument4;
l[| 5] = argument5;
l[| 6] = argument6;
//bounding circle

var width = sprite_get_width(argument0);
var height = sprite_get_height(argument0);
var xo =  sprite_get_xoffset(argument0);
var yo =  sprite_get_yoffset(argument0);
l[| 7] = max( point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)); //bounding circle

ds_list_add(global.GLR_OCCLUSION_LIST, l);

return l;