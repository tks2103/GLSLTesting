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

typedef GLKVector2(^Emitter)(GLKVector4);

@interface ParticleSystem : NSObject {
  NSMutableArray  *particles_;
  Emitter         emitter_;
  int             maxParticles_;
  GLKVector4      boundingBox_;
  vbo_t           *VBO_;
}

@property (nonatomic, readonly) int particleCount;

+ (Emitter)pointEmitter;
+ (Emitter)lineEmitter;
+ (Emitter)circleEmitter;
+ (Emitter)ringEmitter;

- (id)initWithMax:(int)mp;
- (void)update:(float)dt;
- (void)generateVBO;
- (vbo_t *)getVBO;
- (void)logState;

@end
