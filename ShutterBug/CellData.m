// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "CellData.h"

NS_ASSUME_NONNULL_BEGIN

// A data structure representing a single table-view cell.
@implementation CellData

- (NSComparisonResult)compare:(CellData *)otherObject {
  return [self.cellText compare:otherObject.cellText];
}

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  self.section = [decoder decodeObjectForKey:@"section"];
  self.cellText = [decoder decodeObjectForKey:@"cellText"];
  self.cellDescription = [decoder decodeObjectForKey:@"cellDescription"];
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.section forKey:@"section"];
  [encoder encodeObject:self.cellText forKey:@"cellText"];
  [encoder encodeObject:self.cellDescription forKey:@"cellDescription"];
}

@end




NS_ASSUME_NONNULL_END
