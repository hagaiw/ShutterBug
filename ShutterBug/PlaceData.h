// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "CellData.h"

NS_ASSUME_NONNULL_BEGIN

/// Value class representing the data of a cell used in a \c UITableView depicting places.
@interface PlaceData : CellData

/// Value class initializer.
- (instancetype)initWithSection:(NSString * __nonnull)section
                       cellText:(NSString * __nonnull)cellText
                cellDescription:(NSString * __nonnull)cellDescription
                           name:(NSString *)name
                             ID:(NSString *)ID;

// The name of the place as received from flickr.
@property (strong, readonly, nonatomic) NSString *name;

// The Flickr-ID of the place.
@property (strong, readonly, nonatomic) NSString *ID;
@end

NS_ASSUME_NONNULL_END
