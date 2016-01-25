//
//  CCSudokuView.m
//  MasonryDemo
//
//  Created by CHANEL on 15/12/14.
//  Copyright © 2015年 CHANEL. All rights reserved.
//

#import "CCSudokuView.h"
#import <Masonry/MASConstraintMaker.h>
#import <Masonry/View+MASAdditions.h>

@interface CCSudokuView ()// <CCSudokuGridDelegate>

@end

@implementation CCSudokuView

-(void) createSudoku:(NSInteger)rowNum
              column:(NSInteger)colNum
             padding:(CGFloat)cellPadding
               color:(UIColor *)color
           cellArray:(NSArray *)cellArray
       cellClassName:(NSString *)cellClassName
                type:(SudokuType)sudokuType
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
    
    //边框线
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    bgView.backgroundColor = color;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            switch (sudokuType) {
                case SudokuTypeDefault:
                    make.edges.equalTo(self).insets(UIEdgeInsetsMake(padding, padding, padding, padding));
                    break;
                    
                case SudokuTypeLeftRight:
                    make.edges.equalTo(self).insets(UIEdgeInsetsMake(padding, 0, padding, 0));
                    break;
                    
                case SudokuTypeUpDown:
                    make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, padding, 0, padding));
                    break;
                    
                case SudokuTypeAround:
                    make.edges.equalTo(self);
                    break;
                    
                case SudokuTypeInside:
                    make.edges.equalTo(self).insets(UIEdgeInsetsMake(padding, padding, padding, padding));
                    padding = 0;
                    break;
                    
                case SudokuTypeNone:
                    make.edges.equalTo(self);
                    padding = 0;
                    break;
                    
                case SudokuTypeCustom:  //目前等同Default
                    make.edges.equalTo(self).insets(UIEdgeInsetsMake(padding, padding, padding, padding));
                    break;
                    
                default:
                    break;
            }
        }];
    
    Class cellClass = NSClassFromString(cellClassName);
    if (![cellClass isSubclassOfClass:[UIButton class]]) {
        return;
    }
    
    //创建单元格
    if ([cellArray count] < rowNumber * columnNumber) {
        return;
    }
    if (rowNumber > 0 && columnNumber > 0 && padding >= 0) {
        
        //计算器界面用GridType
        for (int i=1; i <= rowNumber*columnNumber; i++) {
//            GridType type;
//            NSString *text = [cellArray objectAtIndex:i-1];
//            if ([text isEqualToString:@"+"]) {
//                type = GridTypeAdd;
//            }
//            else if ([text isEqualToString:@"-"]) {
//                type = GridTypeSubtract;
//            }
//            else if ([text isEqualToString:@"*"]) {
//                type = GridTypeMultiply;
//            }
//            else if ([text isEqualToString:@"/"]) {
//                type = GridTypeDivide;
//            }
//            else if ([text isEqualToString:@"="]) {
//                type = GridTypeEqual;
//            }
//            else if ([text isEqualToString:@"del"]) {
//                type = GridTypeDelete;
//            }
//            else if ([text isEqualToString:@"."]) {
//                type = GridTypeDot;
//            }
//            else {
//                type = GridTypeNumber;
//            }
//            
//            CCSudokuGrid *gridView = [[CCSudokuGrid alloc] initWithType:type text:text];
//            [bgView addSubview:gridView];
//            gridView.tag = i;
//            gridView.delegate = self;
            
            UIButton *cellView = [[cellClass alloc] init];
            [bgView addSubview:cellView];
            cellView.tag = i;
            cellView.backgroundColor = [UIColor whiteColor];
//            cellView.delegate = delegate;
        }
        
//        __block UIButton *behindView = (UIButton *)[[cellClass alloc] init];
//        __block UIButton *frontView = (UIButton *)[[cellClass alloc] init];
        
        //创建Sudoku视图  i行数,j列数
        for (int i=1; i<=rowNumber; i++) {
            for (int j=1; j<=columnNumber; j++) {
                UIButton *currentView = [bgView viewWithTag:(columnNumber*(i-1)+j)];
                [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    if (rowNumber == 1) {   //如果只有1行
                        make.top.equalTo(bgView.mas_top);
                        make.bottom.equalTo(bgView.mas_bottom);
                    }
                    else {
                        if (i == 1) {   //第1行
                            make.top.equalTo(bgView.mas_top);
                            UIButton *behindView = [bgView viewWithTag:(columnNumber*i+j)];
                            make.bottom.equalTo(behindView.mas_top).offset(-padding);
                            make.height.equalTo(behindView);
                        }
                        else if (i == rowNumber) {  //最后1行
                            UIButton *frontView = [bgView viewWithTag:(columnNumber*(i-2)+j)];
                            make.top.equalTo(frontView.mas_bottom).offset(padding);
                            make.bottom.equalTo(bgView.mas_bottom);
                            make.height.equalTo(frontView);
                            
                        }
                        else {  //中间各行
                            UIButton *frontView = [bgView viewWithTag:(columnNumber*(i-2)+j)];
                            UIButton *behindView = [bgView viewWithTag:(columnNumber*i+j)];
                            make.top.equalTo(frontView.mas_bottom).offset(padding);
                            make.bottom.equalTo(behindView.mas_top).offset(-padding);
                            make.height.equalTo(frontView);
                        }
                    }
                    
                    if (columnNumber == 1) {    //如果只有1列
                        make.left.equalTo(bgView.mas_left);
                        make.right.equalTo(bgView.mas_right);
                    }
                    else {
                        if (j == 1) {   //第1列
                            make.left.equalTo(bgView.mas_left);
                            UIButton *behindView = [bgView viewWithTag:(columnNumber*(i-1)+j+1)];
                            make.right.equalTo(behindView.mas_left).offset(-padding);
                            make.width.equalTo(behindView);
                        }
                        else if (j == columnNumber) {   //最后1列
                            UIButton *frontView = [bgView viewWithTag:(columnNumber*(i-1)+j-1)];
                            make.left.equalTo(frontView.mas_right).offset(padding);
                            make.right.equalTo(bgView.mas_right);
                            make.width.equalTo(frontView);
                            
                        }
                        else {  //中间各列
                            UIButton *frontView = [bgView viewWithTag:(columnNumber*(i-1)+j-1)];
                            UIButton *behindView = [bgView viewWithTag:(columnNumber*(i-1)+j+1)];
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
