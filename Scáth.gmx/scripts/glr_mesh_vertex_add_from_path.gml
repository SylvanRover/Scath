///glr_mesh_vertex_add_from_path(mesh id, path id)
var l=ds_list_find_value(argument0,1);
var num = path_get_number(argument1);
for(var i=0; i<num; i++)
{
    ds_list_add(l,path_get_point_x(argument1,i));
    ds_list_add(l,path_get_point_y(argument1,i));
}