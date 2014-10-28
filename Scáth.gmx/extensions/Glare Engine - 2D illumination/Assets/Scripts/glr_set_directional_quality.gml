///glr_set_directional_quality(quality)

global.GLR_DIRECTIONAL_QUALITY = clamp(argument0, 0.05,1);

if(surface_exists(global.GLR_DIRECTIONAL_SURFACE)){
    surface_free(global.GLR_DIRECTIONAL_SURFACE)
    global.GLR_DIRECTIONAL_WIDTH = global.GLR_WIDTH*global.GLR_DIRECTIONAL_QUALITY;
    global.GLR_DIRECTIONAL_HEIGHT = global.GLR_HEIGHT*global.GLR_DIRECTIONAL_QUALITY;
    global.GLR_DIRECTIONAL_SURFACE = surface_create(global.GLR_DIRECTIONAL_WIDTH , global.GLR_DIRECTIONAL_HEIGHT);
}