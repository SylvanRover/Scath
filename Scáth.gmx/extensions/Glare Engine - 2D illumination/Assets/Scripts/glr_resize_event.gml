///glr_resize_event(DO NOT USE THIS FUNCTION, IS FOR FUTURE GM UPDATES)
//currently useless
if(!surface_exists(global.GLR_MAIN_SURFACE)){
    global.GLR_MAIN_SURFACE = surface_create(global.GLR_WIDTH*global.GLR_MAIN_QUALITY , global.GLR_HEIGHT*global.GLR_MAIN_QUALITY);
    if(!surface_exists(global.GLR_MAIN_SURFACE)){
        return 0;
    }
}

if(global.GLR_DIRECTIONAL_ENABLED && !surface_exists(global.GLR_DIRECTIONAL_SURFACE)){
    global.GLR_DIRECTIONAL_SURFACE = surface_create(global.GLR_WIDTH*global.GLR_MAIN_QUALITY , global.GLR_HEIGHT*global.GLR_MAIN_QUALITY);
    if(!surface_exists(global.GLR_DIRECTIONAL_SURFACE)){
        return 0;
    }
}


if(global.GLR_INTENSITY_ENABLED && !surface_exists(global.GLR_INTENSITY_SURFACE)){
    global.GLR_INTENSITY_SURFACE = surface_create(global.GLR_WIDTH*global.GLR_MAIN_QUALITY , global.GLR_HEIGHT*global.GLR_MAIN_QUALITY);
    if(!surface_exists(global.GLR_INTENSITY_SURFACE)){
        return 0;
    }
}



var light_list_size = ds_list_size(global.GLR_LIGHT_LIST);
for(var i = 0; i < light_list_size ; i++)
{    
    var l_id = ds_list_find_value(global.GLR_LIGHT_LIST, i);
    
    var l_sprite = l_id[| 8];
    var l_quality = l_id[| 10];
    var lw = sprite_get_width(l_sprite);
    var lh = sprite_get_height(l_sprite);
    if(!surface_exists(l_id[| 16])){
        l_id[| 16] = surface_create(lw, lh);
        if(!surface_exists(l_id[| 16])) return 0;
    }
    if(!surface_exists(l_id[| 17])){
        l_id[| 17] = surface_create(lw/2, lh/2);
        if(!surface_exists(l_id[| 17])) return 0;
    }
    if(!surface_exists(l_id[| 18])){
        l_id[| 18] = surface_create(lw/4, lh/4);
        if(!surface_exists(l_id[| 18])) return 0;
    }
  
    var l_lightmap = -1;
    
    var l_shadowsprite = l_id[| 20];
    if(l_shadowsprite != -1){
        if(!surface_exists(l_shadowsprite)){
            l_shadowsprite = surface_create(w, h);
            if(!surface_exists(l_shadowsprite))
                return 0;
        }
    }
    
}

return 1;