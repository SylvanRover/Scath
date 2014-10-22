// SL_light_cast_obj(object,mask);
// Function to define or exclude objects for a given light

for (i=0; i>=0; i+=1)
{
    if sl_light_shadowlist[i,0]=argument0 break; 
    else if sl_light_shadowlist[i,0]=-1
    {
        sl_light_shadowlist[i,0]   = argument0;
        sl_light_shadowlist[i,1]   = argument1;
        sl_light_shadowlist[i+1,0] = -1;
        break;
    }
}
