//
//  ViewController.m
//  GLSLTesting
//
//  Created by Tanoy Sinha on 11/30/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import "ViewController.h"

#import "Shader.h"
#import "ShaderProgram.h"
#import "ShaderManager.h"
#import "ParticleSystem.h"

typedef struct {
  float Position[3];
  float Color[4];
} Vertex;

const Vertex Vertices[] = {
  {{ 1, -1, 0}, {1, 0, 0, 1}}
};

const GLubyte Indices[] = {
  0
};

@implementation ViewController

- (void)viewDidLoad {
  timeval = 0;
    particleSystem = [[ParticleSystem alloc] initWithMax:1];
  [self setupGL];
  [self setupVBOs];
  [self compileShaders];
}



- (void)setupGL {
  EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  [EAGLContext setCurrentContext:context];
  
  GLKView *view = [[GLKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                         context:context];
  
  view.context = context;
  view.backgroundColor = [UIColor blueColor];
  
  self.view = view;
}



- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClear(GL_COLOR_BUFFER_BIT);
  
  GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(-240, 240, -160, 160, -1, 1);
  glUniform1f(_thickness, 10);
  glUniform1f(_timeUniform, timeval);
  GLKVector3 rnd = GLKVector3Make(arc4random() / UINT32_MAX,
                              arc4random() / UINT32_MAX,
                              arc4random() / UINT32_MAX);
  glUniform3f(_randUniform, rnd.x, rnd.y, 0);
  glUniformMatrix4fv(_projectionUniform, 1, 0, &projectionMatrix);
  glUniformMatrix4fv(_modelViewUniform, 1, 0, &_modelViewMatrix);
  
  // 2
  glVertexAttribPointer(_positionSlot, 2, GL_FLOAT, GL_FALSE, sizeof(GLKVector2), 0);
  glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(GLKVector4), sizeof(GLKVector2)*[particleSystem particleCount]);
  
  // 3
  glDrawArrays(GL_POINTS, 0, particleSystem.particleCount);
/*  glDrawElements(GL_POINTS, sizeof(Indices)/sizeof(Indices[0]),
                 GL_UNSIGNED_BYTE, 0);*/
}



- (void)update {
  glClearColor(0, 0, 0, 1);
  [particleSystem update:[self timeSinceLastUpdate]];
  timeval += [self timeSinceLastUpdate];
}



- (void)compileShaders {
  _shaderManager = [[ShaderManager alloc] init];

  [_shaderManager useProgramWithName:@"Default"];
  
  NSDictionary *d = [_shaderManager getActiveProgramVariables];
  
  _positionSlot = [[d objectForKey:@"Position"] intValue];
  _colorSlot = [[d objectForKey:@"SourceColor"] intValue];
  _thickness = [[d objectForKey:@"Thickness"] intValue];
  glEnableVertexAttribArray(_positionSlot);
  glEnableVertexAttribArray(_colorSlot);
  _projectionUniform = [[d objectForKey:@"Projection"] intValue];
  _modelViewUniform = [[d objectForKey:@"ModelView"] intValue];
  _timeUniform = [[d objectForKey:@"Time"] intValue];
  _randUniform = [[d objectForKey:@"Rand"] intValue];
}



- (void)setupVBOs {
  _modelViewMatrix = GLKMatrix4Identity;
  /*
  GLuint vertexBuffer;
  glGenBuffers(1, &vertexBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
  
  GLuint indexBuffer;
  glGenBuffers(1, &indexBuffer);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
  */
  GLKVector2 *temp = [particleSystem getPositionVBO];
  GLKVector4 *temp2 = [particleSystem getColorVBO];
  GLuint positionBuffer;
  glGenBuffers(1, &positionBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, positionBuffer);
  glBufferData(GL_ARRAY_BUFFER, particleSystem.particleCount, [particleSystem getPositionVBO], GL_STATIC_DRAW);
  
  GLuint colorBuffer;
  glGenBuffers(1, &colorBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, colorBuffer);
  glBufferData(GL_ARRAY_BUFFER, particleSystem.particleCount, [particleSystem getColorVBO], GL_STATIC_DRAW);
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
