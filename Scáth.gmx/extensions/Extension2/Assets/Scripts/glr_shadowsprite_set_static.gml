///glr_shadowsprite_set_static(shadowsprite, static)
var is_static = argument0[| 9];

if(is_static){
    ds_list_delete(global.GLR_SPR_STC_LIST, ds_list_find_index(global.GLR_SPR_STC_LIST, argument0));
}
else{
    ds_list_delete(global.GLR_SPR_DYN_LIST, ds_list_find_index(global.GLR_SPR_DYN_LIST, argument0));
}

if(argument1)
    ds_list_add(global.GLR_SPR_STC_LIST, argument0);
else
    ds_list_add(global.GLR_SPR_DYN_LIST, argument0);
    
argument0[| 9] = argument1;