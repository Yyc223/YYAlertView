
#import <UIKit/UIKit.h>
@protocol TWlALertviewDelegate<NSObject>
@optional
-(void)didClickButtonAtIndex:(NSUInteger)index alertTag:(NSInteger)alertTag;
@end
@interface TWLAlertView : UIView<UITextFieldDelegate>
/** 标记 */
@property (nonatomic, assign) NSInteger alertTag;
/* 黑色遮罩 */
@property (nonatomic,strong) UIView *blackView;
/* 弹框 */
@property (strong,nonatomic) UIView *alertview;
/** 信息数组 */
@property (nonatomic, strong) NSArray *contentArray;
/** 红色提示 */
@property (nonatomic, strong) NSString *redMessage;
/*提示信息Label*/
@property (nonatomic,strong) UILabel *tipLable;
/*提示信息*/
@property (strong,nonatomic) NSString *title;
@property (weak,nonatomic) id<TWlALertviewDelegate> delegate;
//如果没有title 传空值@""
-(void)setupWithTitle:(NSString *) title contentStr:(NSArray *)contentStrs alertTag:(NSInteger)tagAlert;
@end
