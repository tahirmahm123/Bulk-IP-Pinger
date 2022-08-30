//
//  Ping.h
//  Ping
//
//  Created by Tahir Mahmood on 31/08/2022.
//  Copyright (c) 2022 Digital Developers and Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PingSummary.h"

@class PingSummary;
@protocol PingDelegate;

NS_ASSUME_NONNULL_BEGIN

typedef void(^StartupCallback)(BOOL success, NSError * _Nullable error);

@interface Ping : NSObject

@property (weak, nonatomic, nullable) id<PingDelegate>      delegate;

@property (copy, nonatomic, nullable) NSString                *host;
@property (assign, atomic) NSTimeInterval           pingPeriod;
@property (assign, atomic) NSTimeInterval           timeout;
@property (assign, atomic) NSUInteger               payloadSize;
@property (assign, atomic) NSUInteger               ttl;
@property (assign, atomic, readonly) BOOL           isPinging;
@property (assign, atomic, readonly) BOOL           isReady;

@property (assign, atomic) BOOL                     debug;

-(void)setupWithBlock:(StartupCallback)callback;
-(void)startPinging;
-(void)stop;

@end

@protocol PingDelegate <NSObject>

@optional

-(void)ping:(Ping *)pinger didFailWithError:(NSError *)error;

-(void)ping:(Ping *)pinger didSendPingWithSummary:(PingSummary *)summary;
-(void)ping:(Ping *)pinger didFailToSendPingWithSummary:(PingSummary *)summary error:(NSError *)error;
-(void)ping:(Ping *)pinger didTimeoutWithSummary:(PingSummary *)summary;
-(void)ping:(Ping *)pinger didReceiveReplyWithSummary:(PingSummary *)summary;
-(void)ping:(Ping *)pinger didReceiveUnexpectedReplyWithSummary:(PingSummary *)summary;

@end

NS_ASSUME_NONNULL_END
