//
//  ViewController.m
//  PingTest
//
//  Created by Tahir Mahmood on 31/08/2022.
//  Copyright (c) 2022 Digital Developers and Technologies. All rights reserved.

#import "ViewController.h"
#import "Pinger.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) NSNotificationCenter* center;
@property (strong, nonatomic) NSMutableDictionary* pingDictionary;
@end

@implementation ViewController

- (void)viewDidLoad {
    _center = [NSNotificationCenter defaultCenter];
    _pingDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray* array = [[NSMutableArray alloc] initWithArray:@[
        @"142.11.216.12",
        @"23.237.48.33",
        @"72.10.174.28",
        @"69.162.81.155",
        @"192.199.248.75",
        @"162.254.206.227",
        @"209.142.68.29",
        @"207.250.234.100",
        @"184.107.126.165",
        @"206.71.50.230",
        @"65.49.22.66",
        @"23.81.0.59",
        @"207.228.238.7",
        @"200.7.98.19",
        @"131.255.7.26",
    ]];
    NSMutableArray* response = [[NSMutableArray alloc] init];
    for (NSString* ip in array) {
        Pinger *ping = [[Pinger alloc] init];
        [ping start:ip];
        [response addObject:ping];
    }
    [_center addObserver:self selector:@selector(setPingToView:) name:@"PingStopped" object:nil];
    
    [_center addObserver:self selector:@selector(getPingSummary:) name:@"PingRecived" object:nil];
}

- (void) getPingSummary:(NSNotification*) notification {
    PingSummary* summary = notification.userInfo[@"summary"];
    if(_pingDictionary[summary.host]==nil) {
        [_pingDictionary setObject:[[NSMutableArray alloc] init] forKey:summary.host];
    }else{
        [_pingDictionary[summary.host] addObject:[NSNumber numberWithFloat:summary.rtt]];
    }
    NSLog(@"Logging in View Controller %@", notification.userInfo);
}
- (void) setPingToView:(NSNotification*) notification {
    NSString* host = notification.userInfo[@"host"];
    NSMutableArray* pingArray = _pingDictionary[host];
    float totalPing = 0.0;
    for (NSNumber* ping in pingArray) {
        totalPing+=[ping floatValue];
    }
    float avgPing = 0.0;
    if([pingArray count] >0){
        avgPing = totalPing/[pingArray count];
    }
    _textView.text = [NSString stringWithFormat:@"%@\nHost: %@ Ping:%f Object: %@", _textView.text, host, avgPing, pingArray];
    NSLog(@"Loggin in View Controller %@", notification.userInfo);
}

@end
