//
//  CCSudokuView.m
//  MasonryDemo
//
//  Created by CHANEL on 15/12/14.
//  Copyright © 2015年 CHANEL. All rights reserved.
//

#import "CCSudokuView.h"
#import "View+MASAdditions.h"

@interface CCSudokuView ()// <CCSudokuGridDelegate>

@end

@implementation CCSudokuView

-(void) createSudoku:(NSInteger)rowNum
              column:(NSInteger)colNum
             padding:(CGFloat)cellPadding
               color:(UIColor *)color
           cellArray:(NSArray *)cellArray
       cellClassName:(NSString *)cellClassName
            delegate:(id<CCSudokuViewDelegate>)delegate
{
    [self createSudoku:rowNum
                column:colNum
               padding:cellPadding
                 color:color
             cellArray:cellArray
         cellClassName:cellClassName
                  type:SudokuTypeDefault
         customPadding:nil
              delegate:delegate];
}



-(void) createSudoku:(NSInteger)rowNum
              column:(NSInteger)colNum
             padding:(CGFloat)cellPadding
               color:(UIColor *)color
           cellArray:(NSArray *)cellArray
       cellClassName:(NSString *)cellClassName
                type:(SudokuType)sudokuType
       customPadding:(NSArray *)customArray
            delegate:(id<CCSudokuViewDelegate>)delegate
{
    NSInteger rowNumber = 1;
    NSInteger columnNumber = 1;
    __block CGFloat padding = 1;
    
    if (rowNum) {
        rowNumber = rowNum;
    }
    if (colNum) {
        columnNumber = colNum;
    }
    if (cellPadding) {
        padding = cellPadding;
    }
    if (!color) {
        color = [UIColor orangeColor];
    }
    self.backgroundColor = color;
    
    Class cellClass = NSClassFromString(cellClassName);
    if (![cellClass isSubclassOfClass:[UIButton class]]) {
        return;
    }
    
    //创建单元格
    if ([cellArray count] < rowNumber * columnNumber) {
        return;
    }
    if (rowNumber > 0 && columnNumber > 0 && padding >= 0) {
        for (int i=1; i <= rowNumber*columnNumber; i++) {
            UIButton *cellView = [[cellClass alloc] init];
            [self addSubview:cellView];
            cellView.tag = i;
            cellView.backgroundColor = [UIColor whiteColor];
//            cellView.delegate = delegate;
        }
        
        CGFloat upPadding, leftPadding, downPadding, rightPadding;
        switch (sudokuType) {
            case SudokuTypeDefault:
                upPadding = padding;
                leftPadding = padding;
                downPadding = padding;
                rightPadding = padding;
                break;
                
            case SudokuTypeLeftRight:
                upPadding = 0;
                leftPadding = padding;
                downPadding = 0;
                rightPadding = padding;
                break;
                
            case SudokuTypeUpDown:
                upPadding = padding;
                leftPadding = 0;
                downPadding = padding;
                rightPadding = 0;
                break;
                
            case SudokuTypeAround:
                upPadding = padding;
                leftPadding = padding;
                downPadding = padding;
                rightPadding = padding;
                padding = 0;
                break;
                
            case SudokuTypeInside:
                upPadding = 0;
                leftPadding = 0;
                downPadding = 0;
                rightPadding = 0;
                break;
                
            case SudokuTypeNone:
                upPadding = 0;
                leftPadding = 0;
                downPadding = 0;
                rightPadding = 0;
                padding = 0;
                break;
                
            case SudokuTypeCustom:
                if ([customArray count] != 4) {
                    return;
                }
                upPadding =[[customArray objectAtIndex:0] floatValue];
                leftPadding = [[customArray objectAtIndex:1] floatValue];
                downPadding = [[customArray objectAtIndex:2] floatValue];
                rightPadding = [[customArray objectAtIndex:3] floatValue];
                break;
                
            default:
                break;
        }
        
        //创建Sudoku视图  i行数,j列数
        for (int i=1; i<=rowNumber; i++) {
            for (int j=1; j<=columnNumber; j++) {
                UIButton *currentView = [self viewWithTag:(columnNumber*(i-1)+j)];
                [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    if (rowNumber == 1) {   //如果只有1行
                        make.top.equalTo(self.mas_top).offset(upPadding);
                        make.bottom.equalTo(self.mas_bottom).offset(-downPadding);
                    }
                    else {
                        if (i == 1) {   //第1行
                            make.top.equalTo(self.mas_top).offset(upPadding);
                            UIButton *behindView = [self viewWithTag:(columnNumber*i+j)];
                            make.bottom.equalTo(behindView.mas_top).offset(-padding);
                            make.height.equalTo(behindView);
                        }
                        else if (i == rowNumber) {  //最后1行
                            UIButton *frontView = [self viewWithTag:(columnNumber*(i-2)+j)];
                            make.top.equalTo(frontView.mas_bottom).offset(padding);
                            make.bottom.equalTo(self.mas_bottom).offset(-downPadding);
                            make.height.equalTo(frontView);
                            
                        }
                        else {  //中间各行
                            UIButton *frontView = [self viewWithTag:(columnNumber*(i-2)+j)];
                            UIButton *behindView = [self viewWithTag:(columnNumber*i+j)];
                            make.top.equalTo(frontView.mas_bottom).offset(padding);
                            make.bottom.equalTo(behindView.mas_top).offset(-padding);
                            make.height.equalTo(frontView);
                        }
                    }
                    
                    if (columnNumber == 1) {    //如果只有1列
                        make.left.equalTo(self.mas_left).offset(leftPadding);
                        make.right.equalTo(self.mas_right).offset(-rightPadding);
                    }
                    else {
                        if (j == 1) {   //第1列
                            make.left.equalTo(self.mas_left).offset(leftPadding);
                            UIButton *behindView = [self viewWithTag:(columnNumber*(i-1)+j+1)];
                            make.right.equalTo(behindView.mas_left).offset(-padding);
                            make.width.equalTo(behindView);
                        }
                        else if (j == columnNumber) {   //最后1列
                            UIButton *frontView = [self viewWithTag:(columnNumber*(i-1)+j-1)];
                            make.left.equalTo(frontView.mas_right).offset(padding);
                            make.right.equalTo(self.mas_right).offset(-rightPadding);
                            make.width.equalTo(frontView);
                            
                        }
                        else {  //中间各列
                            UIButton *frontView = [self viewWithTag:(columnNumber*(i-1)+j-1)];
                            UIButton *behindView = [self viewWithTag:(columnNumber*(i-1)+j+1)];
                            make.left.equalTo(frontView.mas_right).offset(padding);
                            make.right.equalTo(behindView.mas_left).offset(-padding);
                            make.width.equalTo(frontView);
                        }
                    }
                }];
            }
        }
    }
    
}

- (void)gridAction:(GridType)type text:(NSString *)text {
    if (self.delegate && [self.delegate respondsToSelector:@selector(gridAction:text:)]) {
        [self.delegate gridAction:type text:text];
    }
}



@end
