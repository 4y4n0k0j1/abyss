#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float fadeWidth;
    float curve;
    float coreAlpha;
    float edgeAlpha;
    float barMix;
    vec2 pillSize;
};

void main() {
    vec2 p = (qt_TexCoord0 - 0.5) * pillSize;
    vec2 halfSize = pillSize * 0.5;
    float r = min(halfSize.x, halfSize.y);

    vec2 q = abs(p) - (halfSize - vec2(r));
    float d = length(max(q, vec2(0.0))) + min(max(q.x, q.y), 0.0) - r;

    float t = clamp(-d / max(fadeWidth, 0.001), 0.0, 1.0);
    float s = pow(max(t, 0.0001), max(curve, 0.01));
    float aa = clamp(0.5 - d, 0.0, 1.0);
    float aPill = mix(edgeAlpha, coreAlpha, s) * aa;

    float u = 1.0 - qt_TexCoord0.x;
    float sBar = pow(max(u, 0.0001), max(curve, 0.01));
    float aBar = mix(edgeAlpha, coreAlpha, sBar);

    float a = mix(aPill, aBar, clamp(barMix, 0.0, 1.0));
    fragColor = vec4(0.0, 0.0, 0.0, a * qt_Opacity);
}
