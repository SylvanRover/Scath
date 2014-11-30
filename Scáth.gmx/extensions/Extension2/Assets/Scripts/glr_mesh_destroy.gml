///glr_mesh_destroy(mesh)

var mesh = argument0;
ds_list_destroy(mesh[| 1]);
buf = mesh[| 2];
if(buf != -1) vertex_delete_buffer(buf); 
if(mesh[| 13]){
    ds_list_delete(global.GLR_MESH_STC_LIST, ds_list_find_index(global.GLR_MESH_STC_LIST, mesh));
}else{
    ds_list_delete(global.GLR_MESH_DYN_LIST, ds_list_find_index(global.GLR_MESH_DYN_LIST, mesh));
}

if(mesh[| 25]){
    var dirmesh = mesh[| 26];
    ds_list_delete(global.GLR_TILES_MESH_LIST, ds_list_find_index(global.GLR_TILES_MESH_LIST, dirmesh));
    d3d_model_destroy(dirmesh);
}

ds_list_destroy(mesh);