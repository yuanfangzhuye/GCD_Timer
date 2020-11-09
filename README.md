# GCD_Timer
使用 GCD 计时器

# 使用方式

直接将 `CLCountButton` 拖入工程

```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CLCountButton *button = [CLCountButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 120) / 2, 200, 120, 40);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
    
- (void)timeButtonClick:(CLCountButton *)sender {
    [sender startCount];
}
```

# app 进入后台处理

app 如果进入后台，计时器会暂停，苹果给出的三种类型的程序能够保持在后台运行：音频播放类，位置更新类等，这里采用 `音频播放` 的方式来解决

- 在 `info.plist` 中添加 `Required background modes` 键，value 为 `App plays audio or streams audio/video using AirPlay`
- 在 `TARGETS` -> `Signing&Capabilities` -> `Background Modes` 勾选 `Audio, AirPlay, and Picture in Picture`
- 在 `AppDelegate.m` 中导入 `#import <AVFoundation/AVFoundation.h>` 添加如下代码：

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: NULL];
    [[AVAudioSession sharedInstance] setActive: YES error: NULL];
    
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIApplication *taskApplication = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier backgroundTask;
    backgroundTask = [taskApplication beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (backgroundTask != UIBackgroundTaskInvalid) {
                backgroundTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (backgroundTask != UIBackgroundTaskInvalid) {
                backgroundTask = UIBackgroundTaskInvalid;
            }
        });
    });
}
```