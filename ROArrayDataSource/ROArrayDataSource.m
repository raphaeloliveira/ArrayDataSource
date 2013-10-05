//
//  ArrayDataSource.m
//  Yapo
//
//  Created by raphaeloliveira on 10/1/13.
//  Copyright (c) 2013 Schibsted. All rights reserved.
//

#import "ROArrayDataSource.h"

@implementation ROArrayDataSource

#pragma mark - Public

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(ConfigureCellBlock)configureCellBlock
{
    self = [super init];
    if (self) {
        _items = items;
        _cellIdentifier = cellIdentifier;
        _configureCellBlock = configureCellBlock;
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, [self itemAtIndexPath:indexPath]);
    }
    
    return cell;
}

#pragma mark - Private

- (NSObject *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.row];
}

@end
