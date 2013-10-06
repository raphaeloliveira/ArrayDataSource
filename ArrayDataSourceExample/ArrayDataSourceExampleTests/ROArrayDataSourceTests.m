//
//  ArrayDataSourceTests.m
//  Yapo
//
//  Created by raphaeloliveira on 10/1/13.
//  Copyright (c) 2013 Schibsted. All rights reserved.
//

#define MOCKITO_SHORTHAND
#define HC_SHORTHAND

#import "ROArrayDataSource.h"
#import "OCHamcrest.h"
#import "OCMockito.h"

@import XCTest;

@interface ROArrayDataSourceTests : XCTestCase
{
    ROArrayDataSource *sut;
}

@end

@implementation ROArrayDataSourceTests

#pragma mark - XCTestCase

- (void)setUp
{
    [super setUp];
    sut = [ROArrayDataSource new];
}

#pragma mark - Tests

- (void)testSutShouldConformsToUITableViewDataSourceProtocol
{
    assertThatBool([sut conformsToProtocol:@protocol(UITableViewDataSource)], equalToBool(YES));
}

- (void)testSutShouldRespondToTableViewNumberOfRowsInSection
{
    assertThatBool([sut respondsToSelector:@selector(tableView:numberOfRowsInSection:)], equalToBool(YES));
}

- (void)testTableViewNumberOfRowsInSectionShouldReturnItemsCount
{
    NSUInteger count;
    
    sut.items = @[@"item 1", @"item 2", @"item 3"];
    count = [sut tableView:nil numberOfRowsInSection:0];
    assertThatInteger(count, equalToInteger(3));

    sut.items = @[@"item 1", @"item 2"];
    count = [sut tableView:nil numberOfRowsInSection:0];
    assertThatInteger(count, equalToInteger(2));
    
    sut.items = @[@"item 1"];
    count = [sut tableView:nil numberOfRowsInSection:0];
    assertThatInteger(count, equalToInteger(1));
    
    sut.items = @[];
    count = [sut tableView:nil numberOfRowsInSection:0];
    assertThatInteger(count, equalToInteger(0));
}

- (void)testSutShouldRespondToTableViewCellForRowAtIndexPath
{
    assertThatBool([sut respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)], equalToBool(YES));
}

- (void)testCellForRowAtIndexPathShouldDequeueCellWithCorrectIdentifier
{
    UITableView *mockTableView = mock([UITableView class]);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    sut.cellIdentifier = @"cellIdentifier";
    [sut tableView:mockTableView cellForRowAtIndexPath:indexPath];
    
    [verify(mockTableView) dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
}

- (void)testCellForRowAtIndexPathShouldInvokeConfigureCellBlockWithCorrectCellAndObject
{    
    __block BOOL blockInvoked = NO;
    __block NSObject *testObject;
    __block UITableViewCell *testCell;
    
    sut.configureCellBlock = ^(UITableViewCell *cell, NSObject *object) {
        blockInvoked = YES;
        testObject = object;
        testCell = cell;
    };
    
    sut.items = @[@"item 1", @"item 2"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    UITableViewCell *cell = [UITableViewCell new];
    UITableView *mockTableView = mock([UITableView class]);
    [given([mockTableView dequeueReusableCellWithIdentifier:nil forIndexPath:indexPath]) willReturn:cell];
    
    [sut tableView:mockTableView cellForRowAtIndexPath:indexPath];
    
    assertThatBool(blockInvoked, equalToBool(YES));
    assertThat(testObject, is(@"item 1"));
    assertThat(testCell, is(cell));
}

- (void)testCellForRowAtIndexPathShouldReturnDequeuedCell
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [UITableViewCell new];
    UITableView *mockTableView = mock([UITableView class]);
    [given([mockTableView dequeueReusableCellWithIdentifier:nil forIndexPath:indexPath]) willReturn:cell];
    
    UITableViewCell *testCell = [sut tableView:mockTableView cellForRowAtIndexPath:indexPath];
    assertThat(testCell, is(cell));
}

- (void)testInitShouldSuccessfullyCreateAnInstanceWithAttributesSet
{
    NSArray *items = @[@"item 1", @"item 2"];
    NSString *cellIdentifier = @"cellIdentifier";
    ConfigureCellBlock configureCellBlock = ^(UITableViewCell *cell, NSObject *object) {};
    
    ROArrayDataSource *arrayDataSource = [[ROArrayDataSource alloc] initWithItems:items cellIdentifier:cellIdentifier configureCellBlock:configureCellBlock];
    
    assertThat(arrayDataSource.items, is(items));
    assertThat(arrayDataSource.cellIdentifier, is(cellIdentifier));
    assertThat(arrayDataSource.configureCellBlock, is(configureCellBlock));
}

@end
