///glr_lightsimple_create(sprite, subimg, x, y, color, alpha, intensity)

var l = ds_list_create();

ds_list_add(l, true); //[0]active

//transform
ds_list_add(l, argument2);  //x
ds_list_add(l, argument3);  //y
ds_list_add(l, 0);  //rotation
ds_list_add(l, 1);  //xscale
ds_list_add(l, 1);  //yscale

//light info
ds_list_add(l, argument4);  //[6]color
ds_list_add(l, argument5);  //alpha
ds_list_add(l, max(0, argument6));  //intensity
ds_list_add(l, argument0);  //sprite
ds_list_add(l, argument1);  //sprite index 

var width = sprite_get_width(argument0);
var height = sprite_get_height(argument0);
var xo =  sprite_get_xoffset(argument0);
var yo =  sprite_get_yoffset(argument0);

ds_list_add(l, max( point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), 
                     point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)) ); //bounding circle

ds_list_add(global.GLR_LIGHT_LIST_SIMPLE, l);

return l;