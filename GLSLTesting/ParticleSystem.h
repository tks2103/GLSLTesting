//
//  ParticleSystem.h
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/3/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface ParticleSystem : NSObject {
  NSMutableArray  *particles_;
  int             maxParticles_;
  GLKVector2      origin_;
  GLKVector2      *positionVBO_;
  GLKVector4      *colorVBO_;
}

@property (nonatomic, readonly) int particleCount;

- (id)initWithMax:(int)mp;
- (void)update:(float)dt;
- (void)generatePositionVBO;
- (void)generateColorVBO;
- (GLKVector2 *)getPositionVBO;
- (GLKVector4 *)getColorVBO;

@end
