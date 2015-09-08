// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PhotoData

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super initWithCoder:decoder];
  if (!self) {
    return nil;
  }
  self.title = [decoder decodeObjectForKey:@"title"];
  self.photoDescription = [decoder decodeObjectForKey:@"photoDescription"];
  self.url = [decoder decodeObjectForKey:@"url"];
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [super encodeWithCoder:encoder];
  [encoder encodeObject:self.title forKey:@"title"];
  [encoder encodeObject:self.photoDescription forKey:@"photoDescription"];
  [encoder encodeObject:self.url forKey:@"url"];
}

@end

NS_ASSUME_NONNULL_END
