//
//  VBO.h
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/3/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <GLKit/GLKit.h>

#ifndef GLSLTesting_VBO_h
#define GLSLTesting_VBO_h

typedef struct {
  GLKVector3 position;
  GLKVector3 velocity;
  GLKVector4 color;
  float      time;
} vbo_t;

#endif
