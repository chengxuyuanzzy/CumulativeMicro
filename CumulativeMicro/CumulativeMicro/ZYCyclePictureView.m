//
//  ZYCyclePictureView.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/12.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYCyclePictureView.h"
#import "ZYLoopBanner.h"

@interface ZYCyclePictureView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ZYCyclePictureView

- (instancetype)initWithViewModel:(ZYCyclePictureViewModel *)viewModel {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    ZYLoopBanner *loop = [[ZYLoopBanner alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 240) scrollDuration:3.f];
    [self addSubview:loop];
    loop.imageArray = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpeg", @"5.jpeg", @"6.jpeg"];
    loop.clickAction = ^(NSInteger curIndex) {
        [self makeToast:[NSString stringWithFormat:@"点击了第%ld个图片", curIndex]];
    };
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"提示：轮播图采用三个imageview进行图片显示，left=最后一张图片索引， middle=0，right=1，将scrollview设置为第二页，通过kvo对scrollview的contentoffset进行监听，当改变后将left和right的index+1，contentoffset 再设置为中间值。假设四张图，顺序为 4 0 1， 当contentoffset改变时  先将图片设置设置成0 1 2 ，然后再迅速将contentoffset设置到中间即可。";
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.font = [UIFont systemFontOfSize:Level*15.f];
    tipLabel.numberOfLines = 0;
    [self addSubview:tipLabel];
    
    WS(weakSelf)
    [tipLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.left).offset(Level*10);
        make.top.equalTo(loop.bottom).offset(Verticl*20);
        make.right.equalTo(weakSelf.right).offset(Level*-10);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
