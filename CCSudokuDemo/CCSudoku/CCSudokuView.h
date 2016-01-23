//
//  CCSudokuView.h
//  MasonryDemo
//
//  Created by CHANEL on 15/12/14.
//  Copyright © 2015年 CHANEL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSudokuGrid.h"

@protocol CCSudokuViewDelegate <NSObject>

- (void)gridAction:(GridType)type text:(NSString *)text;

@end

@interface CCSudokuView : UIView

@property (nonatomic, assign) int rowNumber;   //行数
@property (nonatomic, assign) int columnNumber; //列数
@property (nonatomic, copy) NSString *cellClassName;    //单元格类名
@property (nonatomic, assign) int padding;  //单元格间隙
@property (nonatomic, copy) NSArray *gridArray; //单元格类型数组,类型有+,-,*,/,.,=,del和数字
@property (nonatomic, assign) id <CCSudokuViewDelegate> delegate;

-(void) loadView;

@end
