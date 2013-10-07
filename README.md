ArrayDataSource
===============

Implementation of a generic UITableViewDataSource that can be used to reduce the amount of code in UIViewControllers.

Inspired by the great article [lighter-view-controllers](http://www.objc.io/issue-1/lighter-view-controllers.html)

How to install it?
---------------

Just drag and drop the ROArrayDataSource folder on your project or use [cocoapods](http://cocoapods.org/)

How to use it?
---------------

Just set an instance of ROArrayDataSource as the dataSource of the table view.

```objective-c
- (void)setupTableViewDataSource
{
    self.dataSource = [[ROArrayDataSource alloc] initWithItems:self.data cellIdentifier:cellIdentifier configureCellBlock:^(CustomCell *cell, NSObject *object) {
        cell.label.text = [object description];
    }];
    self.tableView.dataSource = self.dataSource;
}
```
