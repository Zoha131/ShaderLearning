//
//  Shader.metal
//  ShaderLearning
//
//  Created by MD Abir Hasan Zoha on 9/22/23.
//

#include <metal_stdlib>
using namespace metal;

float3 palette(float t) {
    float3 a = float3 (0.5, 0.5, 0.5);
    float3 b = float3(0.5, 0.5, 0.5);
    float3 c = float3(1.0, 1.0, 1.0) ;
    float3 d = float3(0.263,0.416,0.557);
    return a + b*cos( 6.28318*(c*t+d) );
}

// Tutorial: https://www.youtube.com/watch?v=f4s1h2YETNY
[[ stitchable ]] half4 pattern(float2 position, half4 color, float2 size, float time) {
    // Normalize position 0 to 1
    float2 uv = position / size;
    
    // Normalize position -1 to 1
    uv = uv * 2 - 1;
    
    // Consider the aspect ration so that circle is shown as circle no matter what the size is.
    uv.x *= size.x / size.y;
    
    float2 uv0 = uv;
    float3 finalColor = float3(0);
    
    for (float i = 0; i< 3.0; i++) {
        uv = fract(uv * 1.5) - 0.5;
        
        float d = length(uv) * exp(-length(uv0));
        
        float3 col = palette(length(uv0));
        
        d = sin(d * 12.0 + time) / 12.0 ;
        
        d = abs(d);
        
        d = smoothstep(0.0, 0.04, d);
        
        d = pow(0.05 / d, 1.5);
        
        finalColor += col *= d;
    }
    
    return half4(finalColor.x, finalColor.y, finalColor.z, 1);
}
