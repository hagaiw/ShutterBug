// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "RecentPhotosFlickrGetter.h"

#import "PhotoArchiver.h"
#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RecentPhotosFlickrGetter

#pragma mark -
#pragma mark FlickrGetter
#pragma mark -

- (NSDictionary *)getTableData {
  PhotoArchiver *archiver = [[PhotoArchiver alloc] init];
  return [[NSDictionary alloc] initWithObjectsAndKeys:[archiver getRecentPhotos], @"Unknown", nil];
}

@end

NS_ASSUME_NONNULL_END
