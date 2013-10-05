//
//  ArrayDataSource.h
//  Yapo
//
//  Created by raphaeloliveira on 10/1/13.
//  Copyright (c) 2013 Schibsted. All rights reserved.
//

@import Foundation;

typedef void (^ConfigureCellBlock)(id cell, id object);

@interface ROArrayDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray *items;
@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) ConfigureCellBlock configureCellBlock;

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(ConfigureCellBlock)configureCellBlock;

@end
