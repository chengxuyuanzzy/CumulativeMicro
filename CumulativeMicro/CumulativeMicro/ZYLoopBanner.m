//
//  ZYLoopBanner.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/12.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYLoopBanner.h"

@interface ZYLoopBanner () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
//索引
@property (nonatomic, assign) NSInteger curIndex;

//循环时间
@property (nonatomic, assign) NSTimeInterval scrollDuration;
//计时器
@property (nonatomic, strong) NSTimer *scrollTimer;

@end

@implementation ZYLoopBanner

- (instancetype)initWithFrame:(CGRect)frame scrollDuration:(NSTimeInterval)duration {
    if (self = [super initWithFrame:frame]) {
        //kvo
        [self addObservers];
        [self initView];
        self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:(self.scrollDuration = duration) target:self selector:@selector(scrollTimerDidFired:) userInfo:nil repeats:YES];
        //先暂停timer
        [self.scrollTimer setFireDate:[NSDate distantFuture]];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.middleImageView];
    [self.scrollView addSubview:self.rightImageView];
    
    [self setFrames];
}

- (void)setFrames {
    self.scrollView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.scrollView.frame.size.height-20, CGRectGetWidth(self.bounds), 20.f);
    
    CGFloat imageWidth = CGRectGetWidth(self.scrollView.bounds);
    CGFloat imageHeight = CGRectGetHeight(self.scrollView.bounds);
    self.leftImageView.frame = CGRectMake(imageWidth * 0, 0, imageWidth, imageHeight);
    self.middleImageView.frame = CGRectMake(imageWidth * 1, 0, imageWidth, imageHeight);
    self.rightImageView.frame = CGRectMake(imageWidth * 2, 0, imageWidth, imageHeight);
    self.scrollView.contentSize = CGSizeMake(imageWidth * 3, 0);
    
    [self setScrollViewContentOffsetCenter];
}

- (void)setScrollViewContentOffsetCenter {
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.bounds), 0);
}

/**
 对scrollview的contentoffset进行监听
 */
- (void)addObservers {
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self caculateCurIndex];
    }
}

- (void)caculateCurIndex {
    if (self.imageArray && self.imageArray.count > 0) {
        CGFloat pointX = self.scrollView.contentOffset.x;
        CGFloat criticalValue = .2f;
        
        if (pointX > 2 * CGRectGetWidth(self.scrollView.bounds) - criticalValue) {
            self.curIndex = (self.curIndex + 1) % self.imageArray.count;
        }else if (pointX < criticalValue) {
            self.curIndex = (self.curIndex + self.imageArray.count - 1) % self.imageArray.count;
        }
    }
}

- (void)setCurIndex:(NSInteger)curIndex {
    if (_curIndex >= 0) {
        _curIndex = curIndex;
        
        NSInteger imageCount = self.imageArray.count;
        NSInteger leftIndex = (curIndex + imageCount - 1) % imageCount;
        NSInteger rightIndex = (curIndex + 1) % imageCount;
        
        self.leftImageView.image = [UIImage imageNamed:self.imageArray[leftIndex]];
        self.middleImageView.image = [UIImage imageNamed:self.imageArray[curIndex]];
        self.rightImageView.image = [UIImage imageNamed:self.imageArray[rightIndex]];
        
        [self setScrollViewContentOffsetCenter];
        
        self.pageControl.currentPage = curIndex;
    }
}

- (void)setImageArray:(NSArray *)imageArray {
    if (imageArray) {
        _imageArray = imageArray;
        self.curIndex = 0;
        
        if (self.imageArray.count > 1) {
            [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.scrollDuration]];
            self.pageControl.numberOfPages = imageArray.count;
            self.pageControl.currentPage = 0;
            self.pageControl.hidden = NO;
        }else {
            self.pageControl.hidden = YES;
            [self.leftImageView removeFromSuperview];
            [self.rightImageView removeFromSuperview];
            self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds), 0);
        }
    }
}

- (void)scrollTimerDidFired:(NSTimer *)tiemr {
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.bounds), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.imageArray.count > 1) {
        [self.scrollTimer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.imageArray.count > 1) {
        [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.scrollDuration]];
    }
}
#pragma - lazyLoad
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        
    }
    return _leftImageView;
}

- (UIImageView *)middleImageView {
    if (!_middleImageView) {
        _middleImageView = [[UIImageView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        [_middleImageView addGestureRecognizer:tap];
        _middleImageView.userInteractionEnabled = YES;
    }
    return _middleImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        
    }
    return _rightImageView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    }
    return _pageControl;
}

- (void)imageClick:(UITapGestureRecognizer *)tap {
    if (self.clickAction) {
        self.clickAction(self.curIndex);
    }
}

- (void)dealloc {
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
    
    [self.scrollTimer removeObserver:self forKeyPath:@"contentOffset" context:nil];
    NSLog(@"Loop Banner dealloc");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
