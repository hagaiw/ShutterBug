// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotoTableViewController.h"

#import "PhotoArchiver.h"
#import "PhotosAtPlaceFlickrDownloader.h"
#import "PhotoViewController.h"

NS_ASSUME_NONNULL_BEGIN



@implementation PhotoTableViewController

NSString *const PhotoSelectionSegue = @"Photo Selected";
NSString *const PhotoCellName = @"Photo Cell";

#pragma mark Overloaded methods

- (NSArray *)sectionTitlesFromCellsData:(NSDictionary *)cellsData {
  return [[cellsData allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSString *)reusableCellName {
  return PhotoCellName;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UINavigationController *navDetail = self.splitViewController.viewControllers[1];
  if(!navDetail) {
    return;
  }
  PhotoViewController *photoViewcontroller = navDetail.viewControllers[0];
  PhotoData *photoData = (PhotoData *)[self getCellDataFromIndexPath:indexPath];
  photoViewcontroller.imageURL = photoData.url;
  [self updateViewController:photoViewcontroller fromCellData:photoData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue
           withCellData:(CellData *)cellData {
  if ([[segue identifier] isEqualToString:PhotoSelectionSegue])
  {
    PhotoViewController *photoViewController = [segue destinationViewController];
    PhotoData *photoData = (PhotoData *)cellData;
    [self updateViewController:photoViewController fromCellData:photoData];
  }
}

- (void)updateViewController:(PhotoViewController *)photoVC fromCellData:(PhotoData *)photoData {
  photoVC.imageURL = photoData.url;
  photoVC.title = photoData.cellText;
  PhotoArchiver *archiver = [[PhotoArchiver alloc] init];
  [archiver addPhotoData:photoData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return nil;
}

#pragma mark

@end

NS_ASSUME_NONNULL_END
