//
//  MyScrollView.m
//  MyScrollView
//
//  Created by Jennifier on 16/7/16.
//  Copyright © 2016年 xiuping xie. All rights reserved.
//

#import "MyScrollView.h"

@interface MyScrollView ()<UIScrollViewDelegate>


@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIPageControl *pageControl;
@property(nonatomic, strong)UIImageView *leftImageView;
@property(nonatomic, strong)UIImageView *middleImageView;
@property(nonatomic, strong)UIImageView *rightImageView;
@property(nonatomic, assign)NSInteger currentNumber;
@property(weak,nonatomic)NSTimer * timer;

@end


@implementation MyScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        
    }
    
    return self;
}


-(void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
    
    //创建子控件
    [self creatSubViews];
    
    [self startTimer];
    
    
    
}

#pragma mark - 1.创建子视图
-(void)creatSubViews {
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(width * 3, height);
    
    [self addSubview:_scrollView];
    
    //创建分页控件
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, width, 30)];
    
    _pageControl.numberOfPages = _imageNames.count;
    _pageControl.currentPage = 0;
    
    _pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    
    [self addSubview:_pageControl];

    
    //3.创建左中右三个图片视图
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width *2 , 0, width, height)];
    
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_middleImageView];
    [_scrollView addSubview:_rightImageView];
    
    [self loadImage];
}


-(void)loadImage {
    
    _middleImageView.image = [UIImage imageNamed:_imageNames[_currentNumber]];
    
    
    NSInteger leftIndex = (_currentNumber - 1 + _imageNames.count) % _imageNames.count;
    _leftImageView.image = [UIImage imageNamed:_imageNames[leftIndex]];
    
    
    NSInteger rightIndex = (_currentNumber + 1) % _imageNames.count;
    _rightImageView.image = [UIImage imageNamed:_imageNames[rightIndex]];
   
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x);
    
    
    //1.判断滑动方向
    if (scrollView.contentOffset.x > scrollView.bounds.size.width) {//向左滑动
        
        _currentNumber = (_currentNumber + 1) % _imageNames.count;
        
    }else if(scrollView.contentOffset.x < scrollView.bounds.size.width){ //向右滑动
        _currentNumber = (_currentNumber - 1 + _imageNames.count) % _imageNames.count;
        
    }
    
    [self loadImage];
    
    _pageControl.currentPage = _currentNumber;
    
    scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    
    
    
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}


#pragma mark -- 定时器
-(void)startTimer
{
    NSTimer * timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)next
{
    _currentNumber = (_currentNumber + 1) % _imageNames.count;
    [self loadImage];
    _pageControl.currentPage = _currentNumber;
    
    
    self.scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    
    
}



@end
