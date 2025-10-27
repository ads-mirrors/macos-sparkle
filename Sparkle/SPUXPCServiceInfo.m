//
//  SUXPCServiceInfo.m
//  Sparkle
//
//  Created by Mayur Pawashe on 4/17/16.
//  Copyright © 2016 Sparkle Project. All rights reserved.
//

#import "SPUXPCServiceInfo.h"
#import "SUErrors.h"
#import "SUConstants.h"
#import "SUHost.h"

#include "AppKitPrevention.h"

BOOL SPUXPCServiceIsEnabled(NSString *enabledKey)
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    SUHost *mainBundleHost = [[SUHost alloc] initWithBundle:mainBundle];
    
    return [mainBundleHost boolForInfoDictionaryKey:enabledKey];
}

BOOL SPUHelperHasExecutablePermission(NSString *component, NSString * _Nullable __autoreleasing * _Nullable failureReason)
{
    NSBundle *sparkleBundle = [NSBundle bundleWithIdentifier:SUBundleIdentifier];
    NSURL *helperURL = [[sparkleBundle.bundleURL URLByAppendingPathComponent:component isDirectory:NO] URLByResolvingSymlinksInPath];
    
    NSNumber *isExecutableFile = nil;
    NSError *getResourceError = nil;
    if (![helperURL getResourceValue:&isExecutableFile forKey:NSURLIsExecutableKey error:&getResourceError]) {
        if (failureReason != NULL) {
            *failureReason = [NSString stringWithFormat:@"Failed to fetch info from file '%@' -- does this helper exist? %@", helperURL.path, getResourceError.localizedDescription];
        }
        
        return NO;
    }
    
    if (!isExecutableFile.boolValue) {
        if (failureReason != NULL) {
            *failureReason = [NSString stringWithFormat:@"The file '%@' is not considered an executable -- were the executable permissions lost during a bad file copy? Please ensure file permissions and symbolic links for Sparkle framework are preserved.", helperURL.path];
        }
        
        return NO;
    }
    
    return YES;
}

BOOL SPUXPCServiceHasExecutablePermission(NSString *serviceName, NSString * _Nullable __autoreleasing * _Nullable failureReason)
{
    NSString *componentName = [NSString stringWithFormat:@"XPCServices/%@.xpc/Contents/MacOS/%@", serviceName, serviceName];
    
    return SPUHelperHasExecutablePermission(componentName, failureReason);
}
