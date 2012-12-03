attribute vec4  Position; // 1
attribute vec4  SourceColor; // 2
uniform   float Time;
uniform   mat4  Projection;
uniform   mat4  ModelView;
uniform   float Rand;
uniform   float Thickness;

varying vec4 DestinationColor; // 3

float Gravity = -9.81;
float MaxSpeed = 10.0;

void main(void) { // 4
    DestinationColor = SourceColor; // 5
    vec4 position = Projection * ModelView * Position;
    vec4 trans = vec4(Time, 0.0, 0.0, 0.0);
    position = position + trans;
    gl_Position = position; // 6

    gl_PointSize = Thickness;
}