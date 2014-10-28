///glr_mesh_create(x,y,static)

//creates an empty mesh
//use glr_mesh_vertex_* functions to add vertices and then finalize with glr_mesh_update() before render it
var l = ds_list_create();
l[| 0] = "Mesh";//type
l[| 1] = ds_list_create();//lista vertici
l[| 2] = -1 //vertex buffer
l[| 3] = argument0 //x
l[| 4] = argument1 //y
l[| 5] = 0 //rotation
l[| 6] = 1 //xscale
l[| 7] = 1 //yscale
l[| 8] = 0 //raggio bounding circle
l[| 9] = 0 //bbox x1
l[| 10] = 0 //bbox y1
l[| 11] = 0 //bbox x2
l[| 12] = 0 //bbox y2
l[| 13] = argument2//static
l[| 14] = 0;//layer
l[| 15] = 1;//shadow_stength
l[| 16] = 0;//height

l[| 17] = -1;//directional mask
l[| 18] = 0;//directional subimage

if(argument[2] == true){
    ds_list_add(global.GLR_MESH_STC_LIST, l);
}
else{
    ds_list_add(global.GLR_MESH_DYN_LIST, l);
}
return l;