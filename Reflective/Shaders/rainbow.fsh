// Fragment Shader




void main( void )
{
    vec4 color = texture2D(u_texture, v_tex_coord);
    float alpha = color.a;
    float r = (sin(u_time+ 3.14 * 0.00)+1.0)*0.5;
    float g = (sin(u_time+ 3.14 * 0.33)+1.0)*0.5;
    float b = (sin(u_time+ 3.14 * 0.66)+1.0)*0.5;
    gl_FragColor = vec4(r,g,b, 1.0) * alpha;
}
