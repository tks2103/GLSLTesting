//
//  ParticleSystem.h
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/3/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "VBO.h"

@interface ParticleSystem : NSObject {
  NSMutableArray  *particles_;
  int             maxParticles_;
  GLKVector2      origin_;
  vbo_t           *VBO_;
}

@property (nonatomic, readonly) int particleCount;

- (id)initWithMax:(int)mp;
- (void)update:(float)dt;
- (void)generateVBO;
- (vbo_t *)getVBO;
- (void)logState;

@end
