attribute vec3 in_Position;                  // (x,y,z)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec2 v_blurTexCoords[6];

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vTexcoord = in_TextureCoord;
     
    v_blurTexCoords[ 0] = v_vTexcoord + vec2(-0.012, 0.0);
    v_blurTexCoords[ 1] = v_vTexcoord + vec2(-0.008, 0.0);
    v_blurTexCoords[ 2] = v_vTexcoord + vec2(-0.004, 0.0);
    v_blurTexCoords[ 3] = v_vTexcoord + vec2( 0.004, 0.0);
    v_blurTexCoords[ 4] = v_vTexcoord + vec2( 0.008, 0.0);
    v_blurTexCoords[ 5] = v_vTexcoord + vec2( 0.012, 0.0);

}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;

varying vec2 v_blurTexCoords[6];

void main()
{
    
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
    vec4 result_color = vec4(0.0, 0.0, 0.0, col.a);
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 0].x, max(v_blurTexCoords[ 0].y, 0.0) )) * 0.07;
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 1].x, max(v_blurTexCoords[ 1].y, 0.0) )) * 0.15;
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 2].x, max(v_blurTexCoords[ 2].y, 0.0) )) * 0.18;
    result_color += col * 0.2;
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 3].x, min(v_blurTexCoords[ 3].y, 0.999) )) * 0.18;
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 4].x, min(v_blurTexCoords[ 4].y, 0.999) )) * 0.15;
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 5].x, min(v_blurTexCoords[ 5].y, 0.999) )) * 0.07;
    gl_FragColor =  max(col, result_color);  
} 
