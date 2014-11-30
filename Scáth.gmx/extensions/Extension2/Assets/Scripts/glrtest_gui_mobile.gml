///glrtest_gui_mobile()
display_set_gui_size(view_wview, view_hview)

//create light        
if(mouse_check_button_pressed(mb_right))
    instance_create(mouse_x,mouse_y,  obj_light_static);


if(glrtest_text_pressed("fxaa", 10, view_hview-50,1)){
    fxaa = !fxaa;
    glr_enable_fxaa(fxaa);
}


//toggle intensity
if(glrtest_text_pressed("intens", 60, view_hview-50,1)){ 
    intensity = !intensity;
    glr_enable_intensity(intensity);
}

//toggle directional
if(glrtest_text_pressed("dirlight", 120, view_hview-50,1)){
    directional = !directional;
    glr_enable_directional(directional);
}

//toggle occlusion
if(glrtest_text_pressed("occlusion", 170, view_hview-50,1)){
    occlusion = !occlusion;
    glr_enable_occlusion(occlusion);
}


//switch quality
var q = glr_get_quality();
if(glrtest_text_pressed("quality", 240, view_hview-50,1)){
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
if(glrtest_text_pressed("time++", 300, view_hview-50,1)){
    add_time+=1000;
}
if(glrtest_text_pressed("time--", 360, view_hview-50,1)){
    add_time-=1000;
}

 

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
    draw_text(15, 15, "-- Mobile Test --#" +
    string(fps)+" fps#"+
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
    "Occlusion: "+glrtest_string_onoff(occlusion)+"#"
    );
     
    
    
    draw_set_alpha(1);
    draw_set_color(col);

}

 