// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Hagai Weinfeld.

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController ()
@property (strong, nonatomic)NSArray *sectionTitles;
@property (strong, nonatomic)NSDictionary *tableData;
@end

@implementation BaseTableViewController


const char* queueName = "flickr fetcher";

#pragma mark UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateCellData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
  CellData *cellData = [self cellDataFromIndexPath:indexPath];
  [self prepareForSegue:segue withCellData:cellData];
}


#pragma mark Initialization

- (IBAction)updateCellData {
  [self.refreshControl beginRefreshing];
  
  dispatch_queue_t fetchQ = dispatch_queue_create(queueName, NULL);
  dispatch_async(fetchQ, ^{
    self.tableData = [self.flickrGetter getTableData];
    [self sortCellData];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self initTableView];
      [self.refreshControl endRefreshing];
    });
  });
}

- (void)sortCellData {
  NSMutableDictionary *sectionToCellsDict = [[NSMutableDictionary alloc] init];
  for (NSString *title in _tableData) {
    sectionToCellsDict[title] = [ _tableData[title] sortedArrayUsingSelector:@selector(compare:)];
  }
  _tableData = sectionToCellsDict;
}

- (void)initTableView {
  _sectionTitles = [self sectionTitlesFromCellsData:_tableData];
  [self.tableView reloadData];
}

- (CellData *)cellDataFromIndexPath:(NSIndexPath *)indexPath {
  NSString *sectionTitle = _sectionTitles[indexPath.section];
  CellData *cellData = _tableData[sectionTitle][indexPath.row];
  return cellData;
}

#pragma mark UITableViewController

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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
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


#pragma mark Abstract methods

- (UITableViewCell *)getCellforIndexPath:(NSIndexPath *)indexPath cellData:(CellData *)cellData {
  assert(NO);
}
- (NSArray *)sectionTitlesFromCellsData:(NSDictionary *)cellsData {
  assert(NO);
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue
           withCellData:(CellData *)cellData {
  assert(NO);
}
- (NSString *)reusableCellName {
  assert(NO);
}
- (FlickrGetter *)flickrGetter {
  assert(NO);
}
@end

NS_ASSUME_NONNULL_END
