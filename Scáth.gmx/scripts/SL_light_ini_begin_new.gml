/* SL_light_ini_begin();                         */
/* Begins the initialization of the light object */
// Modifiable variables
sl_light_active          = true;    // Enables/disables the light
sl_light_x               = x;       // Position of the light in the room
sl_light_y               = y;
sl_light_xscale          = 1;       // Scaling of the light
sl_light_yscale          = 1;
sl_light_angle           = 0;       // Rotation of the light texture
sl_light_color           = c_white; // Color of the light
sl_light_power           = 1;       // Intensity of the light
sl_light_ambientpower    = 0;       // Intensity of the light in shaded areas
sl_light_shadowlength    = 4;       // Shadows length (sets the number of iterations, must be an integer greater than 0)
sl_light_shadowfactor    = 1.03;    // Scaling applied to the shadow samples during rendering (must be greater than 1)
sl_light_shadowsharpness = 0.8;     // Sharpness of the shadows, between 0 (smoothest) and 1 (sharpest)
sl_light_castshadow      = true;    // Whether the light should cast shadows or not
sl_light_refresh         = true;    // Whether the light should be refreshed or not
sl_light_refreshrate     = 0;       // Shadows refresh rate, in steps (0 for continuous refreshing)
// System variable
sl_light_shadowlist[0,0] = -1; // List of all occluder objects
