///glr_mesh_vertex_add_json(mesh id, closed, json string)

//editor -> https://tizzio.github.io/meshgen


var l=ds_list_find_value(argument0,1);
var resultMap = json_decode(argument2);
var list = ds_map_find_value(resultMap, "default");
var size = ds_list_size(list);
for (var n = 0; n < size; n++;)
{
    var vtx = list[| n];
    ds_list_add(l, vtx[| 0], vtx[| 1]);
}
var vtx = list[| 0];
if(argument1) ds_list_add(l, vtx[| 0], vtx[| 1]);
ds_list_destroy(list);
ds_map_destroy(resultMap);