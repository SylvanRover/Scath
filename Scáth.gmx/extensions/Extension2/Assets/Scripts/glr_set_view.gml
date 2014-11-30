///glr_set_view(view number)
if(view_enabled){
    var s_width=view_wview[argument0];
    var s_height=view_hview[argument0]; 
}
else{
    var s_width = room_width;
    var s_height = room_height; 
}
 

if(surface_exists(global.GLR_MAIN_SURFACE)) surface_free(global.GLR_MAIN_SURFACE);


global.GLR_WIDTH = s_width;
global.GLR_HEIGHT = s_height;


global.GLR_MAIN_SURFACE_WIDTH = s_width*global.GLR_MAIN_QUALITY;
global.GLR_MAIN_SURFACE_HEIGHT = s_height*global.GLR_MAIN_QUALITY;
global.GLR_MAIN_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH , global.GLR_MAIN_SURFACE_HEIGHT); 


buffer_delete(global.GLR_ILLUM_BUFFER);
global.GLR_ILLUM_BUFFER = buffer_create(global.GLR_MAIN_SURFACE_WIDTH*global.GLR_MAIN_SURFACE_HEIGHT*4, buffer_fixed, 4); 


if(surface_exists(global.GLR_DIRECTIONAL_SURFACE)){
    surface_free(global.GLR_DIRECTIONAL_SURFACE)
    global.GLR_DIRECTIONAL_WIDTH = s_width*global.GLR_DIRECTIONAL_QUALITY;
    global.GLR_DIRECTIONAL_HEIGHT = s_height*global.GLR_DIRECTIONAL_QUALITY;
    global.GLR_DIRECTIONAL_SURFACE = surface_create(global.GLR_DIRECTIONAL_WIDTH , global.GLR_DIRECTIONAL_HEIGHT);
}

if(surface_exists(global.GLR_INTENSITY_SURFACE)){
    surface_free(global.GLR_INTENSITY_SURFACE);
    global.GLR_INTENSITY_WIDTH = s_width*global.GLR_INTENSITY_QUALITY;
    global.GLR_INTENSITY_HEIGHT = s_height*global.GLR_INTENSITY_QUALITY;
    global.GLR_INTENSITY_SURFACE = surface_create(global.GLR_INTENSITY_WIDTH, global.GLR_INTENSITY_HEIGHT);
}

if(surface_exists(global.GLR_OCCLUSION_SURFACE)){
    surface_free(global.GLR_OCCLUSION_SURFACE);
    surface_free(global.GLR_DEPTH_SURFACE);
    global.GLR_OCCLUSION_WIDTH = s_width*global.GLR_OCCLUSION_QUALITY;
    global.GLR_OCCLUSION_HEIGHT = s_height*global.GLR_OCCLUSION_QUALITY;
    global.GLR_OCCLUSION_SURFACE = surface_create(global.GLR_OCCLUSION_WIDTH, global.GLR_OCCLUSION_HEIGHT);
    global.GLR_DEPTH_SURFACE = surface_create(global.GLR_OCCLUSION_WIDTH, global.GLR_OCCLUSION_HEIGHT);
}