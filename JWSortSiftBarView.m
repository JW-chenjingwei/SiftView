//
//  YISortSiftBar.m
//  yiquanqiu
//
//  Created by 陈经纬 on 2017/7/11.
//  Copyright © 2017年 YangWeiCong. All rights reserved.
//二级分类筛选栏

#import "JWSortSiftBarView.h"
#import <JKCategories/UIButton+JKImagePosition.h>

@interface JWSortItemButton:UIButton
@property (nonatomic, assign) JWSortViewSelectedDirection selectedDirection;  ///< <#Description#>
@end
@implementation JWSortItemButton
@end



@interface JWSortSiftBarView()
@property (nonatomic, weak) UIScrollView *scrollView;

@property(nonatomic,assign)NSInteger  currentIndex;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, readonly) NSInteger titlesCount;
@property (nonatomic, weak) JWSortItemButton *selItem;
@end

@implementation JWSortSiftBarView


- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    if (self.scrollView) {
        return;
    }
    if (!self.selectTextColor) {
        self.selectTextColor = UIColorFromHex(0xFF5000);
    }
    if (!self.normalTextColor) {
        self.normalTextColor = UIColorFromHex(0x666666);
    }
    
    if (!self.selectDireDefaultImage) {
        self.selectDireDefaultImage = UIImageWithName(@"ic_sorting");
    }
    if (!self.selectDireUpImage) {
        self.selectDireUpImage = UIImageWithName(@"ic_sorting_arrow_upward");
    }
    if (!self.selectDireDownImage) {
        self.selectDireDownImage = UIImageWithName(@"ic_sorting_arrow_down");
    }
    
    [self addScrollView];
    [self addItems];
}

- (void)itemViewClick:(JWSortItemButton *)item{
    [self.selItem setTitleColor:self.normalTextColor forState:0];
    [item setTitleColor:self.selectTextColor forState:0];
    
    JWSortViewStyle viewStyle = [self.dataSource menuView:self styleAtIndex:item.tag];
    if (viewStyle == JWSortViewStyledUpAndDown) {
        
        if (self.selItem.selectedDirection != JWSortViewSelectedDirectionDefault && ![item isEqual:self.selItem]) {

            [self.selItem setImage:_selectDireDefaultImage forState:0];
            self.selItem.selectedDirection = JWSortViewStyleDefault;
            
        }
        
            if (item.selectedDirection == JWSortViewSelectedDirectionDown) {
                [item setImage:_selectDireUpImage forState:0];
                item.selectedDirection = JWSortViewSelectedDirectionUp;
                if ([self.delegate respondsToSelector:@selector(menuView:didSelesctedIndex:currentIndex:selectedDirection:)]) {
                    [self.delegate menuView:self didSelesctedIndex:item.tag currentIndex:self.selItem.tag selectedDirection:JWSortViewSelectedDirectionUp];
                }
            }
            else if(item.selectedDirection == JWSortViewSelectedDirectionUp){
                
                
                
                [item setImage:_selectDireDownImage forState:0];
                item.selectedDirection = JWSortViewSelectedDirectionDown;
                if ([self.delegate respondsToSelector:@selector(menuView:didSelesctedIndex:currentIndex:selectedDirection:)]) {
                    [self.delegate menuView:self didSelesctedIndex:item.tag currentIndex:self.selItem.tag selectedDirection:JWSortViewSelectedDirectionDown];
                }
            }
            else{
                [item setImage:_selectDireUpImage forState:0];
                item.selectedDirection = JWSortViewSelectedDirectionUp;
                if ([self.delegate respondsToSelector:@selector(menuView:didSelesctedIndex:currentIndex:selectedDirection:)]) {
                    [self.delegate menuView:self didSelesctedIndex:item.tag currentIndex:self.selItem.tag selectedDirection:JWSortViewSelectedDirectionUp];
                }
            }

         
    }
    else{
        item.selectedDirection = JWSortViewSelectedDirectionDefault;
        if (self.selItem.selectedDirection != JWSortViewSelectedDirectionDefault) {
            [self.selItem setImage:_selectDireDefaultImage forState:0];
        }
        if ([self.delegate respondsToSelector:@selector(menuView:didSelesctedIndex:currentIndex:selectedDirection:)]) {
            [self.delegate menuView:self didSelesctedIndex:item.tag currentIndex:self.selItem.tag selectedDirection:JWSortViewSelectedDirectionDefault];
        }
    }
    
    self.selItem = item;

}

#pragma mark - Data source
- (NSInteger)titlesCount {
    return [self.dataSource numbersOfTitlesInSortView:self];
}

- (void)addScrollView {

    UIScrollView *scrollView = [UIScrollView new];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.scrollsToTop = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)addItems{
    if (self.titlesCount == 0) {
        return;
    }

    CGFloat itemWidth = kScreenWidth / self.titlesCount;
    for (int i = 0; i< self.titlesCount; i++) {
        NSString *itemTitle = [self.dataSource menuView:self titleAtIndex:i];
        JWSortItemButton *item = [JWSortItemButton new];
        [item setTitle:itemTitle forState:0];
        [item setTitleColor:self.normalTextColor forState:0];
        item.titleLabel.font = AdaptedFontSize(16);
        [item jk_setImagePosition:LXMImagePositionRight spacing:10];
        item.tag = i;
        JWSortViewStyle viewStyle = [self.dataSource menuView:self styleAtIndex:i];
        if (viewStyle == JWSortViewStyledUpAndDown) {
            [item setImage:_selectDireDefaultImage forState:0];
        }
        [item addTarget:self action:@selector(itemViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            make.width.mas_equalTo(itemWidth);
            make.left.offset(i * itemWidth);
        }];
        
        if (i == 0) {
            [self itemViewClick:item];
            self.selItem = item;
        }

    }

}

@end
