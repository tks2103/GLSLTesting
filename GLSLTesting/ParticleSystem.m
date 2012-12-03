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

- (id)initWithMax:(int)mp {
  self = [super init];
  if (self) {
    maxParticles_ = mp;
    origin_ = GLKVector2Make(0, 0);
    particles_ = [[NSMutableArray alloc] init];
    for (int i = 0; i < maxParticles_; i++) {
      Particle *add = [[Particle alloc] initWithOrigin:origin_];
      [particles_ addObject:add];
    }
    VBO_ = malloc(sizeof(vbo_t) * [particles_ count]);
    [self generateVBO];
  }
  return self;
}



- (void)update:(float)dt {
  NSMutableArray *particlesToAdd = [[NSMutableArray alloc] init];
  for (int i = 0; i < maxParticles_; i++) {
    Particle *particle = [particles_ objectAtIndex:i];
    [particle update:dt];
    if ([particle isDead]) {
      [particles_ removeObject:particle];
      Particle *new = [[Particle alloc] initWithOrigin:origin_];
      [particlesToAdd addObject:new];
    }
  }
  [particles_ addObjectsFromArray:particlesToAdd];
  [self generateVBO];
}



- (void)generateVBO {
  for (int i = 0; i < maxParticles_; i++) {
    Particle *particle = [particles_ objectAtIndex:i];
    VBO_[i].position = particle.position;
    VBO_[i].color = particle.color;
  }
}



- (vbo_t *)getVBO {
  return VBO_;
}



- (void)dealloc {
  free(VBO_);
}



- (int)particleCount {
  return [particles_ count];
}

@end
