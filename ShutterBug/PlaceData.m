// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PlaceData.h"

NS_ASSUME_NONNULL_BEGIN
@interface PlaceData ()

/// Writable extensions of the value class's proeprties:
@property (strong, readwrite, nonatomic) NSString *name;
@property (strong, readwrite, nonatomic) NSString *ID;

@end

@implementation PlaceData

#pragma mark -
#pragma mark Initialization Methods
#pragma mark -

- (instancetype)initWithSection:(NSString * __nonnull)section
                       cellText:(NSString * __nonnull)cellText
                cellDescription:(NSString * __nonnull)cellDescription
                           name:(NSString *)name
                             ID:(NSString *)ID {
  self = [super initWithSection:section cellText:cellText cellDescription:cellDescription];
  self.name = name;
  self.ID = ID;
  
  return self;
}
@end

NS_ASSUME_NONNULL_END
