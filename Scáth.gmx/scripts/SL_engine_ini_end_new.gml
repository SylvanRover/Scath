/* SL_engine_ini_end();                  */
/* Ends the initialization of the system */
var i;
if sl_ambient_color        = -1  sl_ambient_color        = make_color_rgb(sl_tod[sl_tod_index,1],sl_tod[sl_tod_index,2],sl_tod[sl_tod_index,3]);
if global.sl_ambient_light = -1  global.sl_ambient_light = sl_tod[sl_tod_index,4];
global.sl_light_gbuffer       = -1; // Global lights rendering buffer
//global.sl_lightlist[0]      = -1; // List of all light objects
global.sl_castlist[0,0]       = -1; // List of the draw values cast with SL_cast_sprite
global.sl_castlist_index      = 0;  // Used for managing sl_castlist
global.sl_texlist_light[0,0]  = -1; // List of the draw values cast with SL_draw_sprite_light
global.sl_texlist_light_index = 0;  // Used for managing sl_texlist_light
global.sl_texlist_shad[0,0]   = -1; // List of the draw values cast with SL_draw_sprite_shadow
global.sl_texlist_shad_index  = 0;  // Used for managing sl_texlist_shad
// Screen/buffer synchronization variables
if sl_buffer_sync
{if sl_buffer_xmargin = -1 { if view_hspeed[global.sl_viewid]>=0 sl_buffer_xmargin=view_hspeed[global.sl_viewid]+5 else sl_buffer_xmargin=10 };
 if sl_buffer_ymargin = -1 { if view_vspeed[global.sl_viewid]>=0 sl_buffer_ymargin=view_vspeed[global.sl_viewid]+5 else sl_buffer_ymargin=10 }};
else { sl_buffer_xmargin = 0 sl_buffer_ymargin = 0 };
sl_view_xprevious = view_xview[global.sl_viewid]; // Position of the view at the previous step
sl_view_yprevious = view_yview[global.sl_viewid];
sl_view_xspeed    = 0; // View movement speed
sl_view_yspeed    = 0;
// Layers
for (i=0; i<sl_layers_count; i+=1) sl_layers_surface[i] = -1;
// Sun shadows variables
if sl_sunshadows_layerscale[0] = -1 for (i=0; i<sl_layers_count; i+=1) sl_sunshadows_layerscale[i] = (i+1)*(1/(sl_layers_count+1));
sl_sunshadows_refreshcounter   = sl_sunshadows_refreshrate; // Counts down the number of steps between each refresh
sl_sunshadows_light            = 1; // Used for managing sun shadows transparency
sl_sunshadows_margin           = max(sl_sunshadows_margin,sl_buffer_xmargin,sl_buffer_ymargin);
// Sun shadows surfaces
sl_sunshadows_surface1[0] = -1;
sl_sunshadows_surface1[1] = -1;
sl_sunshadows_surface2    = -1;
// Ambient shadows surface
sl_ambientshadows_surface = -1;
// Buffer surfaces
sl_buffer_surface1 = -1;
sl_buffer_surface2 = -1;
sl_buffer_width    = 0;
sl_buffer_height   = 0;
