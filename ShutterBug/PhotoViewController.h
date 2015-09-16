// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// View controller displaying an image in a \c UIScrollView. The image is retrieved from a given
/// URL and initially aspect-fills the scroll view.
@interface PhotoViewController : UIViewController

/// URL of the image to be displayed.
@property (nonatomic, strong) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
