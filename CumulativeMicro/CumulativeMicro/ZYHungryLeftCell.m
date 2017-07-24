//
//  ZYHungryLeftCell.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/7/20.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYHungryLeftCell.h"

@interface ZYHungryLeftCell () {
    UILabel *titleLabel;
}

@end

@implementation ZYHungryLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}

- (void)initCell {
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Level*20, Verticl*15, Level*100, Verticl*20)];
    titleLabel.textColor = kUIColorFromRGB(0x666666);
    titleLabel.font = [UIFont systemFontOfSize:Level*16];
    [self.contentView addSubview:titleLabel];
}

- (void)config:(NSString *)model {
    titleLabel.text = model;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor  = selected ? kUIColorFromRGB(0xffffff) : kUIColorFromRGB(0xf8f8f8);
    // Configure the view for the selected state
}

@end
