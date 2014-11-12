///glr_shadowsprite_create(sprite, subimage, x, y, xscale, yscale, rot, static)
var l = ds_list_create();
ds_list_add(l, argument0);
ds_list_add(l, argument1);
ds_list_add(l, argument2);
ds_list_add(l, argument3);
ds_list_add(l, argument4);
ds_list_add(l, argument5);
ds_list_add(l, argument6);
var width = sprite_get_width(argument0);
var height = sprite_get_height(argument0);
var xo =  sprite_get_xoffset(argument0);
var yo =  sprite_get_yoffset(argument0);
ds_list_add(l, max( point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), 
                     point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)) ); //bounding circle

ds_list_add(l, 0);//layer
ds_list_add(l, argument7);//static [9]
if(argument7)
    ds_list_add(global.GLR_SPR_STC_LIST, l);
else
    ds_list_add(global.GLR_SPR_DYN_LIST, l);
    
return l;