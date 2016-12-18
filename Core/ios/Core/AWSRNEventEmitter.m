//
//  AWSRNEventEmitter.m
//  Core
//
//  Created by Mike Nichols on 12/17/16.
//  Copyright © 2016 Amazon Web Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWSRNEventEmitter.h"

// Notification/Event Names
NSString *const kBeaconSighted = @"AWSRNEventEmitter/beaconSighted";
NSString *const kBeaconDeparted = @"AWSRNEventEmitter/beaconDeparted";

@implementation AWSRNEventEmitter

RCT_EXPORT_MODULE();

- (NSDictionary<NSString *, NSString *> *)constantsToExport {
    return @{ @"BEACON_SIGHTED": kBeaconSighted,
              @"BEACON_DEPARTED": kBeaconDeparted,
              };
}

- (NSArray<NSString *> *)supportedEvents {
    return @[kBeaconSighted,
             kBeaconDeparted
             ];
}

- (void)startObserving {
    for (NSString *event in [self supportedEvents]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:event
                                                   object:nil];
    }
}

- (void)stopObserving {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

# pragma mark Public

+ (BOOL)application:(UIApplication *)application didSightBeacon:(NSString *)beaconID {
    [self postNotificationName:kBeaconSighted withPayload:beaconID];
    return YES;
}

+ (BOOL)application:(UIApplication *)application didDepartBeacon:(NSString *)beaconID {
    [self postNotificationName:kBeaconDeparted withPayload:beaconID];
    return YES;
}

# pragma mark Private

+ (void)postNotificationName:(NSString *)name withPayload:(NSObject *)object {
    NSDictionary<NSString *, id> *payload = @{@"payload": object};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:self
                                                      userInfo:payload];
}

- (void)handleNotification:(NSNotification *)notification {
    [self sendEventWithName:notification.name body:notification.userInfo];
}

@end
