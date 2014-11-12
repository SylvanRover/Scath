///glr_render()

//TODO  return to old method
/*************Description***************/
//updates all the lights and shadows
//use this function in Draw Begin 


                    texture_set_repeat(false); 
var l_id, l_x, l_y, l_active,l_rotation,l_xscale,l_yscale,l_bcircle, l_tolerance, l_shadow_strength;
var l_color, l_alpha, l_intensity,l_sprite,l_spr_index,l_surf,l_shadowsprite_surf;
var l_quality,l_layer, l_ignorelist,l_ratio,l_timer,l_static, l_is_clear;
var mesh, px, py, buf, rot, xscale, yscale,shadow_strength;
var spr, tex, sub;
var test_x, test_y, render;
var rendered_mesh;
var sz;


if(view_enabled){
    var v_x0 = view_xview,
    v_y0 = view_yview,
    v_x1 = v_x0+view_wview,
    v_y1 = v_y0+view_hview;
}else{
    var v_x0 = 0,
    v_y0 = 0,
    v_x1 = room_width,
    v_y1 = room_height;
}
 
global.GLR_INTENSITY_RENDER = false;

if(!surface_exists(global.GLR_MAIN_SURFACE)){
    global.GLR_MAIN_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
    if(!surface_exists(global.GLR_MAIN_SURFACE)){
        return 0;
    }
}


d3d_set_culling(true);

var mat_world_identity =  matrix_get(matrix_world);
matrix_set(matrix_world, mat_world_identity);

var light_list_size = ds_list_size(global.GLR_LIGHT_LIST);
for(var i = 0; i < light_list_size ; i++)
{
    l_id = global.GLR_LIGHT_LIST[| i];
    
        
    l_active = l_id[| 0];
    if(!l_active) continue;
    
    //transform
    l_x =  floor(l_id[| 1])-0.5;
    l_y =  floor(l_id[| 2])-0.5;
    l_rotation = l_id[| 3];
    l_xscale = l_id[| 4];
    l_yscale = l_id[| 5];
    
    l_bcircle = l_id[| 15] * max(l_xscale, l_yscale);
    
    //out of view
    test_x = l_x - clamp(l_x, v_x0,v_x1);
    test_y = l_y - clamp(l_y, v_y0, v_y1); 
    if (test_x * test_x + test_y * test_y > l_bcircle * l_bcircle) {continue;}
    
    //info
    l_color = l_id[| 6];;
    l_intensity = l_id[| 7];
    l_sprite = l_id[| 8];
    l_spr_index = l_id[| 9];
    
    l_quality = l_id[| 10];
    l_layer = l_id[| 11]; 
    l_ratio = l_id[| 12];
    l_timer = l_id[| 13];
    l_static = l_id[| 14];
    
    render = true;
    if(l_ratio > 1)
    if(l_timer > 0)
    {
        l_timer--; 
        l_id[| 13] = l_timer;
        render = false;
    }
    else
        l_id[| 13] = l_ratio;
    
        
    var l_spr_xo = sprite_get_xoffset(l_sprite);
    var l_spr_yo = sprite_get_yoffset(l_sprite);
    var l_spr_w = sprite_get_width(l_sprite);
    var l_spr_h = sprite_get_height(l_sprite);
    
     
    var l_xo = l_spr_xo * l_xscale;
    var l_yo = l_spr_yo * l_xscale;
    var l_w = l_spr_w * l_xscale;
    var l_h = l_spr_h * l_xscale;
    var l_surf_xo = l_spr_xo * l_quality;
    var l_surf_yo = l_spr_yo * l_quality; 
    
    
    

    if (l_rotation == 0)
    {
        if(l_x - l_xo > v_x1) continue;
        if(l_y - l_yo > v_y1) continue;
        if(l_x - l_xo + l_w < v_x0) continue;
        if(l_y - l_yo + l_h < v_y0) continue;
    }
 
    ////////////////////////////////////////////////
    //  Static 
    ////////////////////////////////////////////////
    if(l_static)
    { 
        var l_lightmap = l_id[| 17];
        
        if (l_lightmap == -1 || (l_lightmap != -1 && !surface_exists(l_lightmap)))
        {
            l_id[| 21] = false; // not clear
            l_lightmap = surface_create(l_spr_w, l_spr_h);
            if(!surface_exists(l_lightmap))
                return 0;
            
            
            l_shadow_strength = l_id[| 22];
            l_tolerance = l_id[| 23];
            
            l_id[| 17] = l_lightmap; 
            
            is_clear = true;
            if(global.GLR_SHADOWSPRITE_ENABLED){

                if(!surface_exists(l_id[| 18])){
                    l_id[| 18] = surface_create(l_spr_w, l_spr_h);
                    if(!surface_exists(l_id[| 18]))
                        return 0;
                }
                l_shadowsprite_surf = l_id[| 18];
         
                surface_set_target(l_shadowsprite_surf);
                draw_clear_alpha(c_black,0);
                
                
                
                var proj_matrix = matrix_get(matrix_projection); 
                d3d_set_culling(false);
                sz = ds_list_size(global.GLR_SPR_STC_LIST);
                for(j = 0; j < sz; j++)
                {
                    spr = global.GLR_SPR_STC_LIST[| j];
                    //check layer
                    if(l_layer >= spr[| 8]){
                        tex = spr[| 0];
                        sub = spr[| 1];
                        px = spr[| 2];
                        py = spr[| 3]; 
                        xscale = spr[| 4];
                        yscale = spr[| 5];
                        rot = spr[| 6];
                        // bounding circle
                        if(point_distance(px, py, l_x, l_y) > spr[| 7] * max(abs(xscale),abs(yscale)) + l_bcircle - l_tolerance){
                            continue;
                        }
                        is_clear = false;
                        d3d_transform_set_identity(); 
                        d3d_transform_add_scaling(xscale, yscale, 1);
                        d3d_transform_add_rotation_z(rot);
                        d3d_transform_add_translation(px, py, 0);
                  
                        d3d_set_projection_ortho(l_x - l_w/2 , l_y - l_h/2 , l_w, l_h, - l_rotation);
                        var tra_matrix = matrix_build(l_xo/l_w * 2 - 1, l_yo/l_h * 2 - 1, 0, 0, 0, 0,  1/l_xscale,  1/l_yscale, 1);  
                        matrix_set(matrix_projection, matrix_multiply(proj_matrix, tra_matrix))
                        draw_sprite(tex, sub, 0, 0);  
                        d3d_transform_set_identity();
                    }
                }
                
                surface_reset_target();
                
                d3d_set_culling(true); 
                //shadowsprites rendering static
                if(!is_clear){
                    if(!surface_exists(l_id[| 19])){
                        l_id[| 19] = surface_create(l_spr_w, l_spr_h);
                        if(!surface_exists(l_id[| 19]))
                            return 0;
                    }
                    l_shadowsprite_surf2 = l_id[| 19];
                    
                    var scal = 0.0007; 
                    var pow = 0.160;
                    surface_set_target(l_shadowsprite_surf2);
                    draw_clear_alpha(0, 0);
                    shader_set(glr_shader_shadow_sprite);
                    shader_set_uniform_f(global.GLR_LIGHT_OFFSET_SPR, l_xo/l_w , l_yo/l_h );
                    shader_set_uniform_f(global.GLR_LIGHT_SCALE_SPR, scal );
                    draw_surface_ext(l_shadowsprite_surf,0,0,l_quality,l_quality,0,-1,1);
                    shader_reset();
                    
                  
                    
                    surface_reset_target();
                    
                    repeat(2){
                        pow *= 1.358;
                        scal = power(0.0007, pow);
                        surface_set_target(l_shadowsprite_surf);
                        shader_set(glr_shader_shadow_sprite);
                        shader_set_uniform_f(global.GLR_LIGHT_OFFSET_SPR, l_xo/l_w , l_yo/l_h );
                        shader_set_uniform_f(global.GLR_LIGHT_SCALE_SPR, scal );
                        draw_surface_ext(l_shadowsprite_surf2,0,0,l_quality,l_quality,0,-1,1);
                        shader_reset();
                        surface_reset_target();
                    
                        
                        pow *= 1.358;
                        scal = power(0.0007, pow);
                        surface_set_target(l_shadowsprite_surf2);
                        shader_set(glr_shader_shadow_sprite);
                        shader_set_uniform_f(global.GLR_LIGHT_OFFSET_SPR, l_xo/l_w , l_yo/l_h );
                        shader_set_uniform_f(global.GLR_LIGHT_SCALE_SPR, scal );
                        draw_surface_ext(l_shadowsprite_surf,0,0,l_quality,l_quality,0,-1,1);
                        shader_reset();
                        surface_reset_target();
                        
                    } 
                    
                }
            }
        
            surface_set_target(l_lightmap);
            
            //draw mask
            draw_sprite_ext(l_sprite, l_spr_index, l_spr_xo, l_spr_yo,1,1,0,l_color,1);
            
            //shadowsprite surface
            if(!is_clear && global.GLR_SHADOWSPRITE_ENABLED)
                draw_surface_ext(l_shadowsprite_surf2,0,0,l_quality,l_quality,0,-1,l_shadow_strength);
            
            // rendering
            var sz = ds_list_size(global.GLR_MESH_STC_LIST);
            for(j = 0; j < sz j++)
            { 
                mesh = global.GLR_MESH_STC_LIST[| j];
                //check layer
                if(l_layer >= mesh[| 14]){
                    px = mesh[| 3];
                    py = mesh[| 4];
                    buf = mesh[| 2];
                    rot = mesh[| 5];
                    xscale = mesh[| 6];
                    yscale = mesh[| 7];
                    // bounding circle
                    if(point_distance(px, py, l_x, l_y) > mesh[| 8] * max(abs(xscale),abs(yscale)) + l_bcircle - l_tolerance) 
                        continue;
                    
                    shadow_strength = mesh[| 15];
                    /*
                    d3d_transform_set_identity(); 
                    d3d_transform_add_scaling(xscale, yscale, 1);
                    d3d_transform_add_rotation_z(rot);
                    d3d_transform_add_translation(px ,py,0);
                    */
                    
                    if(mesh[| 20]){ //requires update
                        mesh[| 19] = matrix_build(px, py, 0, 0, 0, rot, xscale, yscale, 1);
                        mesh[| 20] = false;
                    }
                    
                    matrix_set(matrix_world, mesh[| 19]); // set the world matrix
                    

                    d3d_set_projection_ortho(l_x -l_w/2, l_y -l_h/2 , l_w, l_h, -l_rotation);
                    shader_set(glr_shader_base);
                    shader_set_uniform_f(global.GLR_LIGHT_OFFSET, l_xo/l_w * 2 -1 , l_yo/l_h * 2 -1 );
                    shader_set_uniform_f(global.GLR_LIGHT_STRENGTH, max(l_shadow_strength,shadow_strength)); 
                    vertex_submit(buf, pr_trianglelist,-1);
                    shader_reset();
                    
                    //d3d_transform_set_identity();
                }
            }
            //reset world matrix
            matrix_set(matrix_world, mat_world_identity);
            
            surface_reset_target();
        }
    }
    
    ////////////////////////////////////////////////
    //  Dynamic
    ////////////////////////////////////////////////
    if (render)
    {
         
        is_clear = true;
        
        l_shadow_strength = l_id[| 22];
        l_tolerance = l_id[| 23];
        
        ////////////////////////////////////////////////
        //  Render Shadow Sprites
        ////////////////////////////////////////////////
        
        if(global.GLR_SHADOWSPRITE_ENABLED){

            if(!surface_exists(l_id[| 18])){
                l_id[| 18] = surface_create(l_spr_w, l_spr_h);
                if(!surface_exists(l_id[| 18]))
                    return 0;
            }
            l_shadowsprite_surf = l_id[| 18];
    
            
            surface_set_target(l_shadowsprite_surf);
            draw_clear_alpha(c_black,0);
            
            var proj_matrix = matrix_get(matrix_projection);
            if(!l_static)
            {
                sz = ds_list_size(global.GLR_SPR_STC_LIST);
                d3d_set_culling(false);
                for(j = 0; j < sz; j++)
                {
                    spr = global.GLR_SPR_STC_LIST[| j];
                    //check layer
                    if(l_layer >= spr[| 8]){
                        tex = spr[| 0];
                        sub = spr[| 1];
                        px = spr[| 2];
                        py = spr[| 3]; 
                        xscale = spr[| 4];
                        yscale = spr[| 5];
                        rot = spr[| 6];
                         // bounding circle
                        if(point_distance(px, py, l_x, l_y) > spr[| 7] * max(abs(xscale),abs(yscale)) + l_bcircle-l_tolerance){
                            continue;
                        }
                        is_clear = false;
                        d3d_transform_set_identity(); 
                        d3d_transform_add_scaling(xscale, yscale, 1);
                        d3d_transform_add_rotation_z(rot);
                        d3d_transform_add_translation(px ,py,0); 
                  
                        d3d_set_projection_ortho(l_x -l_w/2 , l_y -l_h/2 , l_w, l_h, -l_rotation);
                        var tra_matrix = matrix_build(l_xo/l_w * 2 -1, l_yo/l_h * 2 -1, 0, 0, 0, 0, 1/l_xscale,  1/l_yscale, 1);  
                        matrix_set(matrix_projection, matrix_multiply(proj_matrix, tra_matrix))
                        draw_sprite(tex, sub, 0, 0 );  
                        d3d_transform_set_identity();
                    } 
                }
                d3d_set_culling(true);
            }
             
            sz = ds_list_size(global.GLR_SPR_DYN_LIST);
            d3d_set_culling(false);
            for(j = 0; j < sz; j++)
            {
                spr = global.GLR_SPR_DYN_LIST[| j];
                //check layer
                if(l_layer >= spr[| 8]){
                    tex = spr[| 0];
                    sub = spr[| 1];
                    px = spr[| 2];
                    py = spr[| 3]; 
                    xscale = spr[| 4];
                    yscale = spr[| 5];
                    rot = spr[| 6];
                     // bounding circle
                    if(point_distance(px, py, l_x, l_y) > spr[| 7] * max(abs(xscale),abs(yscale)) + l_bcircle-l_tolerance){
                        continue;
                    }
                    is_clear = false;
                    d3d_transform_set_identity(); 
                    d3d_transform_add_scaling(xscale, yscale, 1);
                    d3d_transform_add_rotation_z(rot);
                    d3d_transform_add_translation(px ,py,0);
              
                    d3d_set_projection_ortho(l_x -l_w/2 , l_y -l_h/2 , l_w, l_h, -l_rotation);
                    var tra_matrix = matrix_build(l_xo/l_w * 2 -1, l_yo/l_h * 2 -1, 0, 0, 0, 0,  1/l_xscale,  1/l_yscale, 1);  
                    matrix_set(matrix_projection, matrix_multiply(proj_matrix, tra_matrix))
                    draw_sprite(tex, sub, 0, 0 );  
                    d3d_transform_set_identity();
                } 
            }
            d3d_set_culling(true);
            
            
            surface_reset_target();
            
            
            
            
            
            //shadowsprites rendering
            if(!is_clear){ 
                if(!surface_exists(l_id[| 19])){
                    l_id[| 19] = surface_create(l_spr_w, l_spr_h);
                    if(!surface_exists(l_id[| 19]))
                        return 0;
                }
                l_shadowsprite_surf2 = l_id[| 19];
                var scal = 0.0007; 
                var pow = 0.160;
                surface_set_target(l_shadowsprite_surf2);
                draw_clear_alpha(0, 0);
                shader_set(glr_shader_shadow_sprite);
                shader_set_uniform_f(global.GLR_LIGHT_OFFSET_SPR, l_xo/l_w , l_yo/l_h );
                shader_set_uniform_f(global.GLR_LIGHT_SCALE_SPR, scal );
                draw_surface_ext(l_shadowsprite_surf,0,0,l_quality,l_quality,0,-1,1);
                shader_reset();
                
                 
                surface_reset_target(); 
                repeat(2){
                    pow *= 1.358;
                    scal = power(0.0007, pow);
                    surface_set_target(l_shadowsprite_surf);
                    shader_set(glr_shader_shadow_sprite);
                    shader_set_uniform_f(global.GLR_LIGHT_OFFSET_SPR, l_xo/l_w , l_yo/l_h );
                    shader_set_uniform_f(global.GLR_LIGHT_SCALE_SPR, scal );
                    draw_surface_ext(l_shadowsprite_surf2,0,0,l_quality,l_quality,0,-1,1);
                    shader_reset();
                    surface_reset_target();
                
                    
                    pow *= 1.358;
                    scal = power(0.0007, pow);
                    surface_set_target(l_shadowsprite_surf2);
                    shader_set(glr_shader_shadow_sprite);
                    shader_set_uniform_f(global.GLR_LIGHT_OFFSET_SPR, l_xo/l_w , l_yo/l_h );
                    shader_set_uniform_f(global.GLR_LIGHT_SCALE_SPR, scal );
                    draw_surface_ext(l_shadowsprite_surf,0,0,l_quality,l_quality,0,-1,1);
                    shader_reset();
                    surface_reset_target();
                     
                } 
                
            }
            
           
        
        }
        
        l_is_clear = l_id[| 21];
        
        if(!surface_exists(l_id[| 16])){
            l_id[| 16] = surface_create(l_spr_w, l_spr_h);
            if(!surface_exists(l_id[| 16])) return 0;
        }
        l_surf = l_id[| 16];
        
        
        
       
            
        surface_set_target(l_surf);
        
        //if the light mask was not used in previous frames
        if(!l_is_clear){
            //get the ligh surface 
            //light mask rendering  
            
            draw_clear(c_black); 
            if(l_static){
                draw_surface_stretched(l_lightmap,0,0,l_spr_w, l_spr_h);
            }
            else{
                draw_sprite_ext(l_sprite, l_spr_index, l_surf_xo, l_surf_yo, l_quality, l_quality, 0, l_color, 1);
            } 
        }
         
        
        if(!is_clear &&   global.GLR_SHADOWSPRITE_ENABLED)
            draw_surface_ext(l_shadowsprite_surf2,0,0,l_quality,l_quality,0,-1,l_shadow_strength);
                
        ////////////////////////////////////////////////
        //  Render Shadow Depth
        ////////////////////////////////////////////////
        var proj_matrix = matrix_get(matrix_projection);
        sz = ds_list_size(global.GLR_DEP_DYN_LIST);
        d3d_set_culling(false);
        for(j = 0; j < sz; j++)
        { 
            dp = global.GLR_DEP_DYN_LIST[| j];
            //check layer
            if(dp[| 4] > l_layer){
                tex = dp[| 0];
                sub = dp[| 1];
                px = dp[| 2];
                py = dp[| 3]; 
                xscale = dp[| 5];
                yscale = dp[| 6];
                rot = dp[| 7]; 
                 // bounding circle
                if(point_distance(px, py, l_x, l_y) > dp[| 8] * max(abs(xscale),abs(yscale)) + l_bcircle-l_tolerance){
                    continue;
                }
                is_clear = false; 
                
                
                d3d_transform_set_identity(); 
                d3d_transform_add_scaling(xscale, yscale, 1);
                d3d_transform_add_rotation_z(rot);
                d3d_transform_add_translation(px ,py,0); 
          
                d3d_set_projection_ortho(l_x -l_w/2 , l_y -l_h/2 , l_w, l_h, -l_rotation);
                
                var tra_matrix = matrix_build(l_xo/l_w * 2 -1, l_yo/l_h * 2 -1, 0, 0, 0, 0, 1/l_xscale, 1/l_yscale, 1); 
                matrix_set(matrix_projection, matrix_multiply(proj_matrix, tra_matrix));
                
                draw_sprite_ext(tex,sub,0,0,l_quality,l_quality,0,0,1); 
                d3d_transform_set_identity();
                 
            } 
        }
        d3d_set_culling(true);
        
        
        
        
        
        ////////////////////////////////////////////////
        //  Render Mesh Shadows
        ////////////////////////////////////////////////
        //shadow casting
        sz = ds_list_size(global.GLR_MESH_DYN_LIST);
        
        for(j = 0; j < sz j++)
        { 
            mesh = global.GLR_MESH_DYN_LIST[| j];
            //check layer
            if(l_layer >= mesh[| 14]){
                px = mesh[| 3];
                py = mesh[| 4];
                buf = mesh[| 2];
                rot = mesh[| 5];
                xscale = mesh[| 6];
                yscale = mesh[| 7];
                 // bounding circle
                if(point_distance(px, py, l_x, l_y) > mesh[| 8] * max(abs(xscale),abs(yscale)) + l_bcircle-l_tolerance)
                    continue;
                
                //a mesh was rendered
                is_clear = false;
                
                shadow_strength  = mesh[| 15];
                    
                /*
                d3d_transform_set_identity(); 
                d3d_transform_add_scaling(xscale, yscale, 1);
                d3d_transform_add_rotation_z(rot);
                d3d_transform_add_translation(px ,py,0);
                */
               if(mesh[| 20]){ //requires update
                    mesh[| 19] = matrix_build(px, py, 0, 0, 0, rot, xscale, yscale, 1);
                    mesh[| 20] = false;
                }
                matrix_set(matrix_world, mesh[| 19]); // set the world matrix
                 
                d3d_set_projection_ortho(l_x -l_w/2, l_y -l_h/2 , l_w, l_h, -l_rotation);
                shader_set(glr_shader_base);
                shader_set_uniform_f(global.GLR_LIGHT_OFFSET, l_xo/l_w * 2 -1 , l_yo/l_h * 2 -1 ); 
                shader_set_uniform_f(global.GLR_LIGHT_STRENGTH, max(l_shadow_strength,shadow_strength));
                vertex_submit(buf, pr_trianglelist,-1);
                shader_reset();
                //d3d_transform_set_identity();
            }
        }
        
        //static meshes
        if(!l_static)
        {
            var sz = ds_list_size(global.GLR_MESH_STC_LIST);
            for(j = 0; j < sz j++)
            { 
                mesh = global.GLR_MESH_STC_LIST[| j];
                //check layer
                if(l_layer >= mesh[| 14]){
                    px = mesh[| 3];
                    py = mesh[| 4];
                    buf = mesh[| 2];
                    rot = mesh[| 5];
                    xscale = mesh[| 6];
                    yscale = mesh[| 7];
                     // bounding circle
                    if(point_distance(px, py, l_x, l_y) >  mesh[| 8] * max(abs(xscale),abs(yscale)) + l_bcircle-l_tolerance)
                        continue;
                    
                    //a mesh was rendered
                    is_clear = false;
                    
                    shadow_strength  = mesh[| 15];
                        
                    /*
                    d3d_transform_set_identity(); 
                    d3d_transform_add_scaling(xscale, yscale, 1);
                    d3d_transform_add_rotation_z(rot);
                    d3d_transform_add_translation(px ,py,0);
                    */
                    if(mesh[| 20]){ //requires update
                        mesh[| 19] = matrix_build(px, py, 0, 0, 0, rot, xscale, yscale, 1);
                        mesh[| 20] = false;
                    }
                    matrix_set(matrix_world, mesh[| 19]); // set the world matrix
                     
                    d3d_set_projection_ortho(l_x -l_w/2, l_y -l_h/2 , l_w, l_h, -l_rotation);
                      
                    shader_set(glr_shader_base);
                    shader_set_uniform_f(global.GLR_LIGHT_OFFSET, l_xo/l_w * 2 -1 , l_yo/l_h * 2 -1 ); 
                    shader_set_uniform_f(global.GLR_LIGHT_STRENGTH, max(l_shadow_strength,shadow_strength));
                    vertex_submit(buf, pr_trianglelist,-1);
                    shader_reset(); 
                    
                    //d3d_transform_set_identity();
                }
            }
        }
        
        
        //reset world matrix
        matrix_set(matrix_world, mat_world_identity);
            
        l_id[| 21] = is_clear;
        surface_reset_target();
    }
}


d3d_set_culling(false);

////////////////////////////////////////////////
//  Directional light rendering
////////////////////////////////////////////////
if(global.GLR_DIRECTIONAL_ENABLED && global.GLR_DIRECTIONAL_STRENGTH > 0 ){
    
    var sz = ds_list_size(global.GLR_MESH_STC_LIST); 
    for(j = 0; j < sz j++)
    { 
        mesh = global.GLR_MESH_STC_LIST[| j];
        ds_priority_add(global.GLR_DIRECTIONAL_QUEUE, mesh, mesh[| 16]);
        ds_priority_add(global.GLR_DIRECTIONAL_QUEUE, 999999+mesh, mesh[| 16]+0.5); //sprite
    }
    var sz = ds_list_size(global.GLR_MESH_DYN_LIST);
    for(j = 0; j < sz j++)
    { 
        mesh = global.GLR_MESH_DYN_LIST[| j];
        ds_priority_add(global.GLR_DIRECTIONAL_QUEUE, mesh, mesh[| 16]);
        ds_priority_add(global.GLR_DIRECTIONAL_QUEUE, 999999+mesh, mesh[| 16]+0.5); //sprite
    }
    
    
    var sz = ds_list_size(global.GLR_SHADOWDIR_LIST);
    var sd;
    for(j = 0; j < sz j++)
    { 
        sd = global.GLR_SHADOWDIR_LIST[| j];
        ds_priority_add(global.GLR_DIRECTIONAL_QUEUE, sd, sd[| 6]);
        ds_priority_add(global.GLR_DIRECTIONAL_QUEUE, 999999+sd, sd[| 6]+0.5);
    }
    
    if(!surface_exists(global.GLR_DIRECTIONAL_SURFACE)){
        global.GLR_DIRECTIONAL_SURFACE = surface_create(global.GLR_DIRECTIONAL_WIDTH , global.GLR_DIRECTIONAL_HEIGHT);
        if(!surface_exists(global.GLR_DIRECTIONAL_SURFACE)){
            return 0;
        }
    }
    

    //rendering
    surface_set_target(global.GLR_DIRECTIONAL_SURFACE);
    d3d_set_projection_ortho(0,0,global.GLR_WIDTH,global.GLR_HEIGHT,0);
    draw_clear_alpha(c_black,0); //clear with alpha 0  
    var sz = ds_priority_size(global.GLR_DIRECTIONAL_QUEUE);
    var val, ID, is_sprite;
    repeat(sz){
        ID = ds_priority_delete_min(global.GLR_DIRECTIONAL_QUEUE);
        if(ID > 999999){
            ID -= 999999;
            is_sprite = true;
        }else{
            is_sprite = false;
        } 
        if(ID[| 0] == "Mesh"){
            px = ID[| 3];
            py = ID[| 4];
            buf = ID[| 2];
            rot = ID[| 5];
            xscale = ID[| 6];
            yscale = ID[| 7];
             
           // bounding circle if(point_distance(px, py, l_x, l_y) > mesh[| 8] * max(xscale,yscale) + l_bcircle-l_tolerance)
               //  continue;
              
           //  shadow_strength = ID[| 15];
                
            d3d_transform_set_identity(); 
            d3d_transform_add_scaling(xscale, yscale, 1);
            d3d_transform_add_rotation_z(rot);
            d3d_transform_add_translation(px-v_x0 ,py-v_y0,0);
            if(is_sprite){ 
                if(sprite_exists(ID[| 17])){
                    draw_set_blend_mode(bm_subtract);
                    draw_sprite(ID[| 17], ID[| 18], 0, 0);
                    draw_set_blend_mode(bm_normal);
                }
            }
            else{             
                shader_set(glr_shader_directional);
                shader_set_uniform_f(global.GLR_UNIFORM_DIRECTIONAL,lengthdir_x(global.GLR_DIRECTIONAL_LENGTH*0.2,global.GLR_DIRECTIONAL_ANGLE), lengthdir_y(global.GLR_DIRECTIONAL_LENGTH*0.2,global.GLR_DIRECTIONAL_ANGLE));
                vertex_submit(buf, pr_trianglelist,-1);
                shader_reset();
            }
            d3d_transform_set_identity();
        
        }
        else if(ID[| 0] == "Shadowdir"){
            if(is_sprite){
                draw_set_blend_mode(bm_subtract);
                draw_sprite_ext(ID[| 1], ID[| 3], ID[| 4]-v_x0, ID[| 5]-v_y0, ID[| 7], ID[| 8], ID[| 9], 0, 1);
                draw_set_blend_mode(bm_normal); 
                /*
                shader_set(glr_shader_ambient);
                shader_set_uniform_f(global.GLR_DIRECTIONAL_AMBIENT,
                    colour_get_red(global.GLR_AMBIENT_COLOR)/255,
                    colour_get_green(global.GLR_AMBIENT_COLOR)/255,
                    colour_get_blue(global.GLR_AMBIENT_COLOR)/255);
                draw_sprite_ext(ID[| 1], ID[| 3], ID[| 4]-v_x0, ID[| 5]-v_y0, ID[| 7], ID[| 8], ID[| 8], 0, 1);
                shader_reset();*/
            }
            else{
                draw_sprite_ext(ID[| 2], 0, ID[| 4]-v_x0, ID[| 5]-v_y0, global.GLR_DIRECTIONAL_LENGTH*2 , 1, global.GLR_DIRECTIONAL_ANGLE, 0, 1);
            }  
        }
    }
    surface_reset_target(); 
}

////////////////////////////////////////////////
//  Drawing main surface
////////////////////////////////////////////////


//clear the main surface



/*
if(global.GLR_DIRECTIONAL_ENABLED  && global.GLR_DIRECTIONAL_STRENGTH > 0 ){
    
    surface_set_target(global.GLR_MAIN_SURFACE);
    draw_clear_alpha(0,0); 
    shader_set(glr_shader_blur_hor); 
    draw_surface(global.GLR_DIRECTIONAL_SURFACE,0,0);
    surface_reset_target();
    
    surface_set_target(global.GLR_DIRECTIONAL_SURFACE);
    draw_clear_alpha(0,0);
    shader_set(glr_blur_vertical_shader);
    draw_surface(global.GLR_MAIN_SURFACE,0,0);
    surface_reset_target();
    shader_reset();
}

*/


////////////////////////////////////////////////
//  Render Ambient occlusion
//////////////////////////////////////////////// 

if(global.GLR_OCCLUSION_ENABLED){

    if(!surface_exists(global.GLR_OCCLUSION_SURFACE)){
        global.GLR_OCCLUSION_SURFACE = surface_create(global.GLR_OCCLUSION_WIDTH , global.GLR_OCCLUSION_HEIGHT);
        if(!surface_exists(global.GLR_OCCLUSION_SURFACE)){
            return 0;
        }
    }
    if(!surface_exists(global.GLR_DEPTH_SURFACE)){
        global.GLR_DEPTH_SURFACE = surface_create(global.GLR_OCCLUSION_WIDTH , global.GLR_OCCLUSION_HEIGHT);
        if(!surface_exists(global.GLR_DEPTH_SURFACE)){
            return 0;
        }
    }
    
    //depthmap sampler creation
    var size = ds_list_size(global.GLR_OCCLUSION_LIST);
    var size2 = ds_list_size(global.GLR_OCCLUSION_LIST_INST);
    if(size > 0 || size2 == 0){
        surface_set_target(global.GLR_DEPTH_SURFACE);
        d3d_set_projection_ortho(0,0,global.GLR_WIDTH,global.GLR_HEIGHT,0);
        draw_clear(c_black);
        shader_set(glr_shader_depth);
        var sw, bcircle;
            global.draw_calls = 0;
        for(i = 0; i<size; i++){
            l = global.GLR_OCCLUSION_LIST[| i];
            px = l[| 2];
            py = l[| 3];
            xscale = l[| 4];
            yscale = l[| 5];
            bcircle = l[| 7] * max(xscale, yscale);
            //out of view
            test_x = px - clamp(px, v_x0,v_x1);
            test_y = py - clamp(py, v_y0, v_y1);
            if (test_x * test_x + test_y * test_y < bcircle * bcircle ) {
                draw_sprite_ext(l[| 0], l[| 1], px-view_xview, py-view_yview, xscale, yscale, l[| 6], 0, 1);
            }
        }
        var inst;
        for(i = 0; i<size2; i++){
            inst = global.GLR_OCCLUSION_LIST_INST[| i];
            with(inst)
                draw_sprite_ext(sprite_index, image_index, x-view_xview, y-view_yview, image_xscale, image_yscale, image_angle, 0, 1);
        }
        shader_reset();
        surface_reset_target();
    }
    
    //occlusion rendering
    surface_set_target(global.GLR_OCCLUSION_SURFACE);
    draw_clear_alpha(0,0);
    shader_set(glr_shader_ambient_occlusion);
    draw_surface(global.GLR_DEPTH_SURFACE, 0, 0);
    shader_reset();
    surface_reset_target();
}



////////////////////////////////////////////////
//   Main surface rendering
//////////////////////////////////////////////// 


surface_set_target(global.GLR_MAIN_SURFACE);
draw_clear(global.GLR_AMBIENT_COLOR);
if(global.GLR_DIRECTIONAL_ENABLED  && global.GLR_DIRECTIONAL_STRENGTH > 0 ){
    draw_surface_stretched_ext(global.GLR_DIRECTIONAL_SURFACE,0,0,global.GLR_MAIN_SURFACE_WIDTH,global.GLR_MAIN_SURFACE_HEIGHT,0,global.GLR_DIRECTIONAL_STRENGTH);
}

if(global.GLR_OCCLUSION_ENABLED){
    draw_surface_stretched_ext(global.GLR_OCCLUSION_SURFACE, 0,0,global.GLR_MAIN_SURFACE_WIDTH,global.GLR_MAIN_SURFACE_HEIGHT,0,1);
}
surface_reset_target();

 

if(global.GLR_INTENSITY_ENABLED){
    if(!surface_exists(global.GLR_INTENSITY_SURFACE)){
        global.GLR_INTENSITY_SURFACE = surface_create(global.GLR_INTENSITY_WIDTH , global.GLR_INTENSITY_HEIGHT);
        if(!surface_exists(global.GLR_INTENSITY_SURFACE)){
            return 0;
        }
    }
    surface_set_target(global.GLR_INTENSITY_SURFACE);
    draw_clear(c_black);
    surface_reset_target();
}










////////////////////////////////////////////////
//  Render All lights
//////////////////////////////////////////////// 

draw_set_blend_mode(bm_add);

for(var i = 0; i < ds_list_size(global.GLR_LIGHT_LIST); i++)
{
     
    l_id = global.GLR_LIGHT_LIST[| i];
    
    l_active = l_id[| 0];
    
    if(!l_active) continue;
    //transform
    l_x = floor(l_id[| 1]);
    l_y = floor(l_id[| 2]);
    l_rotation = l_id[| 3];
    l_xscale = l_id[| 4];
    l_yscale = l_id[| 5];
    
    l_bcircle = l_id[| 15] * max(l_xscale, l_yscale);
    
    //out of view
    test_x = l_x - clamp(l_x, v_x0, v_x1);
    test_y = l_y - clamp(l_y, v_y0, v_y1);
    if (test_x * test_x + test_y * test_y > l_bcircle * l_bcircle) {continue;}
    
    //info 
    l_intensity = l_id[| 7];
    l_sprite = l_id[| 8];
    l_spr_index = l_id[| 9];
    l_quality = l_id[| 10];
    
    var l_spr_xo = sprite_get_xoffset(l_sprite);
    var l_spr_yo = sprite_get_yoffset(l_sprite);
    var l_spr_w = sprite_get_width(l_sprite);
    var l_spr_h = sprite_get_height(l_sprite);
    
    var l_xo = l_spr_xo * l_xscale;
    var l_yo = l_spr_yo * l_xscale;
    var l_w = l_spr_w * l_xscale;
    var l_h = l_spr_h * l_xscale;
    var l_surf_xo = l_spr_xo * l_quality;
    var l_surf_yo = l_spr_yo * l_quality; 
    
    if(!surface_exists(l_id[| 16])){
        l_id[| 16] = surface_create(l_spr_w, l_spr_h);
        if(!surface_exists(l_id[| 16])) return 0;
    }
    l_surf = l_id[| 16]; 
    
    //transform light
    d3d_transform_set_identity();
    
    d3d_transform_add_translation(-l_xo, -l_yo, 0);
    d3d_transform_add_rotation_z(l_rotation);
    d3d_transform_add_translation(l_x  ,l_y ,0);
    d3d_transform_add_translation(-v_x0, -v_y0, 0);
    
    //draw light 
    surface_set_target(global.GLR_MAIN_SURFACE); 
    d3d_set_projection_ortho(0, 0, global.GLR_WIDTH, global.GLR_HEIGHT, 0);
    draw_surface_ext(l_surf, 0, 0, 1/l_quality*l_xscale  , 1/l_quality*l_yscale  , 0, -1, 1);
    surface_reset_target();
    
    if(global.GLR_INTENSITY_ENABLED){
        if (l_intensity != 0 ){
            //draw light intensity
            global.GLR_INTENSITY_RENDER = true;
            surface_set_target(global.GLR_INTENSITY_SURFACE); 
            d3d_set_projection_ortho(0, 0,  global.GLR_WIDTH, global.GLR_HEIGHT, 0);
            shader_set(glr_shader_intensity);
            shader_set_uniform_f(global.GLR_LIGHT_INTENSITY, l_intensity);
            draw_surface_ext(l_surf, 0, 0, 1/l_quality*l_xscale  , 1/l_quality*l_yscale  , 0, -1, 1);
            shader_reset();
            surface_reset_target();
        }
    }
    
    d3d_transform_set_identity();
}

 
////////////////////////////////////////////////
//  Drawing simple lights
////////////////////////////////////////////////
for(var i = 0; i < ds_list_size(global.GLR_LIGHT_LIST_SIMPLE); i++)
{
     
    l_id = global.GLR_LIGHT_LIST_SIMPLE[| i];
    
    l_active = l_id[| 0];
    if(!l_active) continue; 
    //transform
    l_x = floor(l_id[| 1]);
    l_y = floor(l_id[| 2]);
    l_rotation = l_id[| 3];
    l_xscale = l_id[| 4];
    l_yscale = l_id[| 5];
    
    l_bcircle = l_id[| 11] * max(l_xscale, l_yscale);
    
    //out of view
    test_x = l_x - clamp(l_x, v_x0, v_x1);
    test_y = l_y - clamp(l_y, v_y0, v_y1);
    if (test_x * test_x + test_y * test_y > l_bcircle * l_bcircle) {continue;}
    
    //info 
    l_color = l_id[| 6];
    l_alpha = l_id[| 7];
    l_intensity = l_id[| 8];
    l_sprite = l_id[| 9];
    l_spr_index = l_id[| 10];
      
    
    //draw light
    surface_set_target(global.GLR_MAIN_SURFACE); 
    d3d_set_projection_ortho(0, 0, global.GLR_WIDTH, global.GLR_HEIGHT, 0);
    draw_sprite_ext(l_sprite, l_spr_index,  l_x - v_x0, l_y - v_y0, l_xscale   , l_yscale   , 0, l_color, l_alpha);
    surface_reset_target();
    
    if(global.GLR_INTENSITY_ENABLED){
        if (l_intensity != 0 ){
        global.GLR_INTENSITY_RENDER = true;
        //draw light intensity
            surface_set_target(global.GLR_INTENSITY_SURFACE); 
            d3d_set_projection_ortho(0, 0,  global.GLR_WIDTH, global.GLR_HEIGHT, 0);
            shader_set(glr_shader_intensity);
            shader_set_uniform_f(global.GLR_LIGHT_INTENSITY, l_intensity);
            draw_sprite_ext(l_sprite, l_spr_index,  l_x - v_x0, l_y - v_y0, l_xscale   , l_yscale  , 0, l_color, l_alpha);
            shader_reset();
            surface_reset_target();
        }
    }
    
}

draw_set_blend_mode(bm_normal); 
 
return 1;
 
