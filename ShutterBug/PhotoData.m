// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoData ()

/// Writable extensions of the value class's proeprties:
@property (strong, readwrite, nonatomic) NSString *title;
@property (strong, readwrite, nonatomic) NSString *photoDescription;
@property (strong, readwrite, nonatomic) NSURL *url;

@end

@implementation PhotoData

/// Encoding Keys:
static const NSString *TitleKey = @"title";
static const NSString *DescriptionKey = @"photoDescription";
static const NSString *URLKey = @"url";

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (instancetype)initWithSection:(NSString *)section
                       cellText:(NSString *)cellText
                cellDescription:(NSString *)cellDescription
                          title:(NSString *)title
               photoDescription:(NSString *)photoDescription
                            url:(NSURL *)url {
  if (self = [super initWithSection:section cellText:cellText cellDescription:cellDescription]) {
    self.title = title;
    self.photoDescription = photoDescription;
    self.url = url;
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super initWithCoder:decoder];
  if (!self) {
    return nil;
  }
  self.title = [decoder decodeObjectForKey:(NSString *)TitleKey];
  self.photoDescription = [decoder decodeObjectForKey:(NSString *)DescriptionKey];
  self.url = [decoder decodeObjectForKey:(NSString *)URLKey];
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [super encodeWithCoder:encoder];
  [encoder encodeObject:self.title forKey:(NSString *)TitleKey];
  [encoder encodeObject:self.photoDescription forKey:(NSString *)DescriptionKey];
  [encoder encodeObject:self.url forKey:(NSString *)URLKey];
}

#pragma mark -
#pragma mark Sorting Methods
#pragma mark -

- (BOOL)isEqual:(id)object {
  PhotoData *otherPhoto = (PhotoData *)object;
  if (![self.url isEqual:otherPhoto.url]) {
    return NO;
  }
  return [super isEqual:object];
}

@end

NS_ASSUME_NONNULL_END
