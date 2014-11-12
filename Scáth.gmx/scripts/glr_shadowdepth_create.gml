///glr_shadowdepth_create(sprite, subimage, x, y, z, xscale, yscale, rot)
/* DESCRIPTION
The shadowdepth is useful to simulate the layer of an object relative to a light.
For example, if you have a tree and a player with a torchlight, the light does not affect  the tree and pass through it. 
In this case, simply set a shadowdepth on your three with z greater then the light layer
*/
var l = ds_list_create();
ds_list_add(l, argument0);
ds_list_add(l, argument1);
ds_list_add(l, argument2);
ds_list_add(l, argument3);
ds_list_add(l, argument4);
ds_list_add(l, argument5);
ds_list_add(l, argument6);
ds_list_add(l, argument7);
var width = sprite_get_width(argument0);
var height = sprite_get_height(argument0);
var xo =  sprite_get_xoffset(argument0);
var yo =  sprite_get_yoffset(argument0);
ds_list_add(l, max( point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), 
                     point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)) ); //bounding circle


ds_list_add(global.GLR_DEP_DYN_LIST, l);
return l;