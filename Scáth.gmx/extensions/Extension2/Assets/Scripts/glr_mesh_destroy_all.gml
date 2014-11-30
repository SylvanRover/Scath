///glr_mesh_destroy_all()
var i, mesh
var size = ds_list_size(global.GLR_MESH_STC_LIST);
for(i=0; i<size; i++){
    mesh = global.GLR_MESH_STC_LIST[| i];
    ds_list_destroy(mesh[| 1]);
    buf = mesh[| 2];
    if(buf != -1) vertex_delete_buffer(buf); 
    if(mesh[| 25]){ 
        var dirmesh = mesh[| 26];
        ds_list_delete(global.GLR_TILES_MESH_LIST, ds_list_find_index(global.GLR_TILES_MESH_LIST, dirmesh));
        d3d_model_destroy(dirmesh);
    }
    ds_list_destroy(mesh);
}
ds_list_clear(global.GLR_MESH_STC_LIST);

size = ds_list_size(global.GLR_MESH_DYN_LIST);
for(i=0; i<size; i++){
    mesh = global.GLR_MESH_DYN_LIST[| i];
    ds_list_destroy(mesh[| 1]);
    buf = mesh[| 2];
    if(buf != -1) vertex_delete_buffer(buf); 
    if(mesh[| 25]){
        var dirmesh = mesh[| 26];
        ds_list_delete(global.GLR_TILES_MESH_LIST, ds_list_find_index(global.GLR_TILES_MESH_LIST, dirmesh));
        d3d_model_destroy(dirmesh);
    }
    ds_list_destroy(mesh);
}
ds_list_clear(global.GLR_MESH_DYN_LIST);