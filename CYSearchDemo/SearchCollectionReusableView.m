//
//  SearchCollectionReusableView.m
//  CYSearchDemo
//
//  Created by toro宇 on 2018/6/21.
//  Copyright © 2018年 CodeYu. All rights reserved.
//

#import "SearchCollectionReusableView.h"
#import "Masonry.h"
#import "UIColor+Customize.h"
@interface SearchCollectionReusableView()
@end
@implementation SearchCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *lab = [[UILabel alloc] init];
        [self addSubview:lab];
        _titleLab = lab;
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(18);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.equalTo(@80);
        }];
        lab.textColor = [UIColor colorWithHex:@"#8f9092"];
        
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-18);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        [deleteBtn setImage:[UIImage imageNamed:@"delete_white"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
- (void)deleteBtn:(UIButton *)btn
{
    if (self.deleteBtnBlock) {
        self.deleteBtnBlock();
    }
}
@end
