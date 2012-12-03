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
    lifetime_ = arc4random() % 10 + 1;
    timelived_ = 0;
    color_ = GLKVector4Make(1, 1, 1, 1);
    float rand1 = ((double)arc4random() / UINT32_MAX) * 2 - 1;
    float rand2 = ((double)arc4random() / UINT32_MAX) * 2 - 1;
    float rand3 = ((double)arc4random() / UINT32_MAX) * 20 - 10;
    float rand4 = ((double)arc4random() / UINT32_MAX) * 20 - 10;
    GLKVector2 rand = GLKVector2Make(rand1,
                                     rand2);
    GLKVector2 temp = GLKVector2Add(origin, rand);
    position_ = GLKVector3Make(temp.x, temp.y, 0);
    velocity_ = GLKVector3Make(rand3, rand4, 0);
  }
  return self;
}



- (void)update:(float)dt {
  timelived_ += dt;
  position_ = GLKVector3Add(position_, GLKVector3MultiplyScalar(velocity_, dt));
}



- (BOOL)isDead {
  if (timelived_ > lifetime_) {
    return YES;
  }
  return NO;
}

@end
