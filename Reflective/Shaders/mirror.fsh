void main( void ) {
    // find the current pixel color
    vec4 current_color = texture2D(u_texture, v_tex_coord);
    
    // if it's not transparent
    if (current_color.a > 0.0) {
        // these values correspond to how important each color is to the overall brightness
        vec3 gray_values = vec3(0.2125, 0.7154, 0.0721);
        
        // the dot() function multiples all the colors in our source color with all the values in
        // our gray_values conversion then sums them
        float gray = dot(current_color.rgb, gray_values);
        
        // calculate the new color by blending gray with the user's input color
        vec4 new_color = vec4(gray * u_color.rgb, current_color.a);
        
        // now blend that with the original color based on the strength uniform
        gl_FragColor = mix(current_color, new_color, u_strength) * v_color_mix.a;
    } else {
        // use the current (transparent) color
        gl_FragColor = current_color;
    }
}
