// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PlacesTableViewController.h"

#import "PhotosAtPlaceTableViewController.h"
#import "PlaceData.h"
#import "TopPlacesFlickrDownloader.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlacesTableViewController ()
@end

@implementation PlacesTableViewController

NSString *const PlaceSelectionSegue = @"Place Selected";
NSString *const CellName = @"Data Cell";


#pragma mark Overloaded methods
- (NSArray *)sectionTitlesFromCellsData:(NSDictionary *)cellsData{
  return [[cellsData allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSString *)reusableCellName {
  return CellName;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue withCellData:(CellData *)cellData {
  if ([[segue identifier] isEqualToString:PlaceSelectionSegue])
  {
    PhotosAtPlaceTableViewController *photoTableViewController = [segue destinationViewController];
    
    PlaceData *place = (PlaceData *)cellData;
    photoTableViewController.title = place.cellText;
    photoTableViewController.place = place;
  }
}

- (FlickrGetter *)flickrGetter {
  FlickrGetter *flickrGetter = [[TopPlacesFlickrDownloader alloc] init];
  return flickrGetter;
}
#pragma mark

@end

NS_ASSUME_NONNULL_END

