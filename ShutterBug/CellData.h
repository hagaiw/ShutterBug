// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// A value class. Contains the data corresponding to a single cell in a \c UITableView.
/// The Method isEquals checks if all value strings (section, cellText, cellDescription) match.
@interface CellData : NSObject <NSCoding>

/// Initializes with the given \c section, \c cellText and \c cellDescription.
- (instancetype)initWithSection:(NSString *)section
                       cellText:(NSString *)cellText
                cellDescription:(NSString *)cellDescription;

/// Returns the result of the comparison between this instance and the given \c cellData by
/// comparing the \c cellText properties of the involved instances. The order is alpha-numerically
/// increasing.
- (NSComparisonResult)compare:(CellData *)cellData;

/// The name of the \c UITableView section to which the cell belongs.
@property (readonly, nonatomic) NSString *section;

/// The cell-title's text.
@property (readonly, nonatomic) NSString *cellText;

/// The cell-subtitle's text.
@property (readonly, nonatomic) NSString *cellDescription;

@end

NS_ASSUME_NONNULL_END
