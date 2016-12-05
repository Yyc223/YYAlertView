
#import "TWLAlertView.h"
#define k_w [UIScreen mainScreen].bounds.size.width
#define k_h [UIScreen mainScreen].bounds.size.height
@implementation TWLAlertView

#define customYellow [UIColor colorWithRed:240/255.0 green:130/255.0 blue:0/255.0 alpha:1]
#define textGray [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1]
#define borderGray [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]
#define customGreen [UIColor colorWithRed:35/255.0 green:188/255.0 blue:35/255.0 alpha:1]
#define customred [UIColor colorWithRed:254/255.0 green:48/255.0 blue:68/255.0 alpha:1]
#define customGray [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1]
#define backgroundGray [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#pragma mark - 初始化
-(void)setupWithTitle:(NSString *) title contentStr:(NSArray *)contentStrs alertTag:(NSInteger)tagAlert
{
    _title = title;
    _contentArray = contentStrs;
    _alertTag = tagAlert;
}
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        //创建遮罩
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, k_w, k_h)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blackClick)];
        [self.blackView addGestureRecognizer:tap];
        [self addSubview:_blackView];
        //创建alert
        self.alertview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 250)];
        self.alertview.center = self.center;
        self.alertview.layer.cornerRadius = 17;
        self.alertview.clipsToBounds = YES;
        self.alertview.backgroundColor = [UIColor whiteColor];
        [self addSubview:_alertview];
        [self exChangeOut:self.alertview dur:0.6];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _tipLable = [[UILabel alloc]initWithFrame:CGRectMake(0,0,270,43)];
    _tipLable.textAlignment = NSTextAlignmentCenter;
    [_tipLable setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    _tipLable.text = _title;
    [_tipLable setFont:[UIFont systemFontOfSize:18]];
    [_tipLable setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
    [self.alertview addSubview:_tipLable];
    
    [self creatViewInAlert];//内部视图控件
    self.alertview.center = CGPointMake(self.center.x, self.center.y);
    [self createBtnTitle:@[@"取消",@"确定"]];
}


- (void)creatViewInAlert
{
    UILabel *redMessageLabel = [[UILabel alloc] init];
    CGFloat redMessageLabelH = 30;
    CGFloat widthMargin = 20;
    CGFloat heightMargin = 8;
    redMessageLabel.frame = CGRectMake(widthMargin, _tipLable.frame.origin.y + _tipLable.frame.size.height, self.alertview.frame.size.width - 2 * widthMargin, 0);
    if (self.redMessage.length>0) {//如果有红色信息
        redMessageLabel.frame = CGRectMake(widthMargin, _tipLable.frame.origin.y + _tipLable.frame.size.height, self.alertview.frame.size.width - 2 * widthMargin , redMessageLabelH);
        redMessageLabel.text = self.redMessage;
        redMessageLabel.numberOfLines = 0;
        redMessageLabel.font = [UIFont boldSystemFontOfSize:15];
        redMessageLabel.textColor = customred;
    }
    [self.alertview addSubview:redMessageLabel];
    
    for (int i = 0; i < self.contentArray.count; i ++) {
        CGFloat firsty = _tipLable.frame.size.height + redMessageLabel.frame.size.height;
        NSInteger count = self.contentArray.count;
        CGFloat labelH = (250 - firsty - 48 - (count-1)*heightMargin)/count;
        CGFloat Y = firsty + i * (labelH + heightMargin);
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(widthMargin, Y, self.alertview.frame.size.width - 2 * widthMargin, labelH)];
        [contentLabel setAttributedText:_contentArray[i]];
        contentLabel.numberOfLines = 0;
        contentLabel.textAlignment = NSTextAlignmentLeft;
        [self.alertview addSubview:contentLabel];
    }
}
#pragma mark - button事件

- (void)createBtnTitle:(NSArray *)titleArr
{
    CGFloat m = self.alertview.frame.size.width;
    for (int i=0; i<titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+i*(20+(m-60)/2), self.alertview.frame.size.height-48, (m-60)/2, 33);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = 100+i;
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        btn.backgroundColor = i == 0 ? customGreen : customred;
        [self.alertview addSubview:btn];
    }
}

-(void)clickButton:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didClickButtonAtIndex:alertTag:)]) {
        [self.delegate didClickButtonAtIndex:button.tag alertTag:_alertTag];
    }
    [self cancleView];
}

#pragma mark - 弹出动画

-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

- (void)blackClick
{
    [self cancleView];
}
- (void)cancleView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertview = nil;
    }];
    
}
@end
