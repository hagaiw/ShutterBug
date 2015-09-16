// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// A value class. Contains the data corresponding to a single cell in a \c UITableView.
@interface CellData : NSObject <NSCoding>

/// Intialize value class with paramters.
- (instancetype)initWithSection:(NSString *)section
                       cellText:(NSString *)cellText
                cellDescription:(NSString *)cellDescription;

/// Alphanumerically increasing comparison according to \c cellText.
- (NSComparisonResult)compare:(CellData *)otherObject;

/// Check if all value strings (section, cellText, cellDescription) match.
- (BOOL)isEqual:(id)object;

/// The name of the \c UITableView section the cell resides under.
@property (strong, readonly, nonatomic) NSString *section;

/// The cell-title's text.
@property (strong, readonly, nonatomic) NSString *cellText;

/// The cell-subtitle's text.
@property (strong, readonly, nonatomic) NSString *cellDescription;

@end

NS_ASSUME_NONNULL_END
