///glr_shadowdir_create(sprite, sprite shadow, subimage, x, y, z, xscale, yscale, dir)
var l = ds_list_create();
ds_list_add(l, "Shadowdir");
ds_list_add(l, argument0);//sprite
ds_list_add(l, argument1);//sprite shadow
ds_list_add(l, argument2);//subimage
ds_list_add(l, argument3);//x
ds_list_add(l, argument4);//y
ds_list_add(l, argument5);//z
ds_list_add(l, argument6);//xs
ds_list_add(l, argument7);//ys
ds_list_add(l, argument8);//rot
var width = sprite_get_width(argument0);
var height = sprite_get_height(argument0);
var xo =  sprite_get_xoffset(argument0);
var yo =  sprite_get_yoffset(argument0);
ds_list_add(l, max( point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), 
                     point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)) ); //bounding circle

ds_list_add(global.GLR_SHADOWDIR_LIST, l);
return l;