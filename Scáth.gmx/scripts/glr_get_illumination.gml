///glr_get_illumination(x, y)

/*************Description***************/
//Gets the illumination value of a pixel in the surface
//at x,y coordinate
//Use after glr_get_illumination_begin

var px = floor(argument0 * global.GLR_MAIN_QUALITY);
var py = floor(argument1 * global.GLR_MAIN_QUALITY);

var val = buffer_peek(global.GLR_ILLUM_BUFFER, (px + py * global.GLR_MAIN_SURFACE_WIDTH )* 4, buffer_u32);
 
return max((val >> 16) & 255, (val >> 8) & 255, val & 255) / 255; 