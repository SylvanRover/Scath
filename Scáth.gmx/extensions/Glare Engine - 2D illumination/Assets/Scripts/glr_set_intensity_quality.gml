///glr_set_intensity_quality(quality)
if(argument0 ==  global.GLR_INTENSITY_QUALITY) return 0;
global.GLR_INTENSITY_QUALITY = clamp(argument0, 0.05,1);

if(surface_exists(global.GLR_INTENSITY_SURFACE)){
    surface_free(global.GLR_INTENSITY_SURFACE)
    global.GLR_INTENSITY_WIDTH = global.GLR_WIDTH * global.GLR_INTENSITY_QUALITY;
    global.GLR_INTENSITY_HEIGHT = global.GLR_HEIGHT * global.GLR_INTENSITY_QUALITY;
    global.GLR_INTENSITY_SURFACE = surface_create(global.GLR_INTENSITY_WIDTH , global.GLR_INTENSITY_HEIGHT);
}