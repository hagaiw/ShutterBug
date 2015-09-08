// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "RecentPhotosTableViewController.h"

#import "PhotoViewController.h"
#import "RecentPhotosFlickrGetter.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecentPhotosTableViewController ()
@end

@implementation RecentPhotosTableViewController


#pragma mark Overloaded methods
- (FlickrGetter *)flickrGetter {
  return [[RecentPhotosFlickrGetter alloc] init];
}


- (void)sortCellData {
  // Overload the sort cell data method to maintain the default chronological ordering.
}

#pragma mark

@end

NS_ASSUME_NONNULL_END
