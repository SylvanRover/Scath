// SL_light_ini_begin();
// Begins the initialization of the object light

// Tunable variables 
sl_light_active          = true;    // Determines whether rendering of light should be performed or not
sl_light_x               = x;       // Position of the light in the room
sl_light_y               = y;
sl_light_xscale          = 1;       // Scale of light factors
sl_light_yscale          = 1;
sl_light_angle           = 0;       // Angle of the light texture
sl_light_color           = c_white; // Color of the light
sl_light_power           = 1;       // Power of the light
sl_light_ambientpower    = 0;       // Residual power of light
sl_light_shadowlength    = 4;       // Length of shadows (determines the number of iterations )
sl_light_shadowfactor    = 1.03;    // Shadow magnification applied to each sample during rendering ( must be greater than 1)
sl_light_shadowsharpness = 0.8;     // Shadow fade factor ( between 0 and 1 )
sl_light_castshadow      = true;    // Determines whether the light casts shadows or not
sl_light_refresh         = true;    // Determines whether or not shadows are refreshed
sl_light_refreshrate     = 0;       // Refresh shadows in steps (<= 0 for continuous refreshing)

// Automatic variables
sl_light_shadowlist[0,0] = -1; // List of objects 'shadowed' by the light object
