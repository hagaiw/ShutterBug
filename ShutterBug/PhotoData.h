// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "CellData.h"

NS_ASSUME_NONNULL_BEGIN

// An abstract data-structure that represents the data corresponding to a single cell in a photos Table-View.
@interface PhotoData : CellData
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *photoDescription;
@property (strong, nonatomic) NSURL *url;
@end

NS_ASSUME_NONNULL_END
