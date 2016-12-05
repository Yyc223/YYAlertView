//
//  ViewController.m
//  YYMessageDemo
//
//  Created by iOShengold on 2016/11/30.
//  Copyright © 2016年 iOSyyc. All rights reserved.
//

#import "ViewController.h"
#import "TWLAlertView.h"
@interface ViewController ()<TWlALertviewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonClick:(id)sender {
    
    NSString *attrStr1 = @"30";
    NSString *strmsg1 = [NSString stringWithFormat:@"委托数量%@",attrStr1];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:strmsg1];
   NSRange range = [strmsg1 rangeOfString:attrStr1];
   [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(range.location, range.length)];
    
    NSString *attrStr2  = @"402222";
    NSString *strmsg2 = [NSString stringWithFormat:@"委托价格%@",attrStr2];
    NSMutableAttributedString *str2 = [self  attrMsgWithNormalMessage:strmsg2 attrmsg:attrStr2];
    
    NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc] initWithString:@"预扣保证金"];
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:@"委托价格"];
    
    [self loadAlertView:@"白银" contentStrs:@[str1,str2,str3,str4] redMessage:@"" alertTag:1];
    
}

- (NSMutableAttributedString *)attrMsgWithNormalMessage:(NSString *)msg attrmsg:(NSString *)attrStr
{
    NSMutableAttributedString *attrtemp = [[NSMutableAttributedString alloc] initWithString:msg];
    NSRange range = [msg rangeOfString:attrStr];
    [attrtemp addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, range.length)];
    return attrtemp;
}
- (void)loadAlertView:(NSString *)title contentStrs:(NSArray *)contents redMessage:(NSString *)redmsg alertTag:(NSInteger)tag
{
    
    TWLAlertView *alertView = [[TWLAlertView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [alertView setupWithTitle:title contentStr:contents alertTag:tag];
    alertView.delegate = self;
    alertView.redMessage =redmsg;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview: alertView];
    
}
-(void)didClickButtonAtIndex:(NSUInteger)index alertTag:(NSInteger)alertTag
{
    switch (index) {
        case 101:
            NSLog(@"Click ok");
            break;
        case 100:
            NSLog(@"Click cancle");
            
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
