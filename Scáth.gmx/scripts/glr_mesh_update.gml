///glr_mesh_update(mesh id)
var vlist=ds_list_find_value(argument0,1);
var buf=ds_list_find_value(argument0,2);
if(buf != -1) vertex_delete_buffer(buf); 
buf = vertex_create_buffer(); 
var sz=ds_list_size(vlist);
 

vertex_begin(buf, global.GLR_VERTEX_FORMAT);
for(var i=0; i< sz - 2; i+=2)
{
    var XX1 = ds_list_find_value(vlist, i);
    var YY1 = ds_list_find_value(vlist, i + 1);
    var XX2 = ds_list_find_value(vlist, i + 2);
    var YY2 = ds_list_find_value(vlist, i + 3);
    
    vertex_position_3d(buf, XX1, YY1, 1);
    vertex_position_3d(buf, XX2, YY2, 0);
    vertex_position_3d(buf, XX2, YY2, 1);
    
    vertex_position_3d(buf, XX1, YY1, 0);
    vertex_position_3d(buf, XX2, YY2, 0);
    vertex_position_3d(buf, XX1, YY1, 1);
} 
vertex_end(buf);
vertex_freeze(buf);
ds_list_replace(argument0,2,buf);


/*BOUNDING BOX & BOUNDING CIRCLE*/

var bx1 = 1000000, by1 = 1000000, bx2 =-1000000, by2 = -1000000, bcr = 0;

for(var i=0; i< sz - 2; i+=2)
{
    var xx = ds_list_find_value(vlist, i);
    var yy = ds_list_find_value(vlist, i + 1);
    bx1=min(bx1,xx);
    by1=min(by1,yy);
    bx2=max(bx2,yy);
    by2=max(by2,yy);
    bcr = max(bcr, point_distance(0, 0, xx, yy));
}
ds_list_replace(argument0,8,bcr); 
ds_list_replace(argument0,9,bx1);
ds_list_replace(argument0,10,by1);
ds_list_replace(argument0,11,bx2);
ds_list_replace(argument0,12,by2);
