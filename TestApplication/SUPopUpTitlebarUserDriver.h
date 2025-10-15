//
//  SUPopUpTitlebarUserDriver.h
//  Sparkle
//
//  Created by Mayur Pawashe on 3/5/16.
//  Copyright © 2016 Sparkle Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Sparkle/Sparkle.h>

@class NSWindow;
@class SUPopUpTitlebarUserDriver;

NS_ASSUME_NONNULL_BEGIN

@protocol SUPopUpTitlebarUserDriverDelegate <NSObject>

- (BOOL)userDriver:(SUPopUpTitlebarUserDriver *)userDriver shouldShowFoundUpdate:(SUAppcastItem *)updateItem state:(SPUUserUpdateState *)state;

@end

SPU_OBJC_DIRECT_MEMBERS @interface SUPopUpTitlebarUserDriver : NSObject <SPUUserDriver>

- (instancetype)initWithWindow:(nullable NSWindow *)window delegate:(id<SUPopUpTitlebarUserDriverDelegate>)delegate;

@property (nonatomic, nullable) NSWindow *window;

- (void)dismissPresentedUpdate;

@end

NS_ASSUME_NONNULL_END
