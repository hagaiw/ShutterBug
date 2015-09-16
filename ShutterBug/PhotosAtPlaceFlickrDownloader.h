// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "FlickrDownloader.h"
#import "PlaceData.h"

NS_ASSUME_NONNULL_BEGIN

/// Downloads and parses flickr meta data to create a data structure describing a
/// Table-View of photos at a place.
@interface PhotosAtPlaceFlickrDownloader : FlickrDownloader
- (instancetype)initWithPlace:(PlaceData *)place;
@end

NS_ASSUME_NONNULL_END
