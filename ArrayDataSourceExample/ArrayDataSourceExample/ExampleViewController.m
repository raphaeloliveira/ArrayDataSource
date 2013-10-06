//
//  ViewController.m
//  ArrayDataSourceExample
//
//  Created by Raphael Oliveira on 10/5/13.
//  Copyright (c) 2013 Raphael. All rights reserved.
//

#import "ExampleViewController.h"

#import "ExampleCell.h"
#import "ROArrayDataSource.h"

static NSString *cellIdentifier = @"ExampleCell";

@implementation ExampleViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self setupTableViewDataSource];
}

#pragma mark - Private

- (void)initData
{
    self.data = @[@"item 1", @"item 2", @"item 3"];
}

- (void)setupTableViewDataSource
{
    self.dataSource = [[ROArrayDataSource alloc] initWithItems:self.data cellIdentifier:cellIdentifier configureCellBlock:^(ExampleCell *cell, NSString *object) {
        cell.label.text = object;
    }];
    self.tableView.dataSource = self.dataSource;
}

@end
