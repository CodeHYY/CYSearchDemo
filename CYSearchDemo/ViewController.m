//
//  ViewController.m
//  CYSearchDemo
//
//  Created by toro宇 on 2018/6/21.
//  Copyright © 2018年 CodeYu. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "SearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:searchBtn];
    __weak typeof(self) weakSelf = self;
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
    [searchBtn setTitle:@"搜索" forState:(UIControlStateNormal)];
    searchBtn.backgroundColor = [UIColor greenColor];
    [searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)searchBtn:(UIButton *)Btn
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self presentViewController:searchVC animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
