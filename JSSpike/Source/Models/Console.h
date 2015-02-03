//
// Created by BlitSoftware on 02/02/15.
// Copyright (c) 2015 Blitsoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JSExport.h>

@protocol ConsoleExport <JSExport>
- (void)log:(NSString *)string;
@end


@interface Console : NSObject <ConsoleExport>
@end