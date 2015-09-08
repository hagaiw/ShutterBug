// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Abstract class. Parses flickr meta data to create a data structure describing a Table-View with sections.
@interface FlickrGetter : NSObject

// returns a dictionary representing all table data. keys are section-titles and values are
// (CellData *) array.
- (NSDictionary *)getTableData;
@end

NS_ASSUME_NONNULL_END
