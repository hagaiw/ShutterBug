// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotoTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

/// A \c UITableViewController of photos at a place.
@interface PhotosAtPlaceTableViewController : PhotoTableViewController

/// The place where all of the presented photos were taken at.
@property (strong, nonatomic) PlaceData *place;

@end

NS_ASSUME_NONNULL_END
