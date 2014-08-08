//total number of points in the casting procces. 4 means we define 4 points.(obviously.)
cast_points = 4;
 
//first point, top
cast_x[0]=(bbox_right+bbox_left)/2;
cast_y[0]=bbox_top;
//second point, right
cast_x[1]=bbox_right;
cast_y[1]=(bbox_top+bbox_bottom)/2;
 
//third point, bottom
cast_x[2]=(bbox_right+bbox_left)/2;
cast_y[2]=bbox_bottom;
 
//fourth point, left
cast_x[3]=bbox_left;
cast_y[3]=(bbox_top+bbox_bottom)/2;
