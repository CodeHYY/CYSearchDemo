//
//  UIColor+Customize.h
//  MASMOVIL
//
//  Created by zhangxi on 2015/8/11.
//  Copyright (c) 2015 Huawei Software Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Customize)

+ (instancetype)colorFromRGB:(NSUInteger)rgb;


+ (NSNumber*)numberColor:(NSInteger)number;

//新添加处理颜色的方法
+ (UIColor *)colorWithHex:(NSString *)string;

@end
