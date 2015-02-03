//
//  ViewController.m
//  JSSpike
//
//  Created by BlitSoftware on 02/02/15.
//  Copyright (c) 2015 Blitsoftware. All rights reserved.
//

#include <JavaScriptCore/JavaScriptCore.h>
#import <CocoaLumberjack/DDLog.h>

#import "ViewController.h"
#import "Console.h"
#import "XmlHttpRequest.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface ViewController ()
@property(nonatomic, strong) JSVirtualMachine *virtualMachine;
@property(nonatomic, strong) JSContext *context;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.virtualMachine = [[JSVirtualMachine alloc] init];
    self.context = [[JSContext alloc] initWithVirtualMachine:self.virtualMachine];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception)
    {
        DDLogVerbose(@"JS Error: %@", exception);
    };
    self.context[@"XMLHttpRequest"] = [XmlHttpRequest class];
    self.context[@"console"] = [[Console alloc] init];
    self.context[@"x"] = @5;

    [self.context evaluateScript:@"console.log(x + x)"];

    // the path to the script
    NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"weatherRequest" ofType:@"js"];
    DDLogVerbose(@"%@", scriptFilePath);
    // the contents of the script
    NSString *scriptFileContents = [NSString stringWithContentsOfFile:scriptFilePath encoding:NSUTF8StringEncoding error:nil];
    [self.context evaluateScript:scriptFileContents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end