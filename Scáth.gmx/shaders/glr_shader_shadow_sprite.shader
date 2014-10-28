attribute vec3 in_Position;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord; 

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_vTexcoord = in_TextureCoord;
}
 
//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;

uniform vec2 LightOffset; 
uniform float uScale; 
 

void main()
{
    //pixel distance * scale factor
  vec2 offset = vec2( v_vTexcoord - LightOffset )*uScale; 
   
  vec2 coord = v_vTexcoord;
  float alpha = 0.0;
  /*
  for(int i=0; i < 8 ; i++){
     coord -= offset;
     alpha += texture2D(gm_BaseTexture, coord ).a;
  } 
  */
  
    //manual for
    coord -= offset;
    alpha += texture2D(gm_BaseTexture, coord ).a;
    
    
    coord -= offset;
    alpha += texture2D(gm_BaseTexture, coord ).a;
    
    
    coord -= offset;
    alpha += texture2D(gm_BaseTexture, coord ).a;
    
    //4
    coord -= offset;
    alpha += texture2D(gm_BaseTexture, coord ).a;
    
    
    coord -= offset;
    alpha += texture2D(gm_BaseTexture, coord ).a;
    
    
    coord -= offset;
    alpha += texture2D(gm_BaseTexture, coord ).a;
    
    
    coord -= offset;
    alpha += texture2D(gm_BaseTexture, coord ).a;
     // 8
    coord -= offset;
    alpha += texture2D(gm_BaseTexture, coord ).a;
    
    gl_FragColor.a = alpha;
}

