#version 120

uniform sampler2D tex;
uniform sampler2D eggTex;
uniform vec4 fade;
uniform int cnt[6];
uniform int global_light;
uniform int trans;
uniform bool doegg;
uniform vec2 eggpos;
uniform int outline;
uniform vec2 texSize;
varying vec2 UV;


bool almosteq(in float val, in float val2)
{
    return (val >= (val2-0.05) && val <= (val2 + 0.05));
}

void main(void)
{

    const vec3 monitorsPalette[5] = vec3[](
            vec3(0.42, 0.42, 0.43),
            vec3(0.38, 0.40, 0.49),
            vec3(0.34, 0.42, 0.56),
            vec3(0.00, 0.57, 0.63),
            vec3(0.42, 0.73, 1.00)
        );


        const vec3 slimePalette[4] = vec3[] (
            vec3(0.00, 0.42, 0.00),
            vec3(0.04, 0.45, 0.02),
            vec3(0.10, 0.48, 0.05),
            vec3(0.16, 0.51, 0.10)
        );


        const vec3 shorePalette[6] = vec3[] (
            vec3(0.32, 0.24, 0.16),
            vec3(0.29, 0.23, 0.16),
            vec3(0.26, 0.21, 0.15),
            vec3(0.24, 0.20, 0.15),
            vec3(0.21, 0.18, 0.14),
            vec3(0.20, 0.16, 0.14)
        );


        const vec3 fireSlowPalette[5] = vec3[] (
            vec3(1.00, 0.00, 0.00),
            vec3(0.84, 0.00, 0.00),
            vec3(0.57, 0.16, 0.04),
            vec3(1.00, 0.46, 0.00),
            vec3(1.00, 0.23, 0.00)
        );


        const vec3 fireFastPalette[5] = vec3[] (
            vec3(0.27, 0.0, 0.0),
            vec3(0.48, 0.0, 0.0),
            vec3(0.70, 0.0, 0.0),
            vec3(0.48, 0.0, 0.0),
            vec3(0.27, 0.0, 0.0)
        );

    vec4 origColor = texture2D(tex, UV);

    if (outline == 0)
    {
        if (trans == 3) // glass
        {
            //origColor.r=0.0;
            //origColor.g=0.0;
            //origColor.b=1.0;
            if (origColor.a>0)
            {
                origColor.a=0.5;
            }
            origColor.rgb = origColor.rgb/100*global_light;
        }
        else if (trans == 4) // steam
        {
            if (origColor.a>0)
            {
                float gray = dot(origColor.rgb, vec3( 0.21, 0.72, 0.07 ));
                origColor.rgb = vec3(gray,gray,gray);
                origColor.a = 0.75;
            }
            origColor.rgb = origColor.rgb/100*global_light;
        }
        else if (trans == 5) // energy
        {
            origColor.r=0.78;
            origColor.g=0.78;
            origColor.b=0.0;
            if (origColor.a>0)
            {
                origColor.a=0.5;
            }
            origColor.rgb = origColor.rgb/100*global_light;
        }
        else if (trans == 6) // red
        {
            origColor.r=1.0;
            origColor.g=0.0;
            origColor.b=0.0;
            if (origColor.a>0)
            {
                origColor.a=0.5;
            }
            origColor.rgb = origColor.rgb/100*global_light;
        }
        else
        {

            if (almosteq(origColor.a, 0.2) && almosteq(origColor.r, 0.6))
            {
                int index = int(round(origColor.b * 255.0)) / 51;

                if (index<0) index = 0;

                if (almosteq(origColor.g, 0.0))
                {
                    if (index>3) index = 3;
                    int newIndex = int(mod((index + cnt[0]), 4));
                    origColor.rgb = slimePalette[newIndex];
                }
                else if (almosteq(origColor.g, 0.2))
                {
                    if (index>4) index = 4;
                    int newIndex = int(mod((index + cnt[1]), 5));
                    origColor.rgb = monitorsPalette[newIndex];
                }
                else if (almosteq(origColor.g, 0.4))
                {
                    if (index>4) index = 4;
                    int newIndex = int(mod((index + cnt[2]), 5));
                    origColor.rgb = fireSlowPalette[newIndex];
                }
                else if (almosteq(origColor.g, 0.6))
                {
                    if (index>4) index = 4;
                    int newIndex = int(mod((index + cnt[3]), 5));
                    origColor.rgb = fireFastPalette[newIndex];
                }
                else if (almosteq(origColor.g, 0.8))
                {
                    if (index>5) index = 5;
                    int newIndex = int(mod((index + cnt[4]), 6));
                    origColor.rgb = shorePalette[newIndex];
                }
                else if (almosteq(origColor.g, 1.0))
                {
                    origColor.rgb = vec3((cnt[5]*4)/255.0,0,0);
                }

                origColor.a = 1.0;
            }
            else
            {
                // add light
                origColor.rgb = origColor.rgb/100*global_light;
            }
        }
    }
    else
    {
        vec4 outlineColor = vec4(0.0,0.0,0.0,0.0);
        if (outline == 1) // red
        {
            outlineColor = vec4(0.25,0.0,0.0,1.0);
        }
        else if (outline == 2) // yellow
        {
            outlineColor = vec4(1.0,1.0,0.0,1.0);
        }
        else if (outline == 3) // green
        {
            outlineColor = vec4(0.0,1.0,0.0,1.0);
        }

//        ivec2 texSize = textureSize(tex,0);

        vec2 off = 1.0 / texSize;
        vec2 tc = UV.st;

        vec4 c = texture2D(tex, tc);
        vec4 n = texture2D(tex, vec2(tc.x, tc.y - off.y));
        vec4 e = texture2D(tex, vec2(tc.x + off.x, tc.y));
        vec4 s = texture2D(tex, vec2(tc.x, tc.y + off.y));
        vec4 w = texture2D(tex, vec2(tc.x - off.x, tc.y));

        float ua = 0.0;
        if (c.a == 0.0 && ( n.a != 0.0 || e.a!=0.0 || s.a!=0.0 || w.a!=0.0))
        {
            origColor = outlineColor;
        }
        else
        {
            origColor = vec4(0.0, 0.0, 0.0, 0.0);
        }
    }

    gl_FragColor = mix(origColor, fade, fade.a);
    gl_FragColor.a = origColor.a;

    if (doegg && outline == 0)
    {
        float texel_x = eggpos.x * (1. / 256.0);
        float texel_y = eggpos.y * (1. / 128.0);

        vec2 pos = UV;
        pos.x /= (256.0 / texSize.x);
        pos.y /= (texSize.y / 128.0);
        pos.x -= texel_x;
        pos.y -= texel_y;

        vec2 pixelpos = pos;
        pixelpos.x *= 256.0;
        pixelpos.y *= 128.0;

        if (pixelpos.x>=0 && pixelpos.x<129 && pixelpos.y>=0 && pixelpos.y<98)
        {
            vec4 pixel2 = texture2D(eggTex, pos);
            if (pixel2.a < gl_FragColor.a)
            {
                gl_FragColor.a = pixel2.a;
            }
        }
    }
}
