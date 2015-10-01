// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "TopPlacesFlickrDownloader.h"

#import "FlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TopPlacesFlickrDownloader

/// Separator to split location string by when stripped output is required.
static NSString *const kLocationSeparatorWithStrip = @", ";

/// Separator to split location string by when no stripping is required.
static NSString *const kLocationSeparator = @",";

#pragma mark -
#pragma mark Flickr Downloader methods
#pragma mark -

- (NSURL *)downloadURL {
  return [FlickrFetcher URLforTopPlaces];
}

- (CellData *)cellDataFromFlickrData:(NSDictionary *)flickrData{
  NSString *locationName = [flickrData valueForKeyPath:FLICKR_PLACE_NAME];
  NSString *locationID = [flickrData valueForKey:FLICKR_PLACE_ID];
  NSString *country = [self countryFromLocation:locationName];
  return [[PlaceData alloc] initWithSection:country
                                   cellText:[self mostDetailedPartOfLocation:locationName]
                            cellDescription:[self regionFromLocation:locationName]
                                       name:locationName ID:locationID];
}

- (NSString *)dataDictKey {
  return FLICKR_RESULTS_PLACES;
}

#pragma mark -
#pragma mark Parsing methods
#pragma mark -

- (NSString *)countryFromLocation:(NSString *)location {
  return [[location componentsSeparatedByString:kLocationSeparatorWithStrip] lastObject];
}

- (NSString *)mostDetailedPartOfLocation:(NSString *)location {
  return [[location componentsSeparatedByString:kLocationSeparatorWithStrip] firstObject];
}

- (NSString *)regionFromLocation:(NSString *)location {
  NSArray *splitRegion = [location componentsSeparatedByString:kLocationSeparator];
  NSRange range = NSMakeRange(1, [splitRegion count] - 2);
  NSArray *splitRegionWithoutCountry = [splitRegion subarrayWithRange:range];
  return [splitRegionWithoutCountry componentsJoinedByString:kLocationSeparator];
}

@end

NS_ASSUME_NONNULL_END
