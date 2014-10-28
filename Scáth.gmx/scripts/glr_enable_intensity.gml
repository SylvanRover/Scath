///glr_enable_intensity(enable)

if(argument0 && !global.GLR_INTENSITY_ENABLED && !surface_exists(global.GLR_INTENSITY_SURFACE)){
    global.GLR_INTENSITY_WIDTH = global.GLR_WIDTH*global.GLR_INTENSITY_QUALITY;
    global.GLR_INTENSITY_HEIGHT = global.GLR_HEIGHT*global.GLR_INTENSITY_QUALITY;
    global.GLR_INTENSITY_SURFACE = surface_create(global.GLR_INTENSITY_WIDTH , global.GLR_INTENSITY_HEIGHT);
}


global.GLR_INTENSITY_ENABLED = argument0;