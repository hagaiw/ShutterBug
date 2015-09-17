// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "CellData.h"

NS_ASSUME_NONNULL_BEGIN

/// Value class representing the data of a cell used in a \c UITableView depicting places.
@interface PlaceData : CellData

/// Initializes with the give \c section, \c cellText, \c cellDescription, \c name and \c ID.
- (instancetype)initWithSection:(NSString *)section cellText:(NSString *)cellText
                cellDescription:(NSString *)cellDescription name:(NSString *)name
                             ID:(NSString *)ID;

// The name of the place as received from flickr.
@property (readonly, nonatomic) NSString *name;

// The Flickr-ID of the place.
@property (readonly, nonatomic) NSString *ID;

@end

NS_ASSUME_NONNULL_END
