// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotoTableViewController.h"

#import "PhotoArchiver.h"
#import "PhotosAtPlaceFlickrDownloader.h"
#import "PhotoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PhotoTableViewController

/// Name of segue to \c PhotoViewController.
static const NSString *kPhotoSelectionSegue = @"Photo Selected";

/// Name of template \c UITableView cell to use.
static const NSString *kPhotoCellName = @"Photo Cell";

/// ID of the detail view controller of the \c SplitViewController.
static const NSInteger kSplitViewControllerDetailID = 1;

/// ID of the \c PhotoViewController under the \c NavigationViewController.
static const NSInteger kPhotoViewControllerNavigationID = 0;

#pragma mark -
#pragma mark BaseTableViewController
#pragma mark -

- (NSArray *)sectionTitlesFromCellsData:(NSDictionary *)cellsData {
  return [[cellsData allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSString *)identifierOfReusableCell {
  return (NSString *)kPhotoCellName;
}

- (void)updateViewController:(PhotoViewController *)photoVC fromCellData:(PhotoData *)photoData {
  photoVC.imageURL = photoData.url;
  photoVC.title = photoData.cellText;
  PhotoArchiver *archiver = [[PhotoArchiver alloc] init];
  [archiver addPhotoData:photoData];
}

#pragma mark -
#pragma mark UITableViewController
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UINavigationController *navDetail =
      self.splitViewController.viewControllers[kSplitViewControllerDetailID];
  
  if(!navDetail) {
    return;
  }
  PhotoViewController *photoViewController =
      navDetail.viewControllers[kPhotoViewControllerNavigationID];
  PhotoData *photoData = (PhotoData *)[self cellDataFromIndexPath:indexPath];
  photoViewController.imageURL = photoData.url;
  [self updateViewController:photoViewController fromCellData:photoData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return nil;
}

#pragma mark -
#pragma mark UIView
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue
           withCellData:(CellData *)cellData {
  if (![[segue identifier] isEqualToString:(NSString *)kPhotoSelectionSegue]) {
    return;
  }
  PhotoViewController *photoViewController = [segue destinationViewController];
  PhotoData *photoData = (PhotoData *)cellData;
  [self updateViewController:photoViewController fromCellData:photoData];
}

@end

NS_ASSUME_NONNULL_END
