//
//  ViewController.m
//  CCSudokuDemo
//
//  Created by CHANEL on 16/1/23.
//  Copyright © 2016年 cici. All rights reserved.
//

#import "ViewController.h"
#import "CCSudokuView.h"
#import "MASConstraintMaker.h"
#import "View+MASAdditions.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"CCSudokuDemo";
//    self.navigationController.navigationBar.translucent = NO;
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"status width - %f", rectStatus.size.width); // 宽度
    NSLog(@"status height - %f", rectStatus.size.height);   // 高度

    UIView *bgView = [[UIView alloc] init];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor orangeColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 10, 10, 10));
    }];
    
    CCSudokuView *sudoku = [[CCSudokuView alloc] init];
    [bgView addSubview:sudoku];
    sudoku.backgroundColor = [UIColor orangeColor];
    sudoku.rowNumber = 4;
    sudoku.columnNumber = 4;
    sudoku.padding = 1;
    sudoku.gridArray = [NSArray arrayWithObjects:
                        @"1", @"2", @"3", @"del",
                        @"4", @"5", @"6", @"",
                        @"7", @"8", @"9", @"",
                        @".", @"0", @"+", @"",  nil];
    
    [sudoku mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
        make.edges.equalTo(bgView).insets(UIEdgeInsetsMake(1, 1, 1, 1));
    }];
    [sudoku loadView];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
