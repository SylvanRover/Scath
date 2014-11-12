///glr_light_create(sprite, subimg, x,y,color, intensity)

var l = ds_list_create();

l[| 0] = true; //active

//transform
l[| 1] = argument2;  //x
l[| 2] = argument3;  //y
l[| 3] = 0;  //rotation
l[| 4] = 1;  //xscale
l[| 5] = 1;  //yscale

var intensity = max(0, argument5);
//light info
l[| 6] = argument4;  //color
l[| 7] = intensity;  //intensity
l[| 8] = argument0;  //sprite
l[| 9] = argument1;  //sprite index 

l[| 10] = 1;
l[| 11] = 0; //layer
l[| 12] = 1; //update ratio (not implemented, maybe in future)
l[| 13] = 0; //timer
l[| 14] = false; //static

var width = sprite_get_width(argument0);
var height = sprite_get_height(argument0);
var xo =  sprite_get_xoffset(argument0);
var yo =  sprite_get_yoffset(argument0);

l[| 15] = max( point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)); //bounding circle

//surfaces
l[| 16] = surface_create(width, height);//light surface
l[| 17] = -1;  //shadowmap |ex 19
l[| 18] = surface_create(width, height);  //shadowsprite |ex 20
l[| 19] = surface_create(width, height);  //shadowsprite2 |ex 26


l[| 20] = ds_list_create(); //ignore list 
l[| 21] = false;  //is clear
l[| 22] = 1;  //shadow strength
l[| 23] = 30;  //tolerance 
 
 

ds_list_add(global.GLR_LIGHT_LIST, l);



return l;