//
//  CLCountButton.m
//  GCD_Timer
//
//  Created by lab team on 2020/11/9.
//

#import "CLCountButton.h"

@interface CLCountButton ()

@property (nonatomic, assign) NSInteger totalSeconds;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation CLCountButton

//重写 initWithFrame: 初始化一些数据
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.totalSeconds = 120;
    }
    
    return self;
}

//开始倒计时
- (void)startCount {
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        
        if (self.totalSeconds <= 1) {
            [self endCount];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = NO;
                self.backgroundColor = [UIColor lightGrayColor];
                [self setTitle:[NSString stringWithFormat:@"重新发送（%ld）", (long)self.totalSeconds] forState:UIControlStateDisabled];
            });
            self.totalSeconds--;
        }
    });
    dispatch_resume(self.timer);
}

//结束倒计时
- (void)endCount {
    dispatch_source_cancel(self.timer);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.enabled = YES;
        self.backgroundColor = [UIColor redColor];
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
    });
    
    self.totalSeconds = 120;
}

@end
