///glr_init(quality, width, height, view)

/*************Description***************/
//initialize the engine
//quality: the main surface resolution
//width: main surface width
//height: main surface height
//view: number of the view that uses the engine


global.GLR_VIEW = 0;

if(argument_count < 3){
    if(view_enabled){
        var s_width=view_wview[global.GLR_VIEW];
        var s_height=view_hview[global.GLR_VIEW]; 
    }
    else{
        var s_width=room_width;
        var s_height=room_height; 
    }
}
else{
    var s_width = argument[1];
    var s_height = argument[2];
    global.GLR_VIEW = argument[3];
}

global.GLR_WIDTH = s_width;
global.GLR_HEIGHT = s_height;

var q = clamp(argument[0], 0.05,1);
global.GLR_MAIN_QUALITY = q;
global.GLR_INTENSITY_QUALITY = q;
global.GLR_DIRECTIONAL_QUALITY = q;
global.GLR_OCCLUSION_QUALITY = q;


global.GLR_MAIN_SURFACE_WIDTH = s_width*global.GLR_MAIN_QUALITY;
global.GLR_MAIN_SURFACE_HEIGHT = s_height*global.GLR_MAIN_QUALITY;
global.GLR_MAIN_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH , global.GLR_MAIN_SURFACE_HEIGHT); 

//ambient occlusion

global.GLR_DIRECTIONAL_ENABLED = false;
global.GLR_DIRECTIONAL_SURFACE = -1;
global.GLR_DIRECTIONAL_WIDTH = s_width*global.GLR_DIRECTIONAL_QUALITY;
global.GLR_DIRECTIONAL_HEIGHT = s_height*global.GLR_DIRECTIONAL_QUALITY;
//if(global.GLR_DIRECTIONAL_ENABLED){
    //global.GLR_DIRECTIONAL_SURFACE = surface_create(global.GLR_DIRECTIONAL_WIDTH , global.GLR_DIRECTIONAL_HEIGHT);
//}

global.GLR_INTENSITY_ENABLED = false;
global.GLR_INTENSITY_SURFACE = -1;
global.GLR_INTENSITY_WIDTH = s_width*global.GLR_INTENSITY_QUALITY;
global.GLR_INTENSITY_HEIGHT = s_height*global.GLR_INTENSITY_QUALITY;
//if(global.GLR_INTENSITY_ENABLED){
    //global.GLR_INTENSITY_SURFACE = surface_create(global.GLR_INTENSITY_WIDTH, global.GLR_INTENSITY_HEIGHT);
//}


global.GLR_OCCLUSION_ENABLED = false;
global.GLR_OCCLUSION_SURFACE = -1;
global.GLR_DEPTH_SURFACE = -1;
global.GLR_OCCLUSION_WIDTH = s_width*global.GLR_OCCLUSION_QUALITY;
global.GLR_OCCLUSION_HEIGHT = s_height*global.GLR_OCCLUSION_QUALITY;

global.GLR_INTENSITY_RENDER = false;


global.GLR_FXAA_ENABLED=false;
global.GLR_MESH_DYN_LIST = ds_list_create();
global.GLR_MESH_STC_LIST = ds_list_create();

global.GLR_AMBIENT_COLOR = $111111;

global.GLR_SPR_DYN_LIST = ds_list_create();
global.GLR_SPR_STC_LIST = ds_list_create();

global.GLR_DEP_DYN_LIST = ds_list_create();
global.GLR_SHADOWDIR_LIST = ds_list_create();


global.GLR_DIRECTIONAL_QUEUE = ds_priority_create();
global.GLR_DIRECTIONAL_STRENGTH = 0.5;
global.GLR_DIRECTIONAL_ANGLE = 320;
global.GLR_DIRECTIONAL_LENGTH = 0.2;


global.GLR_SIMPLELIGHT_LIST = ds_list_create();
global.GLR_LIGHT_LIST = ds_list_create();
global.GLR_LIGHT_LIST_SIMPLE = ds_list_create();
global.GLR_OCCLUSION_LIST = ds_list_create();
global.GLR_OCCLUSION_LIST_INST = ds_list_create();

global.GLR_ILLUM_BUFFER = buffer_create(global.GLR_MAIN_SURFACE_WIDTH*global.GLR_MAIN_SURFACE_HEIGHT*4, buffer_fixed, 4); 
//buffer_seek(global.GLR_ILLUM_BUFFER, buffer_seek_start, 0); 


//shaders
global.GLR_FXAA_SIZE = shader_get_uniform(glr_shader_fxaa,"frameBufSize");
global.GLR_DIRECTIONAL_AMBIENT = shader_get_uniform(glr_shader_ambient,"AmbientColor");
global.GLR_LIGHT_INTENSITY = shader_get_uniform(glr_shader_intensity,"LightIntensity");
global.GLR_LIGHT_OFFSET = shader_get_uniform(glr_shader_base,"LightOffset");
global.GLR_LIGHT_OFFSET_SPR = shader_get_uniform(glr_shader_shadow_sprite,"LightOffset"); 
global.GLR_LIGHT_SCALE_SPR = shader_get_uniform(glr_shader_shadow_sprite,"uScale");
global.GLR_LIGHT_STRENGTH = shader_get_uniform(glr_shader_base,"strength"); 
global.GLR_UNIFORM_DIRECTIONAL = shader_get_uniform(glr_shader_directional,"direction");

global.GLR_SHADOWSPRITE_ENABLED = shader_is_compiled(glr_shader_shadow_sprite);

vertex_format_begin();
vertex_format_add_position_3d();
global.GLR_VERTEX_FORMAT=vertex_format_end();


//Daytime

//midnight
global.GLR_M_R = 18;
global.GLR_M_G = 14;
global.GLR_M_B = 32;

//sunrise
global.GLR_S_R = 32;
global.GLR_S_G = 28;
global.GLR_S_B = 46;


//noon
global.GLR_N_R = 93;
global.GLR_N_G = 88;
global.GLR_N_B = 103;


//afternoon
global.GLR_A_R = 243;
global.GLR_A_G = 238;
global.GLR_A_B = 203;


//evening
global.GLR_E_R = 183;
global.GLR_E_G = 128;
global.GLR_E_B = 73;