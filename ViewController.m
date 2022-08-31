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
        @"88.79.149.4",
        @"156.253.5.206",
        @"195.238.40.45",
        @"2.200.156.34",
        @"2.174.40.106",
        @"2.174.20.180",
        @"2.59.135.110",
        @"148.251.194.74",
        @"217.160.70.42",
        @"37.120.217.75",
        @"146.70.82.3",
        @"217.160.166.161",
        @"212.211.132.4",
        @"176.9.93.198",
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
        @"95.142.107.181",
        @"185.206.224.67",
        @"195.201.213.247",
        @"5.152.197.179",
        @"195.12.50.155",
        @"92.204.243.227",
        @"46.248.187.100",
        @"197.221.23.194",
        @"47.94.129.116",
        @"47.108.182.80",
        @"8.134.33.121",
        @"47.104.1.98",
        @"47.119.149.69",
        @"103.1.14.238",
        @"103.159.84.142",
        @"106.14.156.213",
        @"110.50.243.6",
        @"185.235.10.211",
        @"223.252.19.130",
        @"101.0.86.43",
        @"185.229.226.83",
        @"207.250.235.10",
    ]];
    NSMutableArray* response = [[NSMutableArray alloc] init];
    for (NSString* ip in array) {
        Pinger *ping = [[Pinger alloc] init];
        [ping start:ip];
        [response addObject:ping];
    }
    [_center addObserver:self selector:@selector(setPingToView:) name:@"PingStopped" object:nil];
    
    [_center addObserver:self selector:@selector(getPingSummary:) name:@"PingReceived" object:nil];
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
    _textView.text = [NSString stringWithFormat:@"%@\nHost: %@ Ping:%f", _textView.text, host, avgPing];
    NSLog(@"Loggin in View Controller %@", notification.userInfo);
}

@end
