//total number of points in the casting procces. 4 means we define 4 points.(obviously.)
cast_points = 4;
 
//first point, top
cast_x[0]=-sprite_xoffset+sprite_width/2;
cast_y[0]=-sprite_yoffset+(sprite_height-16);
 
//second point, right
cast_x[1]=-sprite_xoffset+(sprite_width-6);
cast_y[1]=-sprite_yoffset+(sprite_height-8);
 
//third point, bottom
cast_x[2]=-sprite_xoffset+sprite_width/2;
cast_y[2]=-sprite_yoffset+(sprite_height-4);
 
//fourth point, left
cast_x[3]=-sprite_xoffset+5;
cast_y[3]=-sprite_yoffset+(sprite_height-8);
