// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import <UIKit/UIKit.h>

#import "CellData.h"
#import "FlickrDownloader.h"

NS_ASSUME_NONNULL_BEGIN

// Abstract class. Represents a generic Table-View controller for a table-view with of subtitle-cells with sections.
@interface BaseTableViewController : UITableViewController

// Abstract method, converts returns the cell data object corresponding to the cell represented by
// indexPath.
- (CellData *)getCellDataFromIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) FlickrGetter *flickrGetter;

@end

NS_ASSUME_NONNULL_END

