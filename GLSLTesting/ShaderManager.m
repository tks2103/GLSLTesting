//
//  ShaderManager.m
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/2/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import "ShaderManager.h"

#import "Shader.h"
#import "ShaderProgram.h"

@implementation ShaderManager

- (id)init {
  self = [super init];
  if (self) {
    shaders_  = [[NSMutableDictionary alloc] init];
    programs_ = [[NSMutableDictionary alloc] init];
    [self initShaders];
    [self initPrograms];
    activeProgram_ = nil;
  }
  return self;
}



- (void)initShaders {
  NSDictionary *d = @{@"Position"    : @"Attribute",
                      @"SourceColor" : @"Attribute",
                      @"Projection"  : @"Uniform",
                      @"ModelView"   : @"Uniform",
                      @"Thickness"   : @"Uniform",
                      @"Time"        : @"Attribute",
                      @"Velocity"    : @"Attribute"};
  NSMutableDictionary *data = [NSDictionary dictionaryWithDictionary:d];
  Shader *vertexShad   = [[Shader alloc] initWithName:@"SimpleVertex" type:@"Vertex" variables:data];
  Shader *fragmentShad = [[Shader alloc] initWithName:@"SimpleFragment" type:@"Fragment" variables:nil];
  
  [vertexShad compile];
  [fragmentShad compile];
  
  [shaders_ setObject:vertexShad forKey:@"SimpleVertex"];
  [shaders_ setObject:fragmentShad forKey:@"SimpleFragment"];
}



- (void)initPrograms {
  ShaderProgram *shaderProgram = [[ShaderProgram alloc] init];
  
  [shaderProgram attachShader:[shaders_ objectForKey:@"SimpleVertex"]];
  [shaderProgram attachShader:[shaders_ objectForKey:@"SimpleFragment"]];
  if ([shaderProgram linkProgram] == GL_FALSE) {
    NSLog(@"%@", [shaderProgram getInfoLog]);
    for (id key in shaders_) {
      Shader *shader = [shaders_ objectForKey:key];
      NSLog(@"%@ failed with: %@", shader.name, [shader getInfoLog]);
    }
  }
  
  [programs_ setObject:shaderProgram forKey:@"Default"];
}



- (void)useProgramWithName:(NSString *)name {
  ShaderProgram *program = [programs_ objectForKey:name];
  activeProgram_ = program;
  glUseProgram(program.handle);
}



- (NSMutableDictionary *)getActiveProgramVariables {
  return activeProgram_ == nil ? activeProgram_ : [activeProgram_ getVariables];
}

@end
