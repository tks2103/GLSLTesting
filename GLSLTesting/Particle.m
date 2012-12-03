//
//  Particle.m
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/3/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import "Particle.h"

@implementation Particle

@synthesize position  = position_;
@synthesize color     = color_;

- (id)initWithOrigin:(GLKVector2)origin {
  self = [super init];
  if (self) {
    lifetime_ = arc4random() % 3 + 3;
    timelived_ = 0;
    color_ = GLKVector4Make(1, 1, 0, 1);
    float rand1 = ((double)arc4random() / UINT32_MAX) * 2 - 1;
    float rand2 = ((double)arc4random() / UINT32_MAX) * 2 - 1;
    float rand3 = ((double)arc4random() / UINT32_MAX) * 4 - 2;
    float rand4 = ((double)arc4random() / UINT32_MAX) * 3;
    GLKVector2 rand = GLKVector2Make(rand1,
                                     rand2);
    position_ = GLKVector2Add(origin, rand);
    velocity_ = GLKVector2Make(rand3, rand4);
  }
  return self;
}



- (void)update:(float)dt {
  timelived_ += dt;
  position_ = GLKVector2Add(position_, GLKVector2MultiplyScalar(velocity_, dt));
}



- (BOOL)isDead {
  if (timelived_ > lifetime_) {
    return YES;
  }
  return NO;
}

@end
