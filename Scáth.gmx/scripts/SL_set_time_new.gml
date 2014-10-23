/* SL_set_time(time);            */
/* Fonction used to set the time */
if argument0>=0 && argument0<24 global.sl_time=argument0 else global.sl_time=0; // Updates the time
for (i=1; sl_tod[i,0]<=global.sl_time; i+=1) sl_tod_index=i; // Updates the ToD index
