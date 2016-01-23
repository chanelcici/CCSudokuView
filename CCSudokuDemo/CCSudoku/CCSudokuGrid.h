//
//  CCSudokuGrid.h
//  MasonryDemo
//
//  Created by CHANEL on 15/12/22.
//  Copyright © 2015年 CHANEL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GridType) {
    GridTypeAdd         = 0,    //加
    GridTypeSubtract    = 1,    //减
    GridTypeMultiply    = 2,    //乘
    GridTypeDivide      = 3,    //除
    GridTypeNumber      = 4,    //数字
    GridTypeDot         = 5,    //小数点
    GridTypeEqual       = 6,    //等号
    GridTypeDelete      = 7,    //退格键
    //    GridTypeNil         = 8,    //空
    
};

@protocol CCSudokuGridDelegate <NSObject>

- (void)gridAction:(GridType)type text:(NSString *)text;

@end



@interface CCSudokuGrid : UIButton

@property (nonatomic, assign) GridType type;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) id <CCSudokuGridDelegate> delegate;

-(instancetype) initWithType:(GridType)type text:(NSString *)text;

@end
