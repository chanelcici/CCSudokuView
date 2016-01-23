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

    CCSudokuView *sudoku = [[CCSudokuView alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width-10*2, self.view.frame.size.height-20-10)];
    [self.view addSubview:sudoku];
//    sudoku.backgroundColor = [UIColor orangeColor];
    
    NSArray *gridArray = [NSArray arrayWithObjects:
                          @"1", @"2", @"3", @"del",
                          @"4", @"5", @"6", @"",
                          @"7", @"8", @"9", @"",
                          @".", @"0", @"+", @"",  nil];
    [sudoku createSudoku:4
                  column:4
                 padding:1.0
                   color:[UIColor orangeColor]
               gridArray:gridArray
                    type:SudokuTypeDefault];
    
    
    
    
    
    
//    sudoku.rowNumber = 4;
//    sudoku.columnNumber = 4;
//    sudoku.padding = 1;
    
    
//    [sudoku mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.center.mas_equalTo(self.view);
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(1, 1, 1, 1));
//    }];
//    [sudoku loadView];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
