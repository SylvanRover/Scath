//set the blend mode to multiply, search for tutorials on this, the explanation is to long.
draw_set_blend_mode_ext(bm_dest_color,bm_zero);

//draw the surface onto the screen.
draw_surface(lightmap,view_xview[0],view_yview[0]);

//reset the blend mode
draw_set_blend_mode(bm_normal);
