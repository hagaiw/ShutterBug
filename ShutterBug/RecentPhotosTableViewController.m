// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "RecentPhotosTableViewController.h"

#import "PhotoViewController.h"
#import "RecentPhotosFlickrGetter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RecentPhotosTableViewController

#pragma mark -
#pragma mark BaseTableViewController
#pragma mark -

- (id <FlickrGetter>)getFlickrGetter {
  return [[RecentPhotosFlickrGetter alloc] init];
}

- (NSDictionary *)sortedCellDataFromCellData:(NSDictionary *)cellData {
  return cellData;
}

@end

NS_ASSUME_NONNULL_END
