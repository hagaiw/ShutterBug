// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotosAtPlaceFlickrDownloader.h"

#import "FlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotosAtPlaceFlickrDownloader ()

/// The place to download photos for.
@property (strong, nonatomic) PlaceData *place;

@end

@implementation PhotosAtPlaceFlickrDownloader

/// Maximum number of photo-results to request for the given place.
const NSUInteger kMaxNumResults = 50;

/// Image title to show when no title is available.
const NSString *kDefaultImageTitle = @"Unknown";

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (instancetype)initWithPlace:(PlaceData *)place {
  if (self = [super init]) {
    self.place = place;
  }
  return self;
}

#pragma mark -
#pragma mark FlickrDownloader
#pragma mark -

- (NSURL *)downloadURL {
  return [FlickrFetcher URLforPhotosInPlace:self.place.ID maxResults:(int)kMaxNumResults];
}

- (CellData *)cellDataFromFlickrData:(NSDictionary *)flickrData{
  NSString *photoTitle = [flickrData valueForKeyPath:FLICKR_PHOTO_TITLE];
  NSString *photoDescription = [flickrData valueForKey:FLICKR_PHOTO_DESCRIPTION];
  NSURL *photoURL = [FlickrFetcher URLforPhoto:flickrData format:FlickrPhotoFormatLarge];
  NSString *section = @"";
  NSString *cellText = photoTitle ?: kDefaultImageTitle;
  PhotoData *photoData = [[PhotoData alloc] initWithSection:section cellText:cellText
                                            cellDescription:photoDescription title:photoTitle
                                           photoDescription:photoDescription url:photoURL];
  return photoData;
}

- (NSString *)dataDictKey {
  return FLICKR_RESULTS_PHOTOS;
}

@end

NS_ASSUME_NONNULL_END
