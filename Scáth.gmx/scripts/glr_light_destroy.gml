///glr_light_destroy(light id);

var l_id = argument0;
var s1 = l_id[| 16];
if(surface_exists(s1)) surface_free(s1);
var s2 = l_id[| 17];
if(surface_exists(s2)) surface_free(s2);
var s3 = l_id[| 18];
if(surface_exists(s3)) surface_free(s3);
var s4 = l_id[| 19];
if(surface_exists(s4)) surface_free(s4); 

ds_list_destroy(l_id[| 20])//ignorelist; 
ds_list_delete(global.GLR_LIGHT_LIST, ds_list_find_index(global.GLR_LIGHT_LIST,argument0));
ds_list_destroy(argument0); 
 