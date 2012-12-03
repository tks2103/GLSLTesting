//
//  ShaderManager.h
//  GLSLTesting
//
//  Created by Tanoy Sinha on 12/2/12.
//  Copyright (c) 2012 Tanoy Sinha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShaderProgram;

@interface ShaderManager : NSObject {
  NSMutableDictionary *shaders_;
  NSMutableDictionary *programs_;
  ShaderProgram       *activeProgram_;
}

- (id)init;

- (void)initShaders;
- (void)initPrograms;
- (void)useProgramWithName:(NSString *)name;
- (NSMutableDictionary *)getActiveProgramVariables;

@end
