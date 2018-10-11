//
//  YISortSiftBar.h
//  yiquanqiu
//
//  Created by 陈经纬 on 2017/7/11.
//  Copyright © 2017年 YangWeiCong. All rights reserved.
//

#import "FGBaseView.h"
@class JWSortSiftBarView;

typedef NS_ENUM(NSUInteger, JWSortViewStyle) {
    JWSortViewStyleDefault,     //默认
    JWSortViewStyledUpAndDown   //上下箭头
};



@protocol JWSortSiftBarDataSourse <NSObject>
@required
- (NSString *)menuView:(JWSortSiftBarView *)menu titleAtIndex:(NSInteger)index;
- (NSInteger)numbersOfTitlesInSortView:(JWSortSiftBarView *)menuView;

@optional
- (JWSortViewStyle)menuView:(JWSortSiftBarView *)menu styleAtIndex:(NSInteger)index;

@end

// 选中后的箭头方式
typedef NS_ENUM(NSUInteger, JWSortViewSelectedDirection) {
    JWSortViewSelectedDirectionDefault,
    JWSortViewSelectedDirectionUp,
    JWSortViewSelectedDirectionDown
};

@protocol JWSortSiftBarDelegate <NSObject>
@optional
- (void)menuView:(JWSortSiftBarView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex selectedDirection:(JWSortViewSelectedDirection)selectedDirection;

@end




@interface JWSortSiftBarView : FGBaseView
@property (nonatomic,strong)UIImage *selectDireDefaultImage;///<<#name#>
@property (nonatomic,strong)UIImage *selectDireUpImage;///<name
@property (nonatomic,strong)UIImage *selectDireDownImage;///<<#name#>
@property (nonatomic,strong)UIColor *selectTextColor;///<<#name#>
@property (nonatomic,strong)UIColor *normalTextColor;///<<#name#>
@property (nonatomic, weak)id<JWSortSiftBarDataSourse> dataSource;///<<#name#>
@property (nonatomic, weak)id<JWSortSiftBarDelegate> delegate;///<<#name#>
@end
