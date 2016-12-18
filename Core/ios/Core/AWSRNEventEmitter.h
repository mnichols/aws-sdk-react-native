//
//  AWSRNEventEmitter.h
//  Core
//
//  Created by Mike Nichols on 12/17/16.
//  Copyright © 2016 Amazon Web Services. All rights reserved.
//

#ifndef AWSRNEventEmitter_h
#define AWSRNEventEmitter_h

#import "RCTEventEmitter.h"
#import "RCTBridge.h"

@interface AWSRNEventEmitter : RCTEventEmitter <RCTBridgeModule>

+ (BOOL)application:(UIApplication *)application didSightBeacon:(NSString *)beaconID;
+ (BOOL)application:(UIApplication *)application didDepartBeacon:(NSString *)beaconID;

@end

#endif /* AWSRNEventEmitter_h */
