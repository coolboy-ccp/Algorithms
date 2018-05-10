//
//  ViewController.m
//  Algorithms
//
//  Created by 储诚鹏 on 2018/4/23.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

#import "ViewController.h"
#import "SequenceList.h"
#import "Recursion.h"
#import "Sorts.h"
#import "SearchLinearList.h"

typedef NSArray <NSDictionary<NSString *, NSArray *> *> * Test;
typedef NSArray <NSArray <void(^)(void)> *> * TestAction;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *testTable;
@property (nonatomic, strong) Test tests;
@property (nonatomic, strong) TestAction testActions;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_testTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
}

- (Test)tests {
    if (!_tests) {
        NSArray *sequenceTest = @[@"insert", @"delete", @"elementAt", @"locateElement"];
        NSArray *recursionTest = @[@"hanoi", @"fibonacci", @"fibonacci_tail", @"fibonacci_while", @"factorial"];
        NSArray *sortTest = @[@"bubble", @"fast", @"insertion", @"shell", @"select", @"heap", @"merge", @"radix"];
        NSArray *searchLinearListTest = @[@"order", @"binary", @"block"];
        _tests = @[@{@"sequence":sequenceTest},@{@"recursion":recursionTest},@{@"sort":sortTest},@{@"searchLinerarList":searchLinearListTest}];
    }
    return _tests;
}

- (TestAction)testActions {
    if (!_testActions) {
        NSArray *sequenceActions = @[^{testInsert();}, ^{testDelete();}, ^{testElementAt();}, ^{testLocateElement();}];
        NSArray *recursionActions = @[^{testHanoi();},^{testFibonacci();},^{testFibonacci_tail();},^{testFibonacci_while();},^{testFactorial();}];
        NSArray *sortActions = @[^{testBubbleSort();}, ^{testFastSort();}, ^{testInsertionSort();}, ^{testShellSort();}, ^{testSelectSort();}, ^{testHeapSort();}, ^{testMergeSort();}, ^{testRadixSort();}];
        NSArray *searchLinearListActions = @[^{testOrderSearch();}, ^{testBinarySearch();}, ^{testBlockSearch();}];
        _testActions = @[sequenceActions,recursionActions,sortActions, searchLinearListActions];
    }
    return _testActions;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tests.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tests[section].allValues.firstObject.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell"];
    cell.textLabel.text = self.tests[indexPath.section].allValues.firstObject[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.tests[section].allKeys.firstObject;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    void(^action)(void) = self.testActions[indexPath.section][indexPath.row];
    action();
}


@end
