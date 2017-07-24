//
//  ZYCalculatorView.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/9.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYCalculatorView.h"

#define CalculatorItemWidth (WIDTH-2.5)/4

@interface ZYCalculatorView ()

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) NSArray *keyBoardArray;

@property (nonatomic, strong) UIButton *keyBoardButton;

@property (nonatomic, strong) UILabel *totalLabel;

@property (nonatomic, strong) ZYCalculatorViewModel *viewModel;

@end

@implementation ZYCalculatorView

- (void)initWithViewModel:(ZYCalculatorViewModel *)viewModel {
    self.viewModel = (ZYCalculatorViewModel *)viewModel;
    [self initUI];
    
    @weakify(self);
    [self.viewModel.clickSubject subscribeNext:^(id x) {
        @strongify(self);
        self.totalLabel.text = x;
    }];
}

- (void)initUI {
    [self addSubview:self.topView];
    WS(weakSelf)
    [self.topView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.left);
        make.top.equalTo(weakSelf.top);
        make.right.equalTo(weakSelf.right);
        make.height.equalTo(HEIGHT-(CalculatorItemWidth*5+3));
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.left);
        make.top.equalTo(weakSelf.topView.bottom);
        make.right.equalTo(weakSelf.right);
        make.bottom.equalTo(weakSelf.bottom);
    }];
    /** 键盘按钮 */
    [self createKeyButton];
    /** 顶部显示数字label */
    [self createTotalLabel];
}
#pragma - 创建顶部显示数字label
- (void)createTotalLabel {
    [self.topView addSubview:self.totalLabel];
    
    WS(weakSelf);
    [self.totalLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.topView.right).offset(Level*-15);
        make.bottom.equalTo(weakSelf.topView.bottom).offset(Verticl*-10);
        make.left.equalTo(weakSelf.topView.left).offset(Level*20);
        make.height.equalTo(Verticl*75);
    }];
}
#pragma - 创建键盘按钮
- (void)createKeyButton {
    for (int i=0; i<self.keyBoardArray.count; i++) {
        self.keyBoardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.keyBoardButton setTitle:self.keyBoardArray[i] forState:UIControlStateNormal];
        [self.keyBoardButton setTitleColor:kUIColorFromRGB(0x000000) forState:UIControlStateNormal];
        self.keyBoardButton.titleLabel.font = [UIFont systemFontOfSize:Level*30.f weight:UIFontWeightThin];
        self.keyBoardButton.tag = 100 + i;
        [self.keyBoardButton addTarget:self action:@selector(keyBoardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.keyBoardButton];
        
        if (i < 3) {
            self.keyBoardButton.backgroundColor = kUIColorFromRGB(0xc9cacc);
        }else if (i == 3 || i == 7 || i == 11 || i == 15 || i == 18) {
            self.keyBoardButton.backgroundColor = kUIColorFromRGB(0xf98210);
            [self.keyBoardButton setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        }else if (i > 3 && i < 7) {
            self.keyBoardButton.backgroundColor = kUIColorFromRGB(0xd4d6d8);
        }else if (i > 7 && i < 11) {
            self.keyBoardButton.backgroundColor = kUIColorFromRGB(0xced0d2);
        }else if (i > 11 && i < 15) {
            self.keyBoardButton.backgroundColor = kUIColorFromRGB(0xc9cbcd);
        }else {
            self.keyBoardButton.backgroundColor = kUIColorFromRGB(0xc3c5c8);
            if (i == 16) {
                self.keyBoardButton.titleEdgeInsets = UIEdgeInsetsMake(0, Level*-45, 0, Level*45);
            }
        }
        
        WS(weakSelf)
        [self.keyBoardButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.bottomView.top).offset(i/4*(0.5+CalculatorItemWidth)+0.5);
            if (i > 15) {
                if (i == 16) {
                    make.left.equalTo(weakSelf.bottomView.left).offset(i%4*(0.5+CalculatorItemWidth*2)+0.5);
                    make.width.equalTo(0.5+2*CalculatorItemWidth);
                }else {
                    make.left.equalTo(weakSelf.bottomView.left).offset(i%4*(0.5+CalculatorItemWidth)+1+CalculatorItemWidth);
                    make.width.equalTo(CalculatorItemWidth);
                }
            }else {
                make.left.equalTo(weakSelf.bottomView.left).offset(i%4*(0.5+CalculatorItemWidth)+0.5);
                make.width.equalTo(CalculatorItemWidth);
            }
            make.height.equalTo(CalculatorItemWidth);
        }];
    }
}
#pragma - 键盘按钮点击事件
- (void)keyBoardButtonClick:(UIButton *)button {
    [self.viewModel.keyButtonClickCommand execute:self.keyBoardArray[button.tag-100]];
}
#pragma - lazyLoad
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = kUIColorFromRGB(0x202020);
        
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
        [_topView addGestureRecognizer:swipe];
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = kUIColorFromRGB(0x000000);
    }
    return _bottomView;
}

- (NSArray *)keyBoardArray {
    if (!_keyBoardArray) {
        _keyBoardArray = @[@"AC", @"+/_", @"%", @"÷", @"7", @"8", @"9", @"×", @"4", @"5", @"6", @"-", @"1", @"2", @"3", @"+", @"0", @".", @"="];
    }
    return _keyBoardArray;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.text = @"0";
        _totalLabel.textColor = kUIColorFromRGB(0xffffff);
        _totalLabel.font = [UIFont systemFontOfSize:74.f weight:UIFontWeightThin];
        _totalLabel.textAlignment = NSTextAlignmentRight;
        _totalLabel.adjustsFontSizeToFitWidth = YES;
        _totalLabel.minimumScaleFactor = 0.9f;
    }
    return _totalLabel;
}

- (ZYCalculatorViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZYCalculatorViewModel alloc] init];
    }
    return _viewModel;
}
#pragma - 清扫手势事件
- (void)swipe:(UISwipeGestureRecognizer *)sender {
    [self.viewModel.keyButtonClickCommand execute:@"right"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
