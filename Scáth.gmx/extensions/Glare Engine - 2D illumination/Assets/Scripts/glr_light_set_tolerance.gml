///glr_light_set_tolerance(light id, tolerance)
//set the mesh deactivation distance from the light (also negative)
//for example if your light is 32pixel, and your mesh is 32 pixel, the default deactivation will be calculated in this way:
//if( Distance_from_light  >  light_ray + mesh_ray - tolerance )  {
//    render mesh
//}
argument0[| 23] = argument1;