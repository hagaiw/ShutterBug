// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PlacesTableViewController.h"

#import "PhotosAtPlaceTableViewController.h"
#import "PlaceData.h"
#import "TopPlacesFlickrDownloader.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlacesTableViewController

/// Name of segue to PhotoTableViewController.
static const NSString *PlaceSelectionSegue = @"Place Selected";

/// Name of template cell to use.
static const NSString *CellName = @"Data Cell";

#pragma mark -
#pragma mark BaseTableViewController
#pragma mark -

- (NSArray *)sectionTitlesFromCellsData:(NSDictionary *)cellsData {
  return [[cellsData allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSString *)reusableCellName {
  return (NSString *)CellName;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue withCellData:(CellData *)cellData {
  if ([[segue identifier] isEqualToString:(NSString *)PlaceSelectionSegue]) {
    PhotosAtPlaceTableViewController *photoTableViewController = [segue destinationViewController];
    PlaceData *place = (PlaceData *)cellData;
    photoTableViewController.title = place.cellText;
    photoTableViewController.place = place;
  }
}

- (id <FlickrGetter>)getFlickrGetter {
  return [[TopPlacesFlickrDownloader alloc] init];
}
#pragma mark

@end

NS_ASSUME_NONNULL_END

