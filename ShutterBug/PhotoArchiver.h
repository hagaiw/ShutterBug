// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import <Foundation/Foundation.h>

#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

/// Object for archiving/de-archiving photo data to/from \c NSUserDefaults.
@interface PhotoArchiver : NSObject

/// Returns a list of photo-data objects representing the most recent photos accessed in a
/// chronological order
- (NSArray *)getRecentPhotos;

/// Adds the given photo-data object to the archive.
- (void)addPhotoData:(PhotoData *)photoData;

@end

NS_ASSUME_NONNULL_END
