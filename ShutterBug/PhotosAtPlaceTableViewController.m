// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotosAtPlaceTableViewController.h"

#import "PhotosAtPlaceFlickrDownloader.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PhotosAtPlaceTableViewController

#pragma mark -
#pragma mark BaseTableViewController
#pragma mark -

- (id<FlickrGetter>)getFlickrGetter {
  return [[PhotosAtPlaceFlickrDownloader alloc] initWithPlace:self.place];
}
#pragma mark

@end

NS_ASSUME_NONNULL_END
