//
// Created by BlitSoftware on 05/02/15.
// Copyright (c) 2015 Blitsoftware. All rights reserved.
//

#include <JavaScriptCore/JavaScriptCore.h>
#import <CocoaLumberjack/DDLog.h>

#import "SpikeScript.h"
#import "XmlHttpRequest.h"
#import "Console.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;


@interface SpikeScript ()
@property(nonatomic, strong) JSContext *context;
@end


@implementation SpikeScript

#pragma mark - Lifecycle

- (instancetype)initWithVirtualMachine:(JSVirtualMachine *)virtualMachine
{
    self = [super init];
    if (self)
    {
        self.context = [[JSContext alloc] initWithVirtualMachine:virtualMachine];
        self.context.exceptionHandler = ^(JSContext *context, JSValue *exception)
        {
            DDLogVerbose(@"JS Error: %@", exception);
        };
    }
    return self;
}

#pragma mark - Extension

- (void)extend:(JSContext *)context
{
    context[@"XMLHttpRequest"] = [XmlHttpRequest class];
    context[@"console"] = [[Console alloc] init];
    context[@"x"] = @5;
}

- (void)extend
{
    [self extend:self.context];
}

#pragma mark - Tests

- (void)testSimpleLog
{
    [self.context evaluateScript:@"console.log(x + x)"];
}

- (void)testWeatherRequest
{
    // the path to the script
    NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"weatherRequest" ofType:@"js"];
    DDLogVerbose(@"%@", scriptFilePath);
    // the contents of the script
    NSString *scriptFileContents = [NSString stringWithContentsOfFile:scriptFilePath encoding:NSUTF8StringEncoding error:nil];
    [self.context evaluateScript:scriptFileContents];
}

@end