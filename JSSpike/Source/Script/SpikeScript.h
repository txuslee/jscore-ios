//
// Created by BlitSoftware on 05/02/15.
// Copyright (c) 2015 Blitsoftware. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SpikeScript : NSObject
- (instancetype)initWithVirtualMachine:(JSVirtualMachine *)virtualMachine;

- (void)extend;

- (void)testSimpleLog;

- (void)testWeatherRequest;
@end