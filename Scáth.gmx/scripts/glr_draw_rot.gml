///glr_draw_rot(x, y, rot)

/*************Description***************/
//render the main surface on the screen, rotated by a given angle


draw_set_blend_mode_ext(bm_zero,bm_src_color);

if(global.GLR_FXAA_ENABLED){
    shader_set(glr_shader_fxaa);
    shader_set_uniform_f(global.GLR_FXAA_SIZE, global.GLR_WIDTH, global.GLR_HEIGHT);
}
if(surface_exists(global.GLR_MAIN_SURFACE)){
    var xscale = global.GLR_WIDTH / surface_get_width(global.GLR_MAIN_SURFACE) ;
    var yscale = global.GLR_HEIGHT/ surface_get_height(global.GLR_MAIN_SURFACE);
    draw_surface_ext(global.GLR_MAIN_SURFACE,argument0,argument1, xscale, yscale, argument2, -1, 1);
}

if(global.GLR_INTENSITY_ENABLED && global.GLR_INTENSITY_RENDER ){
    if(surface_exists(global.GLR_INTENSITY_SURFACE)){
        draw_set_blend_mode(bm_add); 
        //draw_surface_stretched(global.GLR_INTENSITY_SURFACE,argument0,argument1, global.GLR_WIDTH, global.GLR_HEIGHT); 
        var xscale = global.GLR_WIDTH / surface_get_width(global.GLR_INTENSITY_SURFACE) ;
        var yscale = global.GLR_HEIGHT/ surface_get_height(global.GLR_INTENSITY_SURFACE);
        draw_surface_ext(global.GLR_INTENSITY_SURFACE,argument0,argument1, xscale, yscale, argument2, -1, 1);
        draw_set_blend_mode(bm_normal);
    }
}else{
    draw_set_blend_mode(bm_normal);
}
if(global.GLR_FXAA_ENABLED){
    shader_reset();
}   