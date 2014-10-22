// SL_light_ini_end();
// Finalizes the initialization of the light object

// Automatic variables
global.sl_light_txsize  = sprite_get_width(sl_light_texture); // Dimensions of the light texture
sl_light_refreshcounter = sl_light_refreshrate; // Management refresh
sl_light_visible        = true; // Determines if the light is visible or not

// The light surface
sl_light_surface = -1;
