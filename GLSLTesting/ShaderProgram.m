//
//  ShaderProgram.m
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/1/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import "ShaderProgram.h"

#import "Shader.h"

@implementation ShaderProgram

@synthesize handle = handle_;

- (id)init {
  self = [super init];
  if (self) {
    handle_ = glCreateProgram();
    shaders_ = [[NSMutableDictionary alloc] init];
  }
  return self;
}



- (void)attachShader:(Shader *)shader {
  [shaders_ setObject:shader forKey:shader.name];
  glAttachShader(handle_, shader.handle);
}



- (GLint)linkProgram {
  glLinkProgram(handle_);
  glGetProgramiv(handle_, GL_LINK_STATUS, &linked_);
  
  return linked_;
}



- (NSString *)getInfoLog {
  GLchar messages[256];
  glGetProgramInfoLog(handle_, sizeof(messages), 0, &messages[0]);
  NSString *messageString = [NSString stringWithUTF8String:messages];
  
  return messageString;
}



- (NSMutableDictionary *)getVariablesWithNames:(NSMutableDictionary *)names {
  NSMutableDictionary *varDict = [[NSMutableDictionary alloc] init];
  for (id key in names) {
    GLint varLocation;
    varLocation = [[names objectForKey:key] isEqualToString:@"Attribute"] ?
                  glGetAttribLocation(handle_, [key cStringUsingEncoding:NSUTF8StringEncoding]) :
                  glGetUniformLocation(handle_, [key cStringUsingEncoding:NSUTF8StringEncoding]);
    [varDict setObject:[NSNumber numberWithInt:varLocation] forKey:key];
  }
  return varDict;
}



- (NSMutableDictionary *)getVariables {
  NSMutableDictionary *varDict = [[NSMutableDictionary alloc] init];
  for (id key in shaders_) {
    Shader *shader = [shaders_ objectForKey:key];
    [varDict addEntriesFromDictionary:[self getVariablesWithNames:shader.variables]];
  }
  return varDict;
}

@end
