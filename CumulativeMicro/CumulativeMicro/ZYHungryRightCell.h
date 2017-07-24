//
//  ZYHungryRightCell.h
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/7/20.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYHungryModel.h"

@interface ZYHungryRightCell : UITableViewCell

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *minusButton;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, assign) NSInteger countNum;
@property (nonatomic, strong) DataArray *model;

@property (nonatomic, copy) void (^addButtonClickBlock)();

- (void)config:(DataArray *)model;

@end
