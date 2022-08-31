//
//  Pinger.h
//  PingTest
//
//  Created by Tahir Mahmood on 31/08/2022.
//  Copyright (c) 2022 Digital Developers and Technologies. All rights reserved.

#import <Foundation/Foundation.h>
#import "Ping/Ping.h"

NS_ASSUME_NONNULL_BEGIN

@interface Pinger : NSObject <PingDelegate>
@property (weak, nonatomic) NSNotificationCenter* center;
@property (weak, nonatomic) NSNotificationQueue* queue;
@property (strong, nonatomic) Ping *ping;
- (void)start:(NSString*) ip;
-(void)ping:(Ping *)pinger didReceiveReplyWithSummary:(PingSummary *)summary;
-(void)ping:(Ping *)pinger didReceiveUnexpectedReplyWithSummary:(PingSummary *)summary ;
-(void)ping:(Ping *)pinger didSendPingWithSummary:(PingSummary *)summary;
-(void)ping:(Ping *)pinger didTimeoutWithSummary:(PingSummary *)summary;
-(void)ping:(Ping *)pinger didFailWithError:(NSError *)error;
-(void)ping:(Ping *)pinger didFailToSendPingWithSummary:(PingSummary *)summary error:(NSError *)error ;
@end

NS_ASSUME_NONNULL_END
