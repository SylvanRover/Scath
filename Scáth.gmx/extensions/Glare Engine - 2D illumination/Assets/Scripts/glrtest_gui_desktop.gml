///glrtest_gui_desktop()

//create light        
if(mouse_check_button_pressed(mb_right))
    instance_create(mouse_x,mouse_y,  obj_light_static);
if(mouse_check_button_pressed(mb_middle))
    instance_create(mouse_x,mouse_y,  obj_light_spot);

//Change room
if(keyboard_check_pressed(vk_space)){
    if(room != room_last) room_goto_next();
    else room_goto(room_shadowsprites);
}


//toggle fxaa
if(keyboard_check_pressed(ord("1"))){
    fxaa = !fxaa;
    glr_enable_fxaa(fxaa);
}
//toggle intensity
if(keyboard_check_pressed(ord("2"))){
    intensity = !intensity;
    glr_enable_intensity(intensity);
}
//toggle directional
if(keyboard_check_pressed(ord("3"))){
    directional = !directional;
    glr_enable_directional(directional);
}

//toggle occlusion
if(keyboard_check_pressed(ord("4"))){
    occlusion = !occlusion;
    glr_enable_occlusion(occlusion);
}

//toggle illumination
if(keyboard_check_pressed(ord("5"))){
    getillum = !getillum; 
}


//switch quality
var q = glr_get_quality();
if(keyboard_check_pressed(vk_control)){
    switch(q){
        case 1:
            glr_set_quality(0.5);
            glr_set_directional_quality(0.5);
            glr_set_intensity_quality(0.5);
            glr_set_occlusion_quality(0.5);
        break;
        case 0.5:
            glr_set_quality(0.25);
            glr_set_directional_quality(0.25);
            glr_set_intensity_quality(0.25);
            glr_set_occlusion_quality(0.25);
        break;
        case 0.25:
            glr_set_quality(1);
            glr_set_directional_quality(1);
            glr_set_intensity_quality(1);
            glr_set_occlusion_quality(1);
        break;
    }
}


//edit daytime
if(keyboard_check(vk_pageup)){
    add_time+=500;
}
else if(keyboard_check(vk_down)){
    add_time-=500;
}


//test of get illumination functions

if(getillum)
    illum = glrtest_get_illumination(); 
else 
    illum = "disabled";
     

//DEBUG
if(debug){
    draw_set_font(font_glare);
    var col=draw_get_color();
    var alpha = draw_get_alpha();
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(5,5, 150,240, 0);
    draw_set_color(c_white);
    draw_rectangle(5,5, 150,240, 1);
    draw_text(15, 15, string(fps)+" fps#"+
    "Quality: "+string(q*100)+ "%#"+ 
    "ViewSize: "+string(global.GLR_WIDTH)+"x"+string(global.GLR_HEIGHT)+ "#"+
    "DayTime: "+string_format(daytime*24,2,0)+ "#"+
    string(ds_list_size(global.GLR_MESH_DYN_LIST))+" dynamic meshes#"+
    string(ds_list_size(global.GLR_MESH_STC_LIST))+" static meshes#"+
    string(ds_list_size(global.GLR_LIGHT_LIST))+" lights#"+
    string(ds_list_size(global.GLR_LIGHT_LIST_SIMPLE))+" simple lights#"+
    "FXAA: "+glrtest_string_onoff(fxaa)+"#"+
    "Intensity: "+glrtest_string_onoff(intensity)+"#"+
    "Directional: "+glrtest_string_onoff(directional)+"#"+
    "Occlusion: "+glrtest_string_onoff(occlusion)+"#"+
    "Illumination: "+ string(illum)
    );
     
    //Controls
    draw_set_font(font_glare2);
    draw_set_color(c_black);
    draw_rectangle(5,view_hview-50, view_wview-5,view_hview-10, 0);
    draw_set_color(c_white);
    draw_rectangle(5,view_hview-50, view_wview-5,view_hview-10, 1);
    draw_text(10, view_hview-45, "CONTROLS:#"+
    "[WASD: move] "+
    "[CTRL: quality] "+
    "[MOUSE: place light] "+
    "[SPACE: change room] "+
    "[F: Flashlight] "+
    "[1: FXAA] "+
    "[2: Intensity] "+
    "[3: Directional] "+
    "[4: Occlusion] "+
    "[5: Get Illumin.] "
    );
    
    draw_set_alpha(1);
    draw_set_color(col);

}

 