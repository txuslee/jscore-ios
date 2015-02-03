//
// Created by BlitSoftware on 02/02/15.
// Copyright (c) 2015 Blitsoftware. All rights reserved.
//

#import "Console.h"
#import "DDLog.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation Console

- (void)log:(NSString *)string
{
    DDLogVerbose(@"js: %@", string);
}

@end