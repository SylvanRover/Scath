// SL_engine_ini_begin();
// Begins system initialization

var i;

global.sl_viewid      = view_current; // The index of the view in which to display the effects
sl_tod_active         = true;         // Enable / disable the shadows and lighting management system of the day / night cycle
sl_timespeed          = 0;            // Quicken the speed of the in-game hour
sl_buffer_texturesize = 1;            // Buffer size factor (between 0 and 1)
sl_maxexposure        = 0.5;          // Maximum light saturation factor

sl_ambient_color        = -1; // Color of the ambient light
global.sl_ambient_light = -1; // Power of the ambient light
global.sl_lightlist[0]  = -1; // List the light objects

// Variables for synchronization display / buffer
sl_buffer_sync    = true;
sl_buffer_xmargin = -1;
sl_buffer_ymargin = -1;

// Layers
sl_layers_count = 0; // Nombre de layers

// Variables for solar shadows
sl_sunshadows_active        = false; // Determines whether rendering solar shadows should be done or not
sl_sunshadows_texturesize   = 0.6;   // Solar shadows size factor (between 0 and 1)
sl_sunshadows_quality       = 0.4;   // Factor determining the number of solar shadows samples(between 0 and 1)
sl_sunshadows_alpha         = 0.8;   // Solar shadow transparency factor (between 0 and 1)
sl_sunshadows_alphalimit    = 0.6;   // Minimum level of ambient light for which the solar shadows are visible
sl_sunshadows_margin        = 150;   // Size of the solar shadow margin, pixel
sl_sunshadows_refresh       = true;  // Determines if the solar shades are updated or not
sl_sunshadows_refreshrate   = 0;     // Refresh solar shadows in steps (<= 0 for continuous refreshing)
sl_sunshadows_layerscale[0] = -1;    // Solar shadow stretching factors for the different layers
sl_sunshadows_list[0,1]     = -1;    // List of objects casting a solar shadow
sl_sunshadows_texlist[0,1]  = -1;    // List of objects casting a solar shadow with a texture

// Variables for ambient shadows
sl_ambientshadows_active    = false; // Determines whether rendering ambient shadows should be performed or not
sl_ambientshadows_alpha     = 1;    // Ambient shadows transparency factor (between 0 and 1)
sl_ambientshadows_mapscale  = 0.5;  // Size factor of ambient maps
sl_ambientshadows_map[0]    = -1;   // List of ambient maps
sl_ambientshadows_list[0,1] = -1;   // List of objects casting ambient shadows
sl_ambientshadows_lock      = true; // Prevents the display of ambient maps before they are calculated

// List of objects in layers of with masks
sl_global_list[0,1] = -1;
