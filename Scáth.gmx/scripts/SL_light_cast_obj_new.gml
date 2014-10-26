/* SL_light_cast_obj(layer,object,mask,cast);                                             */
/* Function used to define for which objects a light needs to project a shadow */

// Updates the number of layers
sl_light_layers_count = max(argument0+1,sl_light_layers_count);

for (i=0; i>=0; i+=1)
{
    if sl_light_shadowlist[i,0]=argument1 break; 
    else if sl_light_shadowlist[i,0]=-1
    {
        sl_light_shadowlist[i,0]   = argument1;
        sl_light_shadowlist[i,1]   = argument2;
        sl_light_shadowlist[i+1,0] = -1;
        break;
    }
}
