//
//  ShaderProgram.h
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/1/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shader;

@interface ShaderProgram : NSObject {
  NSMutableDictionary *shaders_;
  GLuint              handle_;
  GLint               linked_;
}

@property (nonatomic, readonly) GLuint handle;

- (id)init;

- (void)attachShader:(Shader *)shader;
- (GLint)linkProgram;
- (NSString *)getInfoLog;
- (NSMutableDictionary *)getVariablesWithNames:(NSMutableDictionary *)names;
- (NSMutableDictionary *)getVariables;

@end
