//
//  ViewController.h
//  ArrayDataSourceExample
//
//  Created by Raphael Oliveira on 10/5/13.
//  Copyright (c) 2013 Raphael. All rights reserved.
//

#import "ROArrayDataSource.h"

@class ROArrayDataSource;

#include <UIKit/UIKit.h>

@interface ExampleViewController : UIViewController

@property (strong, nonatomic) ROArrayDataSource *dataSource;
@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
