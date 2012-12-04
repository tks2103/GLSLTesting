//
//  ParticleSystem.m
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/3/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import "ParticleSystem.h"

#import "Particle.h"

@implementation ParticleSystem

+ (Emitter)pointEmitter {
  return ^(GLKVector4 bounds) {
    GLKVector2 origin = GLKVector2Make(bounds.v[0] + bounds.v[2]/2.f,
                                       bounds.v[1] + bounds.v[3]/2.f);
    float rand1 = ( (double)arc4random() / UINT32_MAX - 0.5 ) * bounds.v[2] * 0.2;
    float rand2 = ( (double)arc4random() / UINT32_MAX - 0.5 ) * bounds.v[3] * 0.2;
    GLKVector2 noise = GLKVector2Make(rand1,
                                      rand2);
    return GLKVector2Add(origin, noise);
  };
}



+ (Emitter)lineEmitter {
  return ^(GLKVector4 bounds) {
    GLKVector2 origin = GLKVector2Make(bounds.v[0],
                                       bounds.v[1] + bounds.v[3]/2.f);
    float rand1 = ( (double)arc4random() / UINT32_MAX ) * bounds.v[2];
    float rand2 = ( (double)arc4random() / UINT32_MAX - 0.5 ) * bounds.v[3] * 0.05;
    GLKVector2 noise = GLKVector2Make(rand1,
                                      rand2);
    return GLKVector2Add(origin, noise);
  };
}



+ (Emitter)circleEmitter {
  return ^(GLKVector4 bounds) {
    GLKVector2 origin = GLKVector2Make(bounds.v[0] + bounds.v[2]/2.f,
                                       bounds.v[1] + bounds.v[3]/2.f);
    float rand1 = ( (double)arc4random() / UINT32_MAX ) * bounds.v[2]/2.f;
    float rand2 = ( (double)arc4random() / UINT32_MAX ) * 2 * M_PI;
    GLKVector2 noise = GLKVector2Make(rand1 * cos(rand2), rand1 * sin(rand2));
    return GLKVector2Add(origin, noise);
  };
}



+ (Emitter)ringEmitter {
  return ^(GLKVector4 bounds) {
    GLKVector2 origin = GLKVector2Make(bounds.v[0] + bounds.v[2]/2.f,
                                       bounds.v[1] + bounds.v[3]/2.f);
    float rand1 = ( (double)arc4random() / UINT32_MAX * 0.1 + 0.9) * bounds.v[2]/2.f;
    float rand2 = ( (double)arc4random() / UINT32_MAX ) * 2 * M_PI;
    GLKVector2 noise = GLKVector2Make(rand1 * cos(rand2), rand1 * sin(rand2));
    return GLKVector2Add(origin, noise);
  };
}



- (id)initWithMax:(int)mp {
  self = [super init];
  if (self) {
    maxParticles_ = mp;
    boundingBox_ = GLKVector4Make(-20, -20, 40, 40);
    particles_ = [[NSMutableArray alloc] init];
    for (int i = 0; i < maxParticles_; i++) {
      emitter_ = [ParticleSystem ringEmitter];
      Particle *add = [[Particle alloc] initWithOrigin:emitter_(boundingBox_)];
      [particles_ addObject:add];
    }
    VBO_ = malloc(sizeof(vbo_t) * [particles_ count]);
    [self generateVBO];
  }
  return self;
}



- (void)update:(float)dt {
  for (int i = 0; i < maxParticles_; i++) {
    Particle *particle = [particles_ objectAtIndex:i];
    [particle update:dt];
    if ([particle isDead]) {
      Particle *new = [[Particle alloc] initWithOrigin:emitter_(boundingBox_)];
      [particles_ setObject:new atIndexedSubscript:i];
    }
  }
  [self generateVBO];
}



- (void)generateVBO {
  for (int i = 0; i < maxParticles_; i++) {
    Particle *particle = [particles_ objectAtIndex:i];
    VBO_[i].position = particle.position;
    VBO_[i].color = particle.color;
    VBO_[i].time = particle.timelived;
    VBO_[i].velocity = particle.velocity;
  }
}



- (vbo_t *)getVBO {
  return VBO_;
}



- (void)logState {
  for (int i = 0; i < maxParticles_; i++) {
    Particle *particle = [particles_ objectAtIndex:i];
    NSLog(@"Particle %d: (%f, %f)", i, particle.position.x, particle.position.y);
  }
}



- (void)dealloc {
  free(VBO_);
}



- (int)particleCount {
  return [particles_ count];
}

@end
