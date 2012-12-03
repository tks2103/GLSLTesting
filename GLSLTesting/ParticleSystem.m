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
    positionVBO_ = malloc(sizeof(GLKVector2) * [particles_ count]);
    colorVBO_ = malloc(sizeof(GLKVector4) * [particles_ count]);
    [self generatePositionVBO];
    [self generateColorVBO];
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
  [self generatePositionVBO];
  [self generateColorVBO];
}



- (void)generatePositionVBO {
  for (int i = 0; i < maxParticles_; i++) {
    Particle *particle = [particles_ objectAtIndex:i];
    positionVBO_[i] = particle.position;
  }
}



- (void)generateColorVBO {
  for (int i = 0; i < maxParticles_; i++) {
    Particle *particle = [particles_ objectAtIndex:i];
    colorVBO_[i] = particle.color;
  }
}



- (GLKVector2 *)getPositionVBO {
  return positionVBO_;
}



- (GLKVector4 *)getColorVBO {
  return colorVBO_;
}



- (void)dealloc {
  free(positionVBO_);
  free(colorVBO_);
}



- (int)particleCount {
  return [particles_ count];
}

@end
