// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "CellData.h"

NS_ASSUME_NONNULL_BEGIN

// An abstract data-structure that represents the data corresponding to a single cell in a places Table-View.
@interface PlaceData : CellData
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ID;
@end

NS_ASSUME_NONNULL_END
