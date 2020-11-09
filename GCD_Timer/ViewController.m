//
//  ViewController.m
//  GCD_Timer
//
//  Created by lab team on 2020/11/9.
//

#import "ViewController.h"
#import "CLCountButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CLCountButton *button = [CLCountButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 120) / 2, 200, 120, 40);
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)timeButtonClick:(CLCountButton *)sender {
    [sender startCount];
}

@end
