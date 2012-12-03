attribute vec4  Position; // 1
attribute vec4  SourceColor; // 2

uniform   mat4  Projection;
uniform   mat4  ModelView;

uniform   float Thickness;

varying vec4 DestinationColor; // 3

void main(void) { // 4
    DestinationColor = SourceColor; // 5
    vec4 position = Projection * ModelView * Position;
    gl_Position = position; // 6

    gl_PointSize = Thickness;
}