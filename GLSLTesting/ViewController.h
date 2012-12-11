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
@class ParticleSystem;

@interface ViewController : GLKViewController {
  GLuint      _positionSlot;
  GLuint      _colorSlot;
  GLuint      _projectionUniform;
  GLuint      _modelViewUniform;
  GLuint      _thickness;
  GLuint      _time;
  GLuint      _velocity;
  ShaderProgram *_shaderProgram;
  ShaderManager *_shaderManager;
  ParticleSystem *particleSystem;
  GLKVector2  *vertices;
  GLKMatrix4  _modelViewMatrix;
  UILabel     *label_;
  int         fpsLag_;
}

- (void)update;
- (void)compileShaders;
- (void)setupVBOs;

@end
