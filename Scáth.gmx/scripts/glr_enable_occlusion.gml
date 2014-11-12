///glr_enable_occlusion(enable)
if(argument0 && !global.GLR_OCCLUSION_ENABLED && !surface_exists(global.GLR_OCCLUSION_SURFACE)){
    global.GLR_OCCLUSION_WIDTH = global.GLR_WIDTH*global.GLR_OCCLUSION_QUALITY;
    global.GLR_OCCLUSION_HEIGHT = global.GLR_HEIGHT*global.GLR_OCCLUSION_QUALITY;
    global.GLR_OCCLUSION_SURFACE = surface_create(global.GLR_OCCLUSION_WIDTH , global.GLR_OCCLUSION_HEIGHT);
    global.GLR_DEPTH_SURFACE = surface_create(global.GLR_OCCLUSION_WIDTH , global.GLR_OCCLUSION_HEIGHT);
}


global.GLR_OCCLUSION_ENABLED = argument0;
 