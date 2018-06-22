//
//  UIColor+Customize.m
//  MASMOVIL
//
//  Created by zhangxi on 2015/8/11.
//  Copyright (c) 2015 Huawei Software Technologies Co., Ltd. All rights reserved.
//

#import "UIColor+Customize.h"

@implementation UIColor (Customize)

+ (instancetype)colorFromRGB:(NSUInteger)rgb
{
    return [UIColor colorWithRed:((rgb & 0xFF0000) >> 16) / 255.0 green:((rgb & 0x00FF00) >> 8) / 255.0 blue:(rgb & 0x0000FF) / 255.0 alpha:1];
}



+ (instancetype)colorWithNumber:(NSInteger)number
{
    NSNumber *value = [self numberColor:number];
    if (!value) {
        return [UIColor colorFromRGB:0xFFFFFF];
    }
    return [UIColor colorFromRGB:[value unsignedIntegerValue]];
}

+ (void)getResourceColorDataWithPath:(NSString *)path dictionary:(NSMutableDictionary *)rgbValue
{
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data)
    {
        return;
    }
    NSError *error;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (!jsonDic)
    {
        NSLog(@"%@", error);
        return;
    }
    NSArray *allColors = jsonDic[@"color"];
    for (NSDictionary *colorDic in allColors)
    {
        NSString *colorName = colorDic[@"name"];
        NSString *colorValue = colorDic[@"value"];
        if (colorValue.length >= 1 && [colorValue characterAtIndex:0] == '#')
        {
            colorValue = [colorValue substringFromIndex:1];
        }
        NSScanner *aScaner = [NSScanner scannerWithString:colorValue];
        unsigned long long uLongValue = 0;
        if ([aScaner scanHexLongLong:&uLongValue])
        {
            rgbValue[colorName] = [NSNumber numberWithUnsignedLongLong:uLongValue];
        }
    }
}

//新添加处理颜色的方法
+ (UIColor *)colorWithHex:(NSString *)string
{
    NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


@end
