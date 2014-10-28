///glr_set_occlusion_quality(quality)

global.GLR_OCCLUSION_QUALITY = clamp(argument0, 0.05,1);

if(surface_exists(global.GLR_OCCLUSION_SURFACE)){
    surface_free(global.GLR_OCCLUSION_SURFACE);
    surface_free(global.GLR_DEPTH_SURFACE);
    global.GLR_OCCLUSION_WIDTH = global.GLR_WIDTH*global.GLR_OCCLUSION_QUALITY;
    global.GLR_OCCLUSION_HEIGHT = global.GLR_HEIGHT*global.GLR_OCCLUSION_QUALITY;
    global.GLR_OCCLUSION_SURFACE = surface_create(global.GLR_OCCLUSION_WIDTH , global.GLR_OCCLUSION_HEIGHT);
    global.GLR_DEPTH_SURFACE = surface_create(global.GLR_OCCLUSION_WIDTH , global.GLR_OCCLUSION_HEIGHT);
}
 