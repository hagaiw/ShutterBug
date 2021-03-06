// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "FlickrDownloader.h"

#import "FlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@implementation FlickrDownloader

#pragma mark -
#pragma mark FlickrGetter methods
#pragma mark -

- (NSDictionary *)getTableData {
  NSURL *flickrDownloadURL = [self downloadURL];
  NSDictionary *flickrData = [self getFlickrDataFromURL:flickrDownloadURL];
  NSMutableDictionary *tableData = [[NSMutableDictionary alloc] init];
  NSArray *cellDataArray = [self cellDataArrayFromFlickrData:flickrData];
  for (CellData *cellData in cellDataArray) {
    tableData[cellData.section] = [self cellsForCellData:cellData inTableData:tableData];
  }
  return tableData;
}

#pragma mark -
#pragma mark Parsing methods
#pragma mark -

- (NSDictionary *)getFlickrDataFromURL:(NSURL *)url {
  NSData *jsonResults = [NSData dataWithContentsOfURL:url];
  NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults options:0
                                                                        error:NULL];
  return propertyListResults;
}

- (NSArray *)cellDataArrayFromFlickrData:(NSDictionary *)flickrData {
  NSMutableArray *cellDataArray = [NSMutableArray arrayWithCapacity:flickrData.count];
  NSArray* flickrDataArray = [flickrData valueForKeyPath:[self dataDictKey]];
  for (NSDictionary *flickrData in flickrDataArray) {
    [cellDataArray addObject:[self cellDataFromFlickrData:flickrData]];
  }
  return cellDataArray;
}

- (NSArray *)cellsForCellData:(CellData *)cellData inTableData:(NSDictionary *)tableData {
  NSArray *cells = tableData[cellData.section];
  return !cells ? @[cellData] : [cells arrayByAddingObject:cellData];
}

#pragma mark -
#pragma mark Abstract methods
#pragma mark -

- (NSURL *)downloadURL {
  assert(NO);
}
- (CellData *)cellDataFromFlickrData:(NSDictionary *)flickrData{
  assert(NO);
}
- (NSString *)dataDictKey {
  assert(NO);
}

@end

NS_ASSUME_NONNULL_END

