//
//  ViewController.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

// 在指定的self.view区域上显示图片轮播器，一共显示两个不同的例子
#import "ViewController.h"
#import "SDCycleScrollView.h"

@interface ViewController () <SDCycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005.jpg"]];
    backgroundView.frame = self.view.bounds;
    [self.view addSubview:backgroundView];
    
    // 情景一：采用本地图片实现
    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
                        [UIImage imageNamed:@"h2.jpg"],
                        [UIImage imageNamed:@"h3.jpg"],
                        [UIImage imageNamed:@"h4.jpg"]
                        ];
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                           @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                           @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                           @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                           ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com",
                        @"感谢您的支持"
                        ];
    
    
    
    //
    CGFloat w = self.view.bounds.size.width;
    
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, w, 180) imagesGroup:images];

    // 是否无限循环，默认yes
    cycleScrollView.infiniteLoop = YES;
    
    // 设置代理，如果选择了轮播器的图片
    cycleScrollView.delegate = self;
    
//    cycleScrollView.titlesGroup = titles;
    
    // pagecontrol格式动画
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    // 对齐方式默认中间对齐
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [self.view addSubview:cycleScrollView];
    // --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 1.0;
    
    
     //网络加载 --- 创建带标题的图片轮播器
    // 创建图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 320, w, 180) imageURLStringsGroup:nil]; // 模拟网络延时情景因此设置url为nil,正常使用可以直接填充URL数组
    // 对齐方式
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    // 设置代理，点击图片后调用
    cycleScrollView2.delegate = self;
    // 在图片下面显示标题
    cycleScrollView2.titlesGroup = titles;
    // 自定义分页控件小圆标颜色
    cycleScrollView2.dotColor = [UIColor yellowColor];
    // 网络加载，设置占位图片
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.view addSubview:cycleScrollView2];
    
//             --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    

    // 清除缓存
//    [cycleScrollView2 clearCache];

    

}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了%@第%ld张图片",cycleScrollView, index);
}

@end
