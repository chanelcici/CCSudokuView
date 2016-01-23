//
//  CCSudokuGrid.m
//  MasonryDemo
//
//  Created by CHANEL on 15/12/22.
//  Copyright © 2015年 CHANEL. All rights reserved.
//

#import "CCSudokuGrid.h"
#import <CoreImage/CIImage.h>

#define HEX_RGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation CCSudokuGrid

-(instancetype) initWithType:(GridType)type text:(NSString *)text {
    self = [super init];
    if (self) {
        self.type = type;
        self.text = text;
        CGFloat fontsize = 40;
        self.titleLabel.font = [UIFont systemFontOfSize:fontsize];
        [self setTitleColor:HEX_RGB(0x909090) forState:UIControlStateNormal];
        [self setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal ];
        [self setBackgroundImage:[self imageWithColor:HEX_RGB(0xc2c2c2)] forState:UIControlStateHighlighted ];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(gridAction) forControlEvents:UIControlEventTouchUpInside];
        [self setTitle:text forState:UIControlStateNormal];

//        switch (type) {
//            case GridTypeNumber:
//                
//                break;
//            case GridTypeDelete:
//                
//                break;
//            case GridTypeDot:
//                
//                break;
//            case GridTypeAdd:
//                
//                break;
//            case GridTypeSubtract:
//                
//                break;
//            case GridTypeMultiply:
//                
//                break;
//            case GridTypeDivide:
//                
//                break;
//            case GridTypeEqual:
//                
//                break;
//                
//                
//            default:
//                break;
//        }
    }
    return self;
}

-(void) gridAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(gridAction:text:)]) {
        [self.delegate gridAction:self.type text:self.text];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
