// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// An abstract data-structure that represents the data corresponding to a single cell in a  Table-View.
@interface CellData : NSObject <NSCoding>
@property (strong, nonatomic) NSString *section;
@property (strong, nonatomic) NSString *cellText;
@property (strong, nonatomic) NSString *cellDescription;
@end

NS_ASSUME_NONNULL_END
