///glr_mesh_draw(mesh id)

//draw the shape of the mesh (useful for debug)

var vlist=ds_list_find_value(argument0,1);
var buf,px,py,rot,xscale,yscale;

buf=ds_list_find_value(argument0,2);
px=ds_list_find_value(argument0,3);
py=ds_list_find_value(argument0,4);
rot=ds_list_find_value(argument0,5);
xscale=ds_list_find_value(argument0,6);
yscale=ds_list_find_value(argument0,7);


d3d_transform_set_identity();
d3d_transform_add_scaling(xscale,yscale,1);
d3d_transform_add_rotation_z(rot);
d3d_transform_add_translation(px,py,0);


shader_set(glr_shader_base);
shader_set_uniform_f(global.GLR_LIGHT_POSITION,mouse_x ,mouse_y );
vertex_submit(buf, pr_trianglelist,-1);
shader_reset();

d3d_transform_set_identity();