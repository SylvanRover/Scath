attribute vec3 in_Position;                  // (x,y,z)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
const float ray = 3.0;
const float ray2 = ray*ray*3.0; 
void main()
{
    float dep = texture2D( gm_BaseTexture, v_vTexcoord ).r;
    float ao = 0.0;
    for(float i=-ray; i<=ray; i++){
        for(float j=-ray; j<=ray; j++){
            float dep2 = texture2D(gm_BaseTexture, v_vTexcoord - vec2(i*0.002, j*0.002)).r;
            ao += max(dep2 - dep, 0.0)/ray2;
        }
    }
    gl_FragColor = vec4(0, 0, 0, min(ao, 0.8)); 
}

