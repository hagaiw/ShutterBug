// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController ()

/// Section titles in order of display.
@property (strong, nonatomic) NSArray *sectionTitles;

/// Dictionary maping section titles to \c NSArrays of \c CellData
@property (strong, nonatomic) NSDictionary *tableData;

@end

@implementation BaseTableViewController

/// Name of the dispatch queue used to acquire table's data.
static NSString * const kQueueName = @"flickr fetcher";

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateCellData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
  CellData *cellData = [self cellDataFromIndexPath:indexPath];
  [self prepareForSegue:segue withCellData:cellData];
}

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (IBAction)updateCellData {
  [self.refreshControl beginRefreshing];
  
  dispatch_queue_t fetchQueue = dispatch_queue_create([kQueueName UTF8String], NULL);
  dispatch_async(fetchQueue, ^{
    self.tableData = [self.flickrGetter getTableData];
    self.tableData = [self sortedCellDataFromCellData:self.tableData];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self updateTableView];
      [self.refreshControl endRefreshing];
    });
  });
}

- (NSDictionary *)sortedCellDataFromCellData:(NSDictionary *)cellData {
  NSMutableDictionary *sectionToCells =
      [NSMutableDictionary dictionaryWithCapacity:cellData.count];
  for (NSString *title in [cellData allKeys]) {
    sectionToCells[title] = [cellData[title] sortedArrayUsingSelector:@selector(compare:)];
  }
  return sectionToCells;
}

- (void)updateTableView {
  self.sectionTitles = [self sectionTitlesFromCellsData:self.tableData];
  [self.tableView reloadData];
}

- (CellData *)cellDataFromIndexPath:(NSIndexPath *)indexPath {
  NSString *sectionTitle = self.sectionTitles[indexPath.section];
  return self.tableData[sectionTitle][indexPath.row];
}

#pragma mark -
#pragma mark UITableViewController
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)sender
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView
                             dequeueReusableCellWithIdentifier:[self identifierOfReusableCell]
                                                  forIndexPath:indexPath];
  CellData *cellData = [self getCellDataFromIndexPath:indexPath];
  cell.textLabel.text = cellData.cellText;
  cell.detailTextLabel.text = cellData.cellDescription;
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)sender {
  return [self.sectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [self.sectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSString *sectionTitle = [self.sectionTitles objectAtIndex:section];
  return [self.tableData[sectionTitle] count];
}

- (CellData *)getCellDataFromIndexPath:(NSIndexPath *)indexPath {
  NSString *section = [self.sectionTitles objectAtIndex:indexPath.section];
  NSArray *sectionCells = [self.tableData objectForKey:section];
  return [sectionCells objectAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark Abstract methods
#pragma mark -

- (NSArray *)sectionTitlesFromCellsData:(NSDictionary __unused *)cellsData {
  assert(NO);
}

- (void)prepareForSegue:(UIStoryboardSegue __unused *)segue
           withCellData:(CellData __unused *)cellData {
  assert(NO);
}

- (NSString *)identifierOfReusableCell {
  assert(NO);
}

- (id<FlickrGetter>)flickrGetter {
  assert(NO);
}

@end

NS_ASSUME_NONNULL_END
