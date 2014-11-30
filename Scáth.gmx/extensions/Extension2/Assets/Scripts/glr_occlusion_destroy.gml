///glr_occlusion_destroy(id);
var l_id = argument0;
ds_list_delete(global.GLR_OCCLUSION_LIST, ds_list_find_index(global.GLR_OCCLUSION_LIST,argument0));
ds_list_destroy(argument0); 
 