///glr_lightsimple_destroy(lightsimple id)
ds_list_delete(global.GLR_LIGHT_LIST_SIMPLE, ds_list_find_index(global.GLR_LIGHT_LIST_SIMPLE,argument0));
ds_list_destroy(argument0); 
 