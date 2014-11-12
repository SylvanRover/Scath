/* SL_engine_ini_begin();                  */
/* Begins the initialization of the system */
var i;
global.sl_viewid      = view_current; // ID of the view in which the effects should be drawn
sl_tod_active         = true;         // Enables/disables the day/night cycle system
sl_timespeed          = 0;            // Time progression speed
sl_buffer_texturesize = 1;            // Buffer texture size factor (between 0 and 1)
sl_maxexposure        = 0.5;          // Lights saturation factor
sl_ambient_color        = -1; // Ambient light color (can only be manually modified if sl_tod_active is false)
global.sl_ambient_light = -1; // Ambient light intensity (can only be manually modified if sl_tod_active is false)
global.sl_lightlist[0]  = -1; // Light objects list
// Screen/buffer synchronization variables
sl_buffer_sync    = true; // Enables/disables screen/buffer synchronization
sl_buffer_xmargin = -1;   // Size in pixels of the margin of the main buffer texture
sl_buffer_ymargin = -1;
// Layers
sl_layers_count = 0; // Number of layers
// Sun shadows variables
sl_sunshadows_active        = false; // Enables/disables the sun shadows system
sl_sunshadows_texturesize   = 0.6;   // Sun shadows texture size ratio (between 0 and 1)
sl_sunshadows_quality       = 0.4;   // Factor determining the number of samples to use for rendering sun shadows (between 0 and 1)
sl_sunshadows_alpha         = 0.8;   // Sun shadows transparency (between 0 and 1)
sl_sunshadows_alphalimit    = 0.6;   // Lowest ambient light intensity value below which the sun shadows will stop being visible
sl_sunshadows_margin        = 150;   // Size in pixels of the margin of the sun shadows texture
sl_sunshadows_refresh       = true;  // Whether sun shadows should be refreshed or not
sl_sunshadows_refreshrate   = 0;     // Sun shadows refresh rate, in steps (<=0 for continuous refreshing) 
sl_sunshadows_layerscale[0] = -1;    // Sun shadows scaling factors for each separate layer
sl_sunshadows_list[0,1]     = -1;    // List of all objects casting dynamic sun shadows
sl_sunshadows_texlist[0,1]  = -1;    // List of all objects casting textured sun shadows
// Ambient shadows variables
sl_ambientshadows_active    = false; // Enables/disables the ambient shadows system
sl_ambientshadows_alpha     = 1;     // Ambient shadows transparency (between 0 and 1)
sl_ambientshadows_mapscale  = 0.5;   // Ambient shadows textures size ratio
sl_ambientshadows_map[0]    = -1;    // Ambient maps list
sl_ambientshadows_list[0,1] = -1;    // List of all objects casting ambient shadows
sl_ambientshadows_lock      = true;  // Prevents ambient shadows from being drawn before being generated
// List of all objects casting global shadows (ambient and/or sun shadows)
sl_global_list[0,1] = -1;
