///glr_shadowsprite_create_from_instance(static)
var l = ds_list_create();
l[| 0] = sprite_index;
l[| 1] = image_index;
l[| 2] = x;
l[| 3] = y;
l[| 4] = image_xscale;
l[| 5] = image_yscale;
l[| 6] = image_angle; 
var width = sprite_get_width(sprite_index);
var height = sprite_get_height(sprite_index);
var xo =  sprite_get_xoffset(sprite_index);
var yo =  sprite_get_yoffset(sprite_index);
ds_list_add(l, max( point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), 
                     point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)) ); //bounding circle

ds_list_add(l, 0);//layer4
ds_list_add(l, argument0);//static [9]
if(argument0)
    ds_list_add(global.GLR_SPR_STC_LIST, l);
else
    ds_list_add(global.GLR_SPR_DYN_LIST, l);
     
return l;