// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotosAtPlaceTableViewController.h"

#import "PhotosAtPlaceFlickrDownloader.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotosAtPlaceTableViewController ()
@end

@implementation PhotosAtPlaceTableViewController

#pragma mark Overloaded methods
- (FlickrGetter *)flickrGetter {
  return [[PhotosAtPlaceFlickrDownloader alloc] initWithPlace:_place];
}
#pragma mark

@end

NS_ASSUME_NONNULL_END
