// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "CellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CellData ()

/// Writable extensions of the value class's proeprties:
@property (strong, readwrite, nonatomic) NSString *section;
@property (strong, readwrite, nonatomic) NSString *cellText;
@property (strong, readwrite, nonatomic) NSString *cellDescription;

@end

@implementation CellData

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (instancetype)initWithSection:(NSString *)section
                       cellText:(NSString *)cellText
                cellDescription:(NSString *)cellDescription {
  if (self = [super init]) {
    self.section = section;
    self.cellText = cellText;
    self.cellDescription = cellDescription;
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
  if (self = [super init]) {
    self.section = [decoder decodeObjectForKey:@"section"];
    self.cellText = [decoder decodeObjectForKey:@"cellText"];
    self.cellDescription = [decoder decodeObjectForKey:@"cellDescription"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.section forKey:@"section"];
  [encoder encodeObject:self.cellText forKey:@"cellText"];
  [encoder encodeObject:self.cellDescription forKey:@"cellDescription"];
}

#pragma mark -
#pragma mark Sorting Methods
#pragma mark -

- (BOOL)isEqual:(id)object {
  CellData *otherCell = (CellData *)object;
  if (self.section && ![self.section isEqualToString:otherCell.section]) {
    return NO;
  }
  if (self.cellText && ![self.cellText isEqualToString:otherCell.cellText]) {
    return NO;
  }
  if (self.cellDescription && ![self.cellDescription isEqualToString:otherCell.cellDescription]) {
    return NO;
  }
  return YES;
}

- (NSComparisonResult)compare:(CellData *)otherObject {
  return [self.cellText compare:otherObject.cellText];
}

@end

NS_ASSUME_NONNULL_END