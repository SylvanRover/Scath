///glr_shadowdir_destroy(id);

ds_list_delete(global.GLR_SHADOWDIR_LIST, ds_list_find_index(global.GLR_SHADOWDIR_LIST, argument0));
ds_list_destroy(argument0);