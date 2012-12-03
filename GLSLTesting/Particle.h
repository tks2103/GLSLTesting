//
//  Particle.h
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/3/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Particle : NSObject {
  float       lifetime_;
  float       timelived_;
  GLKVector4  color_;
  GLKVector3  velocity_;
  GLKVector3  position_;
}

@property (nonatomic, readonly) GLKVector3 position;
@property (nonatomic, readonly) GLKVector4 color;

- (id)initWithOrigin:(GLKVector2)origin;
- (void)update:(float)dt;
- (BOOL)isDead;

@end
