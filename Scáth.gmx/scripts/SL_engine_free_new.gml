/* SL_engine_free();                                       */
/* Frees the memory used by all the surfaces of the system */
for (i=0; i<sl_layers_count; i+=1)
{
    surface_free(sl_layers_surface[i]);
    sl_layers_surface[i] = -1;
}
surface_free(sl_sunshadows_surface1[0]);
surface_free(sl_sunshadows_surface1[1]);
surface_free(sl_sunshadows_surface2);
sl_sunshadows_surface1[0] = -1;
sl_sunshadows_surface1[1] = -1;
sl_sunshadows_surface2    = -1;
surface_free(sl_ambientshadows_surface);
sl_ambientshadows_surface = -1;
surface_free(global.sl_light_gbuffer);
global.sl_light_gbuffer = -1;
for (i=0; global.sl_lightlist[i]!=-1; i+=1) with global.sl_lightlist[i]
{
    surface_free(sl_light_surface);
    sl_light_surface = -1;
}
surface_free(sl_buffer_surface1);
surface_free(sl_buffer_surface2);
sl_buffer_surface1 = -1;
sl_buffer_surface2 = -1;
