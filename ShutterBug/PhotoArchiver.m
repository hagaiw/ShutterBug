// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotoArchiver.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PhotoArchiver

NSString *const RecentPhotosKey = @"Recent Photos";
NSUInteger const maxRecentPhotos = 20;


#pragma mark Interface
- (NSArray *)getRecentPhotos{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSMutableArray *recentPhotos = [defaults objectForKey:RecentPhotosKey];
  NSMutableArray *recentPhotoDatas = [[NSMutableArray alloc] init];
  for (NSData *data in recentPhotos) {
    PhotoData *photoData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [recentPhotoDatas addObject:photoData];
  }
  return recentPhotoDatas;
}

- (void)addPhotoData:(PhotoData *)photoData {
  NSArray *recentPhotos = [self getRecentPhotos];
  recentPhotos = [self getPhotosArray:recentPhotos withAddedPhoto:photoData];
  [self addPhotosToArchive:recentPhotos];
}


#pragma mark Implementation
- (void)addPhotosToArchive:(NSArray *)photos {
  NSMutableArray *dataArray = [[NSMutableArray alloc] init];
  for (PhotoData *photo in photos) {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:photo];
    [dataArray addObject:data];
  }
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  [defaults setObject:dataArray forKey:RecentPhotosKey];
}

- (NSArray *)getPhotosArray:(NSArray *)photosArray withAddedPhoto:(PhotoData *)photoData {
  NSMutableArray *mutablePhotosArray = [photosArray mutableCopy];
  [self removeDuplicatesOfPhotoData:photoData fromArray:mutablePhotosArray];
  [mutablePhotosArray insertObject:photoData atIndex:0];
  NSArray *limitedPhotosArray = [self limitSizeOfArray:mutablePhotosArray];
  return limitedPhotosArray;
}

- (void)removeDuplicatesOfPhotoData:(PhotoData *)photoData fromArray:(NSMutableArray *)photosArray {
  BOOL existing = NO;
  PhotoData *currentPhotoData;
  for (currentPhotoData in photosArray) {
    if ([[photoData.url absoluteString] isEqualToString:[currentPhotoData.url absoluteString]]) {
      existing = YES;
      break;
    }
  }
  if (existing) {
    [photosArray removeObject:currentPhotoData];
  }
}

- (NSArray *)limitSizeOfArray:(NSMutableArray *)array {
  NSUInteger maxRange = MIN([array count], maxRecentPhotos);
  return [array subarrayWithRange:NSMakeRange(0, maxRange)];
}
#pragma mark

@end

NS_ASSUME_NONNULL_END
