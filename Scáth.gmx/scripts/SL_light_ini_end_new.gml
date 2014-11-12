/* SL_light_ini_end();                         */
/* Ends the initialization of the light object */
// System variables
global.sl_light_txsize  = sprite_get_width(sl_light_texture); // Light texture size
sl_light_refreshcounter = sl_light_refreshrate; // Counts down the number of steps between each refresh
sl_light_visible        = true; // Whether the light is visible on screen or not
sl_light_surface = -1; // Surface of the light, created during rendering when needed
