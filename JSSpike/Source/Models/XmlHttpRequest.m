//
// Created by BlitSoftware on 03/02/15.
// Copyright (c) 2015 Blitsoftware. All rights reserved.
//

#import <CocoaLumberjack/DDLog.h>
#import "XmlHttpRequest.h"
#import "AFHTTPRequestOperationManager.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

/* READY STATE
Holds the status of the XMLHttpRequest. Changes from 0 to 4:
0: request not initialized
1: server connection established
2: request received
3: processing request
4: request finished and response is ready
*/

@interface XmlHttpRequest ()
@property(nonatomic, strong) JSManagedValue *onReadyStateChangeDelegate;

@property(nonatomic, copy) NSString *httpMethod;
@property(nonatomic, copy) NSString *url;
@property(nonatomic) bool async;
@end


@implementation XmlHttpRequest

@synthesize responseURL;
@synthesize responseText;
@synthesize readyState;
@synthesize status;

- (void)setOnreadystatechange:(JSValue *)onreadystatechange
{
    self.onReadyStateChangeDelegate = [JSManagedValue managedValueWithValue:onreadystatechange];
    [[[JSContext currentContext] virtualMachine] addManagedReference:self.onReadyStateChangeDelegate withOwner:self];
}

- (JSValue *)onreadystatechange
{
    return self.onReadyStateChangeDelegate.value;
}

- (void)open:(NSString *)httpMethod :(NSString *)url :(bool)async
{
    self.httpMethod = httpMethod;
    self.async = async;
    self.url = url;
}

- (void)send
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    void (^success)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (self.onReadyStateChangeDelegate)
        {
            self.responseText = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
            self.responseURL = [[operation.response URL] absoluteString];
            self.status = @([operation.response statusCode]);
            self.readyState = @4;

            [[self.onReadyStateChangeDelegate.value invokeMethod:@"bind" withArguments:@[self]] callWithArguments:@[self]];
        }
    };

    void (^failure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        DDLogVerbose(@"Error: %@", error);
    };

    AFHTTPRequestOperation *operation = [manager GET:self.url parameters:nil success:success failure:failure];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation start];
}

@end