//
//  ViewController.m
//  BSScanner
//
//  Created by iqidan on 2018/11/5.
//  Copyright © 2018 iqidan. All rights reserved.
//

#import "ViewController.h"
#import "BSScanner/BSScannerController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (assign, nonatomic) UInt32 soundId;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.soundId = 1007;
}
#pragma mark -- 扫描测试
- (IBAction)scan:(id)sender {
    BSScannerController *scanVC = [BSScannerController new];
    __weak ViewController *weakSelf = self;
    //成功
    scanVC.BSScanSuccessBlock = ^(NSString *res){
        NSLog(@"BSScanSuccessBlock res=%@", res);
        [weakSelf.contentTF setText:res];
    };
    //失败
    scanVC.BSScanFailBlock = ^(NSString *res){
        NSLog(@"BSScanFailBlock res=%@", res);
        [weakSelf.contentTF setText:res];
    };
    //取消
    scanVC.BSScanCancelBlock = ^(NSString *res){
        NSLog(@"BSScanCancelBlock res=%@", res);
        [weakSelf.contentTF setText:res];
    };
    [self presentViewController:scanVC animated:YES completion:nil];
}


#pragma mark --系统声音测试
- (IBAction)upper:(id)sender {
    AudioServicesPlaySystemSoundWithCompletion(self.soundId, nil);
    self.soundId -= 1;
    NSLog(@"soundId=%d", self.soundId);
}

- (IBAction)next:(id)sender {
    AudioServicesPlaySystemSoundWithCompletion(self.soundId, nil);
    self.soundId += 1;
    NSLog(@"soundId=%d", self.soundId);
}

@end
