//total number of points in the casting procces. 4 means we define 4 points.(obviously.)
cast_points = 4;
 
//first point, top
cast_x[0] = 0;
cast_y[0] = +sprite_yoffset;
 
//second point, right
cast_x[1] = +sprite_xoffset;
cast_y[1] = 0;
 
//third point, bottom
cast_x[2] = 0;
cast_y[2] = -sprite_yoffset;
 
//fourth point, left
cast_x[3] = -sprite_xoffset;
cast_y[3] = 0;