// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController ()

/// Section title's in order.
@property (strong, nonatomic)NSArray *sectionTitles;

/// Maps section-title to an \c NSArray of \c CellData
@property (strong, nonatomic)NSDictionary *tableData;

@end

@implementation BaseTableViewController

/// Name of the dispatch queue used to acquire table's data.
const char* queueName = "flickr fetcher";

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
  
  dispatch_queue_t fetchQ = dispatch_queue_create(queueName, NULL);
  dispatch_async(fetchQ, ^{
    self.tableData = [self.getFlickrGetter getTableData];
    [self sortCellData];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self initTableView];
      [self.refreshControl endRefreshing];
    });
  });
}

- (void)sortCellData {
  NSMutableDictionary *sectionToCells =
      [NSMutableDictionary dictionaryWithCapacity:self.tableData.count];
  for (NSString *title in self.tableData) {
    sectionToCells[title] = [ self.tableData[title] sortedArrayUsingSelector:@selector(compare:)];
  }
  self.tableData = sectionToCells;
}

- (void)initTableView {
  self.sectionTitles = [self sectionTitlesFromCellsData:_tableData];
  [self.tableView reloadData];
}

- (CellData *)cellDataFromIndexPath:(NSIndexPath *)indexPath {
  NSString *sectionTitle = self.sectionTitles[indexPath.section];
  CellData *cellData = self.tableData[sectionTitle][indexPath.row];
  return cellData;
}

#pragma mark -
#pragma mark UITableViewController
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)sender
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[self reusableCellName]
                                                               forIndexPath:indexPath];
  CellData *cellData = [self getCellDataFromIndexPath:indexPath];
  cell.textLabel.text = cellData.cellText;
  cell.detailTextLabel.text = cellData.cellDescription;
  
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)sender {
  return [_sectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [_sectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSString *sectionTitle = [_sectionTitles objectAtIndex:section];
  return [_tableData[sectionTitle] count];
}


- (CellData *)getCellDataFromIndexPath:(NSIndexPath *)indexPath {
  NSString *section = [_sectionTitles objectAtIndex:indexPath.section];
  NSArray *sectionCells = [_tableData objectForKey:section];
  CellData *cellData = [sectionCells objectAtIndex:indexPath.row];
  return cellData;
}

#pragma mark -
#pragma mark Abstract methods
#pragma mark -

- (UITableViewCell *)getCellforIndexPath:(NSIndexPath __unused *)indexPath cellData:(CellData *)cellData {
  assert(NO);
}
- (NSArray *)sectionTitlesFromCellsData:(NSDictionary __unused *)cellsData {
  assert(NO);
}
- (void)prepareForSegue:(UIStoryboardSegue __unused *)segue
           withCellData:(CellData __unused *)cellData {
  assert(NO);
}
- (NSString *)reusableCellName {
  assert(NO);
}
- (id <FlickrGetter>)getFlickrGetter {
  assert(NO);
}
@end

NS_ASSUME_NONNULL_END
