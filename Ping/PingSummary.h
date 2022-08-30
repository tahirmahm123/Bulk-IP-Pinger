//
//  PingSummary.h
//  Ping
//
//  Created by Tahir Mahmood on 31/08/2022.
//  Copyright (c) 2022 Digital Developers and Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PingSummary : NSObject <NSCopying>

typedef enum {
    PingStatusPending,
    PingStatusSuccess,
    PingStatusFail,
} PingStatus;

@property (assign, nonatomic) NSUInteger        sequenceNumber;
@property (assign, nonatomic) NSUInteger        payloadSize;
@property (assign, nonatomic) NSUInteger        ttl;
@property (strong, nonatomic, nullable) NSString          *host;
@property (strong, nonatomic, nullable) NSDate            *sendDate;
@property (strong, nonatomic, nullable) NSDate            *receiveDate;
@property (assign, nonatomic) NSTimeInterval    rtt;
@property (assign, nonatomic) PingStatus      status;

@end
