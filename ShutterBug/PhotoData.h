// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "CellData.h"

NS_ASSUME_NONNULL_BEGIN

/// Value class representing the data of a cell used in a \c UITableView for depicting flickr
/// photos.
@interface PhotoData : CellData

/// Value class intializer.
- (instancetype)initWithSection:(NSString *)section
                       cellText:(NSString *)cellText
                cellDescription:(NSString *)cellDescription
                          title:(NSString *)title
               photoDescription:(NSString *)photoDescription
                            url:(NSURL *)url;

/// The photo's title, as received from flickr.
@property (strong, readonly, nonatomic) NSString *title;

/// The photo's description, as received from flickr.
@property (strong, readonly, nonatomic) NSString *photoDescription;

/// The photo's URL, as received from flickr.
@property (strong, readonly, nonatomic) NSURL *url;

@end

NS_ASSUME_NONNULL_END
