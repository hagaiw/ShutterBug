// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotoTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

// Represents a BaseTableViewController of photos at place.
@interface PhotosAtPlaceTableViewController : PhotoTableViewController
@property (strong, nonatomic) PlaceData *place;
@end

NS_ASSUME_NONNULL_END
