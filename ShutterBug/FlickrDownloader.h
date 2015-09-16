// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "FlickrGetter.h"
#import "PhotoData.h"
#import "PlaceData.h"

NS_ASSUME_NONNULL_BEGIN

/// Downloads and parses flickr meta data to create a data structure describing a Table-View
/// of recent photos.
@interface FlickrDownloader : NSObject <FlickrGetter>
@end

NS_ASSUME_NONNULL_END
