///glr_mesh_set_shadow_strength(mesh id, strength);
//sets the shadow strength for this mesh
//also lights can have shadow strength, so the Max shadow-steength value between 
// the light and the mesh will be used
//for example, if your light has shadowstrength = 0.5  and your mesh shadowstrength = 1
//the shadow will have shadow_strength = 1
ds_list_replace(argument0,15,clamp(argument1,0,1));