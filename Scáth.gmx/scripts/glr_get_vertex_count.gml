///glr_get_vertex_count()
var i, mesh;

var vertices = 0;

var size = ds_list_size(global.GLR_MESH_STC_LIST);
for(i=0; i<size; i++){
    mesh = global.GLR_MESH_STC_LIST[| i];
    vertices += ds_list_size(mesh[| 1])/2;
} 

size = ds_list_size(global.GLR_MESH_DYN_LIST);
for(i=0; i<size; i++){
    mesh = global.GLR_MESH_DYN_LIST[| i];
    vertices += ds_list_size(mesh[| 1])/2;
}

return vertices;