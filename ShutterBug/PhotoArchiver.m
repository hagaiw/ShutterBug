// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotoArchiver.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PhotoArchiver

/// \c NSDefaults key for recent photos.
static NSString * const kRecentPhotosKey = @"Recent Photos";

/// Maximum number of recent photos to store in \C NSUserDefaults.
static NSUInteger const kMaxRecentPhotos = 20;

#pragma mark -
#pragma mark Interface
#pragma mark -

- (NSArray *)recentPhotos {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSMutableArray *recentPhotos = [defaults objectForKey:kRecentPhotosKey];
  NSMutableArray *recentPhotoDatas = [NSMutableArray arrayWithCapacity:recentPhotos.count];
  for (NSData *data in recentPhotos) {
    [recentPhotoDatas addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
  }
  return recentPhotoDatas;
}

- (void)addPhotoData:(PhotoData *)photoData {
  NSArray *recentPhotos = [self recentPhotos];
  recentPhotos = [self getPhotosArray:recentPhotos withAddedPhoto:photoData];
  [self addPhotosToArchive:recentPhotos];
}

#pragma mark -
#pragma mark Implementation
#pragma mark -

- (void)addPhotosToArchive:(NSArray *)photos {
  NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:photos.count];
  for (PhotoData *photo in photos) {
    [dataArray addObject:[NSKeyedArchiver archivedDataWithRootObject:photo]];
  }
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  [defaults setObject:dataArray forKey:kRecentPhotosKey];
}

- (NSArray *)getPhotosArray:(NSArray *)photosArray withAddedPhoto:(PhotoData *)photoData {
  NSMutableArray *newPhotosArray = [photosArray mutableCopy];
  [newPhotosArray insertObject:photoData atIndex:0];
  NSArray *uniquePhotosArray = [[NSOrderedSet orderedSetWithArray:newPhotosArray] array];
  
  NSUInteger maxRange = MIN([uniquePhotosArray count], kMaxRecentPhotos);
  return [uniquePhotosArray subarrayWithRange:NSMakeRange(0, maxRange)];
}

@end

NS_ASSUME_NONNULL_END
