//
//  ViewController.h
//  GLSLTesting
//
//  Created by Tanoy Sinha on 11/30/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <GLKit/GLKit.h>

@class ShaderProgram;
@class ShaderManager;

@interface ViewController : GLKViewController {
  GLuint      _positionSlot;
  GLuint      _colorSlot;
  GLuint      _projectionUniform;
  GLuint      _modelViewUniform;
  GLuint      _timeUniform;
  GLuint      _randUniform;
  GLuint      _thickness;
  float       timeval;
  ShaderProgram *_shaderProgram;
  ShaderManager *_shaderManager;
  GLKVector2  *vertices;
  GLKMatrix4  _modelViewMatrix;
}

- (void)update;
- (void)compileShaders;
- (void)setupVBOs;

@end
