///glr_mesh_create_from_tiles(static, depth)

/*************Description***************/
//create vertices from tile layer 
//mesh: the mesh id
//depth: the tile layer depth
/***************************************/

var mesh = glr_mesh_create(0, 0, argument0);
//vertex list
var l = ds_list_find_value(mesh,1);

var dirmesh = d3d_model_create();
//tiles
var tiles = tile_get_ids_at_depth(argument1);
var len = array_length_1d(tiles);
var t,x1,y1,x2,y2;
d3d_model_primitive_begin(dirmesh, pr_trianglelist);
for (var i = 0; i < len; i++;)
{
    t = tiles[i];
    x1 = tile_get_x(t);
    y1 = tile_get_y(t);
    x2 = x1 + tile_get_width(t);
    y2 = y1 + tile_get_height(t);
    
    ds_list_add(l, x1, y1);
    ds_list_add(l, x2, y1);
    
    ds_list_add(l, x2, y1);
    ds_list_add(l, x2, y2);
    
    ds_list_add(l, x2, y2);
    ds_list_add(l, x1, y2);
    
    ds_list_add(l, x1, y2);
    ds_list_add(l, x1, y1); 
    
    //dirmesh
    d3d_model_vertex(dirmesh, x1, y1, 0);
    d3d_model_vertex(dirmesh, x2, y1, 0);
    d3d_model_vertex(dirmesh, x1, y2, 0);
    
    d3d_model_vertex(dirmesh, x1, y2, 0);
    d3d_model_vertex(dirmesh, x2, y1, 0);
    d3d_model_vertex(dirmesh, x2, y2, 0);
    
}
d3d_model_primitive_end(dirmesh);

 
var buf=ds_list_find_value(mesh,2);
if(buf != -1) vertex_delete_buffer(buf); 
buf = vertex_create_buffer(); 
var sz=ds_list_size(l);
 

vertex_begin(buf, global.GLR_VERTEX_FORMAT);

for(var i=0; i< sz; i+=4)
{
    x1 = ds_list_find_value(l, i);
    y1 = ds_list_find_value(l, i + 1);
    x2 = ds_list_find_value(l, i + 2);
    y2 = ds_list_find_value(l, i + 3);
    
    vertex_position_3d(buf, x1, y1, 1);
    vertex_position_3d(buf, x2, y2, 0);
    vertex_position_3d(buf, x2, y2, 1);
    
    vertex_position_3d(buf, x1, y1, 0);
    vertex_position_3d(buf, x2, y2, 0);
    vertex_position_3d(buf, x1, y1, 1);
} 
vertex_end(buf);
vertex_freeze(buf);
mesh[| 2] = buf;


/*BOUNDING CIRCLE*/
var  bcr = 0;
for(var i=0; i< sz - 2; i+=2)
{
    x1 = ds_list_find_value(l, i);
    y1 = ds_list_find_value(l, i + 1); 
    bcr = max(bcr, point_distance(0, 0, x1, y1));
}
ds_list_replace(mesh,8,bcr);

//has dirlight
mesh[| 25] = true;
mesh[| 26] = dirmesh;
ds_list_add(global.GLR_TILES_MESH_LIST, dirmesh);

return mesh;

