// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// Displays a single image by url, auto fits it to scroll-view.
@interface PhotoViewController : UIViewController
@property (nonatomic, strong) NSURL *imageURL;
@end

NS_ASSUME_NONNULL_END
