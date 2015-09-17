// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import <UIKit/UIKit.h>

#import "CellData.h"
#import "FlickrDownloader.h"

NS_ASSUME_NONNULL_BEGIN

/// Abstract class. Represents a generic Table-View controller for a table-view with of
/// subtitle-cells with sections.
@interface BaseTableViewController : UITableViewController

/// Abstract method. Returns the data of the cell at the given \c indexPath.
- (CellData *)cellDataFromIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

