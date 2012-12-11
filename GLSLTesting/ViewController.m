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

@implementation ViewController

- (void)viewDidLoad {
  particleSystem = [[ParticleSystem alloc] initWithMax:5000];
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
  
  label_ = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 30, 20)];
  label_.backgroundColor = [UIColor clearColor];
  label_.textColor = [UIColor whiteColor];
  fpsLag_ = 0;
  
  self.view = view;
  [self.view addSubview:label_];
}



- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  fpsLag_++;
  if (fpsLag_ > 6) {
    label_.text = [NSString stringWithFormat:@"%d", (int)(1.f/[self timeSinceLastDraw])];
    fpsLag_ = 0;
  }
  
  glClear(GL_COLOR_BUFFER_BIT);
  
  vbo_t *temp = [particleSystem getVBO];
  
  GLuint vertexBuffer;
  glGenBuffers(1, &vertexBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vbo_t)*particleSystem.particleCount, temp, GL_STATIC_DRAW);
  
  GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(-100, 100, -75, 75, -1, 1);
  glUniform1f(_thickness, 1);
  glUniformMatrix4fv(_projectionUniform, 1, 0, (const GLfloat *) &projectionMatrix);
  glUniformMatrix4fv(_modelViewUniform, 1, 0, (const GLfloat *) &_modelViewMatrix);
  
  glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE,
                        sizeof(vbo_t), (const GLvoid *) offsetof(vbo_t, position));
  glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE,
                        sizeof(vbo_t), (const GLvoid *) offsetof(vbo_t, color));
  glVertexAttribPointer(_time, 1, GL_FLOAT, GL_FALSE,
                        sizeof(vbo_t), (const GLvoid *) offsetof(vbo_t, time));
  glVertexAttribPointer(_velocity, 3, GL_FLOAT, GL_FALSE,
                        sizeof(vbo_t), (const GLvoid *) offsetof(vbo_t, velocity));
  
  glDrawArrays(GL_POINTS, 0, particleSystem.particleCount);
  
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
  _velocity = [[d objectForKey:@"Velocity"] intValue];
  _time = [[d objectForKey:@"Time"] intValue];
  _thickness = [[d objectForKey:@"Thickness"] intValue];
  glEnableVertexAttribArray(_positionSlot);
  glEnableVertexAttribArray(_colorSlot);
  glEnableVertexAttribArray(_time);
  glEnableVertexAttribArray(_velocity);
  _projectionUniform = [[d objectForKey:@"Projection"] intValue];
  _modelViewUniform = [[d objectForKey:@"ModelView"] intValue];
}



- (void)setupVBOs {
  _modelViewMatrix = GLKMatrix4Identity;
  
  vbo_t *temp = [particleSystem getVBO];
  
  GLuint vertexBuffer;
  glGenBuffers(1, &vertexBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vbo_t)*particleSystem.particleCount, temp, GL_STATIC_DRAW);
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
