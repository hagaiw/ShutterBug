// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoData ()

/// The photo's title, as received from flickr.
@property (readwrite, nonatomic) NSString *title;

/// The photo's description, as received from flickr.
@property (readwrite, nonatomic) NSString *photoDescription;

/// The photo's URL, as received from flickr.
@property (readwrite, nonatomic) NSURL *url;

@end

@implementation PhotoData

/// Encoding key for the title parameter.
static const NSString *kTitleKey = @"title";

/// Encoding key for the description parameter.
static const NSString *kDescriptionKey = @"photoDescription";

/// Encoding key for the URL parameter.
static const NSString *kURLKey = @"url";

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (instancetype)initWithSection:(NSString *)section cellText:(NSString *)cellText
                cellDescription:(NSString *)cellDescription title:(NSString *)title
               photoDescription:(NSString *)photoDescription url:(NSURL *)url {
  if (self = [super initWithSection:section cellText:cellText cellDescription:cellDescription]) {
    self.title = title;
    self.photoDescription = photoDescription;
    self.url = url;
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.title = [decoder decodeObjectForKey:(NSString *)kTitleKey];
    self.photoDescription = [decoder decodeObjectForKey:(NSString *)kDescriptionKey];
    self.url = [decoder decodeObjectForKey:(NSString *)kURLKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [super encodeWithCoder:encoder];
  [encoder encodeObject:self.title forKey:(NSString *)kTitleKey];
  [encoder encodeObject:self.photoDescription forKey:(NSString *)kDescriptionKey];
  [encoder encodeObject:self.url forKey:(NSString *)kURLKey];
}

#pragma mark -
#pragma mark Sorting Methods
#pragma mark -

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[self class]]) {
    return NO;
  }
  PhotoData *otherPhoto = (PhotoData *)object;
  if (![self.url isEqual:otherPhoto.url]) {
    return NO;
  }
  return [super isEqual:object];
}

@end

NS_ASSUME_NONNULL_END
