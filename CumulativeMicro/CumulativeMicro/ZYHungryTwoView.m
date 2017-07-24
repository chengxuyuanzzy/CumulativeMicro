//
//  ZYHungryTwoView.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/7/17.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYHungryTwoView.h"
#import "ZYHungryRightCell.h"
#import "ZYHungryLeftCell.h"

@interface ZYHungryTwoView ()<UITableViewDelegate, UITableViewDataSource, CAAnimationDelegate> {
    CGFloat centerX;
}

@property (nonatomic, strong) UIView *topView;
//标题
@property (nonatomic, strong) UILabel *titleLabel;
/** 顶部imageView */
@property (nonatomic, strong) UIImageView *topImageView;
/** icon图片 */
@property (nonatomic, strong) UIImageView *iconImageView;
/** 公告 */
@property (nonatomic, strong) UILabel *tipLabel;
/** 蜂鸟 */
@property (nonatomic, strong) UILabel *distributionLabel;
/** 新用户label */
@property (nonatomic, strong) UILabel *newUserLabel;
/** 新用户labelView */
@property (nonatomic, strong) UIView *newUserView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) ZYHungryModel *model;

@property (nonatomic, assign) CGFloat endPoint_x;
@property (nonatomic, assign) CGFloat endPoint_y;
@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, strong) UIBezierPath *path;


@end

@implementation ZYHungryTwoView

- (instancetype)initWithModel:(ZYHungryViewModel *)viewModel model:(ZYHungryModel *)model {
    self = [super init];
    if (self) {
        self.model = (ZYHungryModel *)model;
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.topView];
    [self.topView addSubview:self.topImageView];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.iconImageView];
    [self.topView addSubview:self.tipLabel];
    [self.topView addSubview:self.distributionLabel];
    [self.topView addSubview:self.newUserView];
    [self.newUserView addSubview:self.newUserLabel];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.leftTableView];
    [self.bottomView addSubview:self.rightTableView];
    
    centerX = self.titleLabel.center.x;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.model.data.count;
    }else {
        return self.model.data[section].dataArray.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.leftTableView) {
        return 1;
    }else {
        return self.model.data.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return Verticl*55;
    }else {
        return Verticl*90;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 0.001;
    }else {
        return Verticl*30;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = nil;
    if (tableView == self.leftTableView) {
    }else {
        headerView = [[UIView alloc] init];
        headerView.backgroundColor = kUIColorFromRGB(0xf8f8f8);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, Verticl*30)];
        label.text = self.model.data[section].storeName;
        label.textColor = kUIColorFromRGB(0x666666);
        [headerView addSubview:label];
    }
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    if (tableView == self.leftTableView) {
        ZYHungryLeftCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (!cell1) {
            cell1 = [[ZYHungryLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID1"];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell1 config:self.model.data[indexPath.row].storeName];
        cell1.backgroundColor = kUIColorFromRGB(0xf8f8f8);
        return cell1;
    }else {
        ZYHungryRightCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[ZYHungryRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell config:self.model.data[indexPath.section].dataArray[indexPath.row]];
        
        __weak __typeof(&*cell) weakCell = cell;
        cell.addButtonClickBlock = ^{
            CGRect parentRect = [weakCell convertRect:weakCell.addButton.frame toView:self];
            [self joinCartAnimationWithRect:parentRect];
        };
        return cell;
    }
}

- (void)joinCartAnimationWithRect:(CGRect)rect {
    _endPoint_x = 35;
    _endPoint_y = HEIGHT-35;
    
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPoint_x, _endPoint_y)
             controlPoint1:CGPointMake(startX, startY)
             controlPoint2:CGPointMake(startX - 180, startY - 200)];
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = kUIColorFromRGB(0x3190e8).CGColor;
    _dotLayer.frame = CGRectMake(-20, -20, Level*18, Level*18);
    _dotLayer.cornerRadius = Level*9;
    [self.layer addSublayer:_dotLayer];
    [self groupAnimation];
}
#pragma mark - 组合动画
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.5f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.5f];
}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    [layerAnimation removeAllAnimations];
}

- (void)panAction:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);
    CGPoint tran = [recognizer locationInView:self];
    
    //    限制屏幕范围：
    newCenter.y = MAX(recognizer.view.frame.size.height/2+64, newCenter.y);
    newCenter.y = MIN(self.frame.size.height - recognizer.view.frame.size.height/2+Verticl*178-64, newCenter.y);
    newCenter.x = MAX(recognizer.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(self.frame.size.width - recognizer.view.frame.size.width/2,newCenter.x);
    NSLog(@"%f", newCenter.y);

    if (self.rightTableView.contentOffset.y == 0) {
        recognizer.view.center = newCenter;
        //title 移动公式：x-  title中心点距屏幕中心点*当前移动距离／bottomView滑动总距离 y-  title中心点距最上中心点*当前移动距离／bottomView滑动总距离
        //当前滑动距离
        CGFloat nowLong = Verticl*479.5-newCenter.y;
        self.titleLabel.center = CGPointMake(centerX-(((centerX-WIDTH/2)*nowLong)/(Verticl*114)), Verticl*75-((Verticl*36*nowLong)/(Verticl*114)));
        self.newUserView.y = (64+Verticl*81)-(Verticl*81*nowLong)/(Verticl*114);
        self.tipLabel.x = self.titleLabel.x;
        self.tipLabel.y = self.titleLabel.y+self.titleLabel.kHeight;
        self.distributionLabel.x = self.tipLabel.x;
        self.distributionLabel.y = self.tipLabel.y+self.tipLabel.kHeight;
        //titleLabel横向移动距离
        CGFloat titleLevel = self.titleLabel.x-self.iconImageView.kWidth-Level*30;
        if (titleLevel > 0) {
            self.iconImageView.x = Level*15+titleLevel;
        }
        self.iconImageView.y = self.titleLabel.y-Verticl*6;
        self.iconImageView.alpha = 1-nowLong/(Verticl*114);
        self.iconImageView.kWidth = Level*81-((Level*20*nowLong)/(Verticl*114));
        self.iconImageView.kHeight = self.iconImageView.kWidth;
        self.tipLabel.alpha = self.iconImageView.alpha;
        self.distributionLabel.alpha = self.tipLabel.alpha;
    }
    if (newCenter.y - Verticl*365.5 < 0.1) {
        CGFloat trans = recognizer.view.center.y-tran.y;
        if (trans < 0) {
            trans = 0;
        }
        self.rightTableView.contentOffset = CGPointMake(0, trans);
        
        if (self.rightTableView.contentOffset.y > 0) {
            self.rightTableView.scrollEnabled = YES;
            self.leftTableView.scrollEnabled = YES;
        }else {
            
            self.rightTableView.scrollEnabled = NO;
            self.leftTableView.scrollEnabled = NO;
        }
    }else {
        if (self.rightTableView.contentOffset.y > 0) {
            CGFloat trans = recognizer.view.center.y-tran.y;
            if (trans < 0) {
                trans = 0;
            }
            self.rightTableView.contentOffset = CGPointMake(0, trans);
        }else {
//            recognizer.view.center = newCenter;
            self.rightTableView.scrollEnabled = NO;
            self.leftTableView.scrollEnabled = NO;
        }
    }
    [recognizer setTranslation:CGPointZero inView:self];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _rightTableView) {
        if (_rightTableView.indexPathsForVisibleRows.count >= 1) {
            NSIndexPath *indexPath = _rightTableView.indexPathsForVisibleRows[1];
            [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        self.rightTableView.scrollEnabled = YES;
        [self.rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }else {
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.rightTableView.contentOffset.y == 0) {
        self.rightTableView.scrollEnabled = NO;
        self.leftTableView.scrollEnabled = NO;
    }
}
#pragma - lazyLoad
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, Verticl*178+64)];
        _topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topView];
    }
    return _topView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Level*111, Verticl*6+64, Level*200, Verticl*20)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:Level*20];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:Level*20]};
        NSString *str = @"扬州炒饭";
        CGSize textSize = [str boundingRectWithSize:CGSizeMake(Level*300, Verticl*300) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        [_titleLabel setFrame:CGRectMake(Level*111, Verticl*6+64, textSize.width, textSize.height)];
        _titleLabel.text = str;
    }
    return _titleLabel;
}

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64+Verticl*81-Verticl*10)];
        _topImageView.backgroundColor = [UIColor purpleColor];
    }
    return _topImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Level*15, 64, Level*81, Level*81)];
        _iconImageView.image = [UIImage imageNamed:@"macDog.png"];
        _iconImageView.layer.cornerRadius = Level*5;
    }
    return _iconImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.y+self.titleLabel.kHeight, WIDTH-Level*115, Verticl*20)];
        _tipLabel.text = @"公告：欢迎光临，用餐高峰期请提前下单，谢谢";
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:Level*12];
    }
    return _tipLabel;
}

- (UILabel *)distributionLabel {
    if (!_distributionLabel) {
        _distributionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tipLabel.x, self.tipLabel.y+self.tipLabel.kHeight, self.tipLabel.kWidth, self.tipLabel.kHeight)];
        _distributionLabel.text = @"蜂鸟专送，约33分钟";
        _distributionLabel.textColor = [UIColor whiteColor];
        _distributionLabel.font = [UIFont systemFontOfSize:Level*11];
    }
    return _distributionLabel;
}

- (UIView *)newUserView {
    if (!_newUserView) {
        _newUserView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+Verticl*81, WIDTH, Verticl*40)];
        _newUserView.backgroundColor = [UIColor whiteColor];
    }
    return _newUserView;
}

- (UILabel *)newUserLabel {
    if (!_newUserLabel) {
        _newUserLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.x, Verticl*10, Level*350, Verticl*20)];
        _newUserLabel.text = @"新用户下单立减23.0元(不与其它活动共享)";
        _newUserLabel.textColor = [UIColor blackColor];
        _newUserLabel.font = [UIFont systemFontOfSize:Level*12];
    }
    return _newUserLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Verticl*178, WIDTH, HEIGHT-64)];
        _bottomView.backgroundColor = [UIColor greenColor];
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [_bottomView addGestureRecognizer:panGes];
    }
    return _bottomView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(Level*80, Verticl*50, WIDTH-Level*80, self.bottomView.kHeight-Verticl*50) style:UITableViewStyleGrouped];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.scrollEnabled = NO;
        _rightTableView.bounces = NO;
        _rightTableView.sectionFooterHeight = 0.001;
    }
    return _rightTableView;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Verticl*50, Level*80, self.bottomView.kHeight-Verticl*50) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.scrollEnabled = NO;
        [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
    return _leftTableView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
