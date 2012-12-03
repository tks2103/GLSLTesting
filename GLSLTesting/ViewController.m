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
#import "VBO.h"

vbo_t temp[] = {{0,0,0},{1,1,1,1}};
GLubyte indices[] = {0};

@implementation ViewController

- (void)viewDidLoad {
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
  
  GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(-100, 100, -75, 75, -1, 1);
  glUniform1f(_thickness, 20);
  glUniformMatrix4fv(_projectionUniform, 1, 0, &projectionMatrix);
  glUniformMatrix4fv(_modelViewUniform, 1, 0, &_modelViewMatrix);
  
  
  // 2
  glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(vbo_t), (const GLvoid *) offsetof(vbo_t, position));
  glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(vbo_t), (const GLvoid *) offsetof(vbo_t, color));
  
  // 3
  //glDrawArrays(GL_POINTS, 0, particleSystem.particleCount);
  glDrawElements(GL_POINTS, sizeof(indices)/sizeof(indices[0]), GL_UNSIGNED_BYTE, 0);
}



- (void)update {
  glClearColor(0, 0, 0, 1);
  [particleSystem update:[self timeSinceLastUpdate]];
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
}



- (void)setupVBOs {
  _modelViewMatrix = GLKMatrix4Identity;
  
  GLuint vertexBuffer;
  glGenBuffers(1, &vertexBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
  glBufferData(GL_ARRAY_BUFFER, 1, temp, GL_STATIC_DRAW);
  
  GLuint indexBuffer;
  glGenBuffers(1, &indexBuffer);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
