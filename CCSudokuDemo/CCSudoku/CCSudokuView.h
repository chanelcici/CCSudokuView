//
//  CCSudokuView.h
//  MasonryDemo
//
//  Created by CHANEL on 15/12/14.
//  Copyright © 2015年 CHANEL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSudokuGrid.h"

typedef NS_ENUM(NSInteger, SudokuType) {
    SudokuTypeDefault = 0,  //田
    SudokuTypeLeftRight,    //王
    SudokuTypeUpDown,       //卅
    SudokuTypeAround,       //井
    SudokuTypeInside,       //口
    SudokuTypeNone,         //无框线
    SudokuTypeCustom,       //自定义
    
};

@protocol CCSudokuViewDelegate <NSObject>

- (void)gridAction:(GridType)type text:(NSString *)text;

@end

@interface CCSudokuView : UIView

@property (nonatomic, copy) NSString *cellClassName;    //单元格类名
@property (nonatomic, assign) id <CCSudokuViewDelegate> delegate;

/**
 *  sudokuView创建函数
 *
 *  @param rowNum        行数
 *  @param colNum        列数
 *  @param cellPadding   单元格间隙
 *  @param color         间隙颜色
 *  @param cellArray     单元格数组
 *  @param cellClassName 单元格类名
 *  @param sudokuType    类型
 */
-(void) createSudoku:(NSInteger)rowNum
              column:(NSInteger)colNum
             padding:(CGFloat)cellPadding
               color:(UIColor *)color
           cellArray:(NSArray *)cellArray
       cellClassName:(NSString *)cellClassName
                type:(SudokuType)sudokuType
            delegate:(id<CCSudokuViewDelegate>)delegate;

@end
