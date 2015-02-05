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
#import "TSMessage.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface ViewController ()
@property(nonatomic, strong) UIWebView *webview;
@property(nonatomic, strong) JSContext *context;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.webview = [[UIWebView alloc] init];
    NSURL *url = [[NSURL alloc] initWithString:@"http://SERVER/releases/simpleSignon/client/index.html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webview loadRequest:request];

    self.context = [self.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSAssert([self.context isKindOfClass:[JSContext class]], @"could not find context in web view");
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception)
    {
        DDLogVerbose(@"JS Error: %@", exception);
    };

    [self.context evaluateScript:@"console.log('this is a log message that goes nowhere :(')"];
    self.context[@"console"] = [[Console alloc] init];
    [self.context evaluateScript:@"console.log('this is a log message that goes to my Xcode debug console :)')"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onLoginButtonClick:(id)sender
{
    __block NSString *user = self.userTextField.text;

    self.context[@"onSignonSuccess"] = ^() {
        DDLogVerbose(@"JS Success: %@", user);
        [TSMessage showNotificationWithTitle:@"Login"
                                    subtitle:[NSString stringWithFormat:@"User '%@' logged successfully", user]
                                        type:TSMessageNotificationTypeSuccess];
    };

    self.context[@"onSignonError"] = ^() {
        DDLogVerbose(@"JS Error: %@", user);
        [TSMessage showNotificationWithTitle:@"Login"
                                    subtitle:[NSString stringWithFormat:@"Error loggin with user '%@'", user]
                                        type:TSMessageNotificationTypeError];
    };

    NSString *script = [NSString stringWithFormat:@"$N.app.controller.signon('%@', '%@', onSignonSuccess, onSignonError);", self.userTextField.text, self.passwordTextField.text];
    [self.context evaluateScript:script];
}

@end