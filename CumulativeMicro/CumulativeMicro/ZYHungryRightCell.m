//
//  ZYHungryRightCell.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/7/20.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYHungryRightCell.h"

@interface ZYHungryRightCell () {
    UIImageView *iconImageView;
    UILabel *titleLabel;
    UILabel *contentLabel;
    UILabel *priceLabel;
}

@end

@implementation ZYHungryRightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}
- (void)initCell {
    iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Level*15, Verticl*15, Level*60, Level*60)];
    iconImageView.image = [UIImage imageNamed:@"macDog.png"];
    [self.contentView addSubview:iconImageView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Level*85, Verticl*5, (WIDTH*2/3)-Level*100, Verticl*40)];
    titleLabel.textColor = kUIColorFromRGB(0x333333);
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:Level*16];
    [self.contentView addSubview:titleLabel];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(Level*85, Verticl*45, Level*300, Verticl*20)];
    contentLabel.text = @"月售333份  好评率100%";
    contentLabel.textColor = kUIColorFromRGB(0x666666);
    contentLabel.font = [UIFont systemFontOfSize:Level*11];
    [self.contentView addSubview:contentLabel];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(Level*85, Verticl*65, Level*100, Verticl*20)];
    priceLabel.text = @"¥16";
    priceLabel.textColor = kUIColorFromRGB(0xff6000);
    priceLabel.font = [UIFont systemFontOfSize:Level*13];
    [self.contentView addSubview:priceLabel];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton setTitle:@"+" forState:UIControlStateNormal];
    [_addButton setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    _addButton.titleLabel.font = [UIFont systemFontOfSize:Level*23];
    _addButton.backgroundColor = kUIColorFromRGB(0x3190e8);
    _addButton.layer.cornerRadius = Level*10;
    _addButton.frame = CGRectMake(WIDTH-Level*80-Level*30, Verticl*65, Level*20, Level*20);
    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addButton];
    
    _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(_addButton.x-Level*25, _addButton.y, Level*25, _addButton.kHeight)];
    _numLabel.textColor = kUIColorFromRGB(0x333333);
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.font = [UIFont systemFontOfSize:Level*14];
    [self.contentView addSubview:_numLabel];
    
    _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_minusButton setTitle:@"-" forState:UIControlStateNormal];
    [_minusButton setTitleColor:kUIColorFromRGB(0x3190e8) forState:UIControlStateNormal];
    _minusButton.backgroundColor = [UIColor whiteColor];
    _minusButton.layer.cornerRadius = Level*10;
    _minusButton.layer.borderColor = kUIColorFromRGB(0x3190e8).CGColor;
    _minusButton.layer.borderWidth = 1;
    _minusButton.hidden = YES;
    _minusButton.titleLabel.font = [UIFont systemFontOfSize:Level*20];
    _minusButton.frame = CGRectMake(_numLabel.x-Level*20, _numLabel.y, _addButton.kWidth, _addButton.kHeight);
    [_minusButton addTarget:self action:@selector(minusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_minusButton];
}

- (void)addButtonClick:(UIButton *)button {
    _minusButton.hidden = NO;
    _numLabel.hidden = NO;
    _countNum++;
    self.model.numCount = _countNum;
    _numLabel.text = [NSString stringWithFormat:@"%ld", (long)_countNum];
    if (self.addButtonClickBlock) {
        self.addButtonClickBlock();
    }
}

- (void)minusButtonClick:(UIButton *)button {
    _countNum--;
    self.model.numCount = _countNum;
    if (_countNum > 0) {
        _numLabel.text = [NSString stringWithFormat:@"%ld", (long)_countNum];
    }else {
        _numLabel.hidden = YES;
        _minusButton.hidden = YES;
    }
}

- (void)config:(DataArray *)model {
    self.model = model;
    titleLabel.text = model.name;
    if (model.numCount > 0) {
        _numLabel.text = [NSString stringWithFormat:@"%ld", model.numCount];
        _minusButton.hidden = NO;
    }else {
        _minusButton.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
