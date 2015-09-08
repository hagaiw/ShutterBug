// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "TopPlacesFlickrDownloader.h"

#import "FlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TopPlacesFlickrDownloader

NSString *const LocationSeparatorWithStrip = @", ";
NSString *const LocationSeparator = @",";


#pragma mark Overloaded methods
- (NSURL *)getDownloadURL {
  return [FlickrFetcher URLforTopPlaces];
}

- (CellData *)cellDataFromFlickrData:(NSDictionary *)flickrData{
  NSString *locationName = [flickrData valueForKeyPath:FLICKR_PLACE_NAME];
  NSString *locationID = [flickrData valueForKey:FLICKR_PLACE_ID];
  NSString *country = [self countryFromLocation:locationName];
  PlaceData *location = [[PlaceData alloc] init];
  location.name = locationName;
  location.ID = locationID;
  location.cellText = [self mostDetailedPartOfLocation:location.name];
  location.cellDescription = [self regionFromLocation:location.name];
  location.section = country;
  return location;
}

- (NSString *)getDataDictKey {
  return FLICKR_RESULTS_PLACES;
}

#pragma mark Parsing methods
- (NSString *)countryFromLocation:(NSString *)location {
  return [[location componentsSeparatedByString:LocationSeparatorWithStrip] lastObject];
}

- (NSString *)mostDetailedPartOfLocation:(NSString *)location {
  return [[location componentsSeparatedByString:LocationSeparatorWithStrip] firstObject];
}

- (NSString *)regionFromLocation:(NSString *)location {
  NSArray *splitRegion = [location componentsSeparatedByString:LocationSeparator];
  NSRange range = NSMakeRange(1, [splitRegion count] - 2);
  NSArray *splitRegionWithoutCountry = [splitRegion subarrayWithRange:range];
  return [splitRegionWithoutCountry componentsJoinedByString:LocationSeparator];
}
#pragma mark
@end

NS_ASSUME_NONNULL_END
