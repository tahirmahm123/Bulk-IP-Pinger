//
//  Pinger.m
//  PingTest
//
//  Created by Tahir Mahmood on 31/08/2022.
//  Copyright (c) 2022 Digital Developers and Technologies. All rights reserved.

#import "Pinger.h"

@implementation Pinger

- (void)start:(NSString*) ip {
    // create and configure a new ping object
    _center = [NSNotificationCenter defaultCenter];
    _queue = [NSNotificationQueue defaultQueue];
    self.ping = [Ping new];
    self.ping.host = ip;
//    self.ping.host = @"192.168.0.140";
//    self.ping.host = @"192.168.0.255";
    self.ping.delegate = self;
    self.ping.timeout = 1;
    self.ping.pingPeriod = 0.9;
    
    // setup the ping object (this resolves addresses etc)
    [self.ping setupWithBlock:^(BOOL success, NSError *error) {
        if (success) {
            // start pinging
            [self.ping startPinging];
            
            // stop it after 5 seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"stop it");
                [self.center postNotificationName:@"PingStopped" object:nil userInfo:@{
                    @"host": self.ping.host
                }];
                [self.ping stop];
                self.ping = nil;
            });
        } else {
            NSLog(@"failed to start");
        }
    }];

}

-(void)ping:(Ping *)pinger didReceiveReplyWithSummary:(PingSummary *)summary {
//    NSLog(@"REPLY>  %@", summary);
    NSNotification* notification = [[NSNotification alloc] initWithName:@"PingReceived" object:nil userInfo:@{
        @"summary": summary
    }];
    [_queue enqueueNotification:notification postingStyle:NSPostASAP];
}

-(void)ping:(Ping *)pinger didReceiveUnexpectedReplyWithSummary:(PingSummary *)summary {
//    NSLog(@"BREPLY> %@", summary);
}

-(void)ping:(Ping *)pinger didSendPingWithSummary:(PingSummary *)summary {
//    NSLog(@"SENT>   %@", summary);
}

-(void)ping:(Ping *)pinger didTimeoutWithSummary:(PingSummary *)summary {
//    NSLog(@"TIMOUT> %@", summary);
}

-(void)ping:(Ping *)pinger didFailWithError:(NSError *)error {
//    NSLog(@"FAIL>   %@", error);
}

-(void)ping:(Ping *)pinger didFailToSendPingWithSummary:(PingSummary *)summary error:(NSError *)error {
    NSLog(@"FSENT>  %@, %@", summary, error);
}


@end
