//
// Created by BlitSoftware on 03/02/15.
// Copyright (c) 2015 Blitsoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JSExport.h>
#import "ModuleXMLHttpRequest.h"


@protocol XmlHttpRequestExport <JSExport>

@property NSString* responseURL;
@property NSString* responseText;
@property NSNumber* readyState;
@property NSNumber* status;

@property JSValue* onreadystatechange;
//@property JSValue* ontimeout;
//@property JSValue* onprogress;
//@property JSValue* onloadstart;
//@property JSValue* onloadend;
//@property JSValue* onload;
//@property JSValue* onerror;
//@property JSValue* onabort;

- (instancetype)init;

- (void)open:(NSString *)httpMethod :(NSString *)url :(bool)async;

- (void)send;
@end


@interface XmlHttpRequest : NSObject <XmlHttpRequestExport>
@end
