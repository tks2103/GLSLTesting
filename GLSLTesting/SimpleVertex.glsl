attribute vec3  Position; // 1
attribute vec4  SourceColor; // 2
attribute vec3  Velocity;
attribute float Time;

uniform   mat4  Projection;
uniform   mat4  ModelView;

uniform   float Thickness;

varying vec4 DestinationColor; // 3

void main(void) { // 4
    DestinationColor = SourceColor; // 5
    vec3 a = vec3(0.0, 0.0, 0.0);
    vec3 position = 0.5 * a * Time * Time + Velocity * Time + Position;
    gl_Position = Projection * ModelView * vec4(position,1);

    gl_PointSize = Thickness;
}