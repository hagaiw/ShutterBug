// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// A protocol for classes that parse flickr meta-data to create a dictionary that maps
/// sections to cell-arrays.
@protocol FlickrGetter <NSObject>

/// Returns a dictionary mapping section titles to arrays of \c CellData objects.
- (NSDictionary *)getTableData;

@end

NS_ASSUME_NONNULL_END
