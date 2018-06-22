//
//  SearchViewController.m
//  CYSearchDemo
//
//  Created by toro宇 on 2018/6/21.
//  Copyright © 2018年 CodeYu. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCollectionViewCell.h"
#import "SearchCollectionReusableView.h"
#import "Masonry.h"
#import "UIColor+Customize.h"
@interface SearchViewController ()<UITextFieldDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, weak)UIView *navView;
@property (nonatomic, weak)UICollectionView *myCollectionView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#fafafa"];
    
    [self initCustomUI];
    [self.dataArray[0] addObjectsFromArray:@[@"阿里巴巴财报",@"苹果",@"小米ipo",@"小游戏",@"蚂蚁金服",@"腾旭"]];
    [self.dataArray[1] addObjectsFromArray:@[@"阿里巴巴财报",@"苹果"]];
    [self.myCollectionView reloadData];
    // Do any additional setup after loading the view.
}



-(void)initCustomUI
{
    [self navView];
    [self myCollectionView];
}
#pragma mark -UICollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionViewCell" forIndexPath:indexPath];
    NSArray *titleAry = self.dataArray[indexPath.section];
    cell.titleLab.text = titleAry[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleAry = self.dataArray[indexPath.section];
    CGFloat cellWidth = [SearchCollectionViewCell cellWidthForData:titleAry[indexPath.row]];
    return CGSizeMake(cellWidth, 34);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        SearchCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            reusableView.deleteBtn.hidden = YES;
            reusableView.titleLab.text = @"热门搜索";
        }else if (indexPath.section == 1){
            reusableView.deleteBtn.hidden = NO;
            reusableView.titleLab.text = @"搜索历史";
            __weak typeof(self) weakSelf = self;
            reusableView.deleteBtnBlock = ^{
                [weakSelf.dataArray[1] removeAllObjects];
                NSIndexSet *index = [NSIndexSet indexSetWithIndex:1];
                [weakSelf.myCollectionView reloadSections:index];
            };
        }
        return reusableView;
    }else
    {
        return nil;
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 18, 18, 18);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 46);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [self.dataArray[1] addObject:textField.text];
        NSIndexSet *index = [NSIndexSet indexSetWithIndex:1];
        [self.myCollectionView reloadSections:index];

    }
    return YES;
}


#pragma mark -Action
-(void)cancleBtn:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark -Lazy

-(UIView *)navView
{
    __weak typeof(self) weakSelf = self;
    if (!_navView) {
        UIView *navView = [[UIView alloc] init];
        navView.backgroundColor = [UIColor colorWithHex:@"#ffffff"];
        [self.view addSubview:navView];
        _navView = navView;
        [navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view);
            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
            make.height.equalTo(@64);
        }];
        
        // 搜索框
        UITextField *textField = [[UITextField alloc] init];
        [navView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(navView).offset(18);
            make.centerY.equalTo(navView).offset(10);
            make.size.mas_equalTo(CGSizeMake(280, 32));
        }];
        _textField = textField;
        textField.delegate = self;
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 15;
        textField.backgroundColor = [UIColor colorWithHex:@"#f5f5f5"];

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 16, 16)];
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32, 20)];
        [bg addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"search"];
        textField.leftView = bg;
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜个关键字试试看" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#bfbfc4"]}];;
        
        // 取消按钮
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [navView addSubview:cancleBtn];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(navView).offset(-18);
            make.centerY.equalTo(textField);
            make.size.mas_equalTo(CGSizeMake(50, 40));
        }];
        [cancleBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [cancleBtn setTitleColor:[UIColor colorWithHex:@"#789df0"] forState:(UIControlStateNormal)];
        [cancleBtn addTarget:self action:@selector(cancleBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _navView;
}

-(UICollectionView *)myCollectionView
{
    __weak typeof(self) weakSelf = self;
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectNull collectionViewLayout:flowLayout];
        [self.view addSubview:collectionView];
        collectionView.backgroundColor = [UIColor clearColor];
        _myCollectionView = collectionView;
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.navView.mas_bottom);
            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view);
        }];
        
        [_myCollectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"SearchCollectionViewCell"];
        [_myCollectionView registerClass:[SearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        
    }
    return _myCollectionView;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        NSMutableArray *dataAry = [NSMutableArray arrayWithObjects:[NSMutableArray array],[NSMutableArray array], nil];
        _dataArray = dataAry;
    }
    return _dataArray;
}



@end
