// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PlacesTableViewController.h"

#import "PhotosAtPlaceTableViewController.h"
#import "PlaceData.h"
#import "TopPlacesFlickrDownloader.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlacesTableViewController

/// Name of segue to PhotoTableViewController.
static const NSString *kPlaceSelectionSegue = @"Place Selected";

/// Name of template cell to use.
static const NSString *kCellName = @"Data Cell";

#pragma mark -
#pragma mark BaseTableViewController
#pragma mark -

- (NSArray *)sectionTitlesFromCellsData:(NSDictionary *)cellsData {
  return [[cellsData allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSString *)identifierOfReusableCell {
  return (NSString *)kCellName;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue withCellData:(CellData *)cellData {
  if (![segue.identifier isEqualToString:(NSString *)kPlaceSelectionSegue]) {
    return;
  }
  PhotosAtPlaceTableViewController *photoTableViewController = [segue destinationViewController];
  PlaceData *place = (PlaceData *)cellData;
  photoTableViewController.title = place.cellText;
  photoTableViewController.place = place;
}

- (id <FlickrGetter>)flickrGetter {
  return [[TopPlacesFlickrDownloader alloc] init];
}
#pragma mark

@end

NS_ASSUME_NONNULL_END

