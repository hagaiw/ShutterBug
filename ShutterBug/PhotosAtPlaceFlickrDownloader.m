// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotosAtPlaceFlickrDownloader.h"

#import "FlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PhotosAtPlaceFlickrDownloader

NSUInteger const MaxNumResults = 50;

#pragma mark Initialization
- (instancetype)initWithPlace:(PlaceData *)place {
  self = [super init];
  self.place = place;
  return self;
}

#pragma mark Overloaded methods
- (NSURL *)getDownloadURL {
  return [FlickrFetcher URLforPhotosInPlace:_place.ID maxResults:(int)MaxNumResults];
}

- (CellData *)cellDataFromFlickrData:(NSDictionary *)flickrData{
  NSString *photoTitle = [flickrData valueForKeyPath:FLICKR_PHOTO_TITLE];
  NSString *photoDescription = [flickrData valueForKey:FLICKR_PHOTO_DESCRIPTION];
  NSURL *photoURL = [FlickrFetcher URLforPhoto:flickrData format:FlickrPhotoFormatLarge];
  PhotoData *photoData = [[PhotoData alloc] init];
  photoData.title = photoTitle;
  photoData.photoDescription = photoDescription;
  photoData.url = photoURL;
  [self setPhotoData:photoData fromTitle:photoTitle andDescription:photoDescription];
  return photoData;
}

- (NSString *)getDataDictKey {
  return FLICKR_RESULTS_PHOTOS;
}

#pragma mark Implementation.
- (void)setPhotoData:(PhotoData *)photoData fromTitle:(NSString *)title andDescription:(NSString *)description {
  if(title && ![title isEqualToString:@""]) {
    photoData.cellText = title;
    photoData.cellDescription = description;
  } else if(description) {
    photoData.cellText = description;
    photoData.cellDescription = @"";
  } else {
    photoData.cellText = @"Unknown";
    photoData.cellDescription = @"";
  }
  photoData.section = @"";
}


@end

NS_ASSUME_NONNULL_END
