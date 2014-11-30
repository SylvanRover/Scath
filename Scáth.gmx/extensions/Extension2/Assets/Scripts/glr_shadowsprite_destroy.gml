///glr_shadowsprite_destroy(id)
ds_list_delete(global.GLR_SPR_DYN_LIST, ds_list_find_index(global.GLR_SPR_DYN_LIST,argument0));
ds_list_destroy(argument0);