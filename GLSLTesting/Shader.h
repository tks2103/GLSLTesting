//
//  Shader.h
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/1/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Shader : NSObject {
  NSString            *type_;
  NSString            *name_;
  NSMutableDictionary *variables_;
  GLuint              handle_;
  GLint               compiled_;
}

@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) GLuint   handle;
@property (nonatomic, readonly) GLint    compiled;
@property (nonatomic)           NSMutableDictionary *variables;

- (id)initWithName:(NSString *)name type:(NSString *)type variables:(NSMutableDictionary *)variables;

- (GLint)compile;
- (NSString *)getInfoLog;
- (GLenum)enumFromString:(NSString *)string;

@end
