//
//  BSScannerController.m
//  BSScanner
//
//  Created by iqidan on 2018/11/5.
//  Copyright © 2018 iqidan. All rights reserved.
//

#import "BSScannerController.h"
#import <AVFoundation/AVFoundation.h>
#import "BSAutoLayoutConstraint/UIView+BSAutoLayoutConstraint.h"

@interface BSScannerController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *inputDevice;
@property (nonatomic, strong) AVCaptureMetadataOutput *outputData;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preLayer;
@property (nonatomic, strong) UIButton *openTorchBtn;
@property (nonatomic, strong) UIImageView *line;

@end

@implementation BSScannerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self roateNitificationInit];
//    [self.view setBackgroundColor:[UIColor colorWithRed:0.1 green:0.5 blue:1 alpha:1]];
    [self deviceInit];
}

#pragma mark --扫描初始化 包括布局以及扫描启动等
- (void)deviceInit{
    //会话初始化
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];//也是默认值
    
    //输入设备初始化
    NSError *err;
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&err];
    
    //输出设备初始化
    self.outputData = [[AVCaptureMetadataOutput alloc] init];
    
    //添加输入输出
    if([self.session canAddInput:self.inputDevice]){
        [self.session addInput:self.inputDevice];
        if([self.session canAddOutput:self.outputData]){
            [self.session addOutput:self.outputData];
            [self startScan];
        }
    }
}
//扫描图层添加
- (void)scanLayerInit{
    [self.outputData setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //添加常用的编码格式,有特殊需求请自行添加
    [self.outputData setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]];
    self.preLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.preLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.preLayer setFrame:self.view.bounds];
    [self.view.layer addSublayer:self.preLayer];
    [self changeRotate:nil];
}

//扫描提示线
- (void)scanLineInit{

    UIView *lineBase = [[UIView alloc] init];
    [self.view addSubview:lineBase];
    const NSInteger scanLen = 250;
    
    [lineBase enableConstraint];
    [lineBase setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]];
    [lineBase setWidth:scanLen];
    [lineBase setHeight:scanLen];
    [lineBase setCenterXToSuperView:0];
    [lineBase setCenterYToSuperView:0];
    
    self.line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scanLen, 4)];
    [self.line setImage:[UIImage imageNamed:@"ScanLine"]];
    [lineBase addSubview:self.line];
    NSLog(@"frame = %f %f  %f", self.line.frame.origin.y,self.line.frame.size.height, self.line.frame.size.width);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue = [NSNumber numberWithInteger:scanLen];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 3;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.line.layer addAnimation:animation forKey:@"moveLine"];
}

//扫描相关控制按钮
- (void)scanBtnInit{
    //取消扫描
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(cancelScan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    //开关灯按钮
    if([self.device hasTorch]){
        self.openTorchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.openTorchBtn setTitle:@"开灯" forState:UIControlStateNormal];
        [self.openTorchBtn addTarget:self action:@selector(toggleTorch) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.openTorchBtn];
    }
    
    //按钮布局
    const NSInteger btnLen = 66;
    [closeBtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [closeBtn setWidth:btnLen];
    [closeBtn setHeight:btnLen];
    [closeBtn.layer setCornerRadius:btnLen/2];
    [closeBtn enableConstraint];
    [closeBtn setBottom:20];
    [closeBtn setRight:20];
    
    [self.openTorchBtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [self.openTorchBtn setWidth:btnLen];
    [self.openTorchBtn setHeight:btnLen];
    [self.openTorchBtn.layer setCornerRadius:btnLen/2];
    [self.openTorchBtn enableConstraint];
    [self.openTorchBtn setBottom:20];
    [self.openTorchBtn setLeft:20];
}


//开始扫描
- (void)startScan{
    [self scanLayerInit];
    [self scanBtnInit];
    
    //开始扫描
    [self.session startRunning];
    
    [self scanLineInit];
    
}

#pragma mark -- 相关操作事件
//取消扫描
- (void)cancelScan{
    if(self.BSScanCancelBlock){
        self.BSScanCancelBlock(@"取消扫描");
    }
    [self stopScan];
}

//停止扫描退出
- (void)stopScan{
    if(self.session){
        [self.session stopRunning];
        self.device = nil;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//开关手电筒 on:YES 开启
- (void)toggleTorch{
    if(![self.device hasTorch]){
        return;
    }
    [self.device lockForConfiguration:nil];
    if([self.device torchMode] == AVCaptureTorchModeOff){
        [self.openTorchBtn setTitle:@"关灯" forState:UIControlStateNormal];
        [self.device setTorchMode:AVCaptureTorchModeOn];
    }else{
        [self.openTorchBtn setTitle:@"开灯" forState:UIControlStateNormal];
        [self.device setTorchMode:AVCaptureTorchModeOff];
    }
    [self.device unlockForConfiguration];
}

#pragma mark -- 屏幕旋转通知
- (void)roateNitificationInit{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

//根据不同方向来设置相机的图层
- (void)changeRotate:(NSNotification*)noti {
    UIDeviceOrientation oritation = [[UIDevice currentDevice] orientation];
    [self.preLayer setFrame:self.view.bounds];
    if(oritation==UIDeviceOrientationPortrait){
//        NSLog(@"UIDeviceOrientationPortrait=%d", UIDeviceOrientationPortrait);
        [[self.preLayer connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
    }else if(oritation==UIDeviceOrientationPortraitUpsideDown){
//        NSLog(@"UIDeviceOrientationPortraitUpsideDown=%d", AVCaptureVideoOrientationPortraitUpsideDown);
        [[self.preLayer connection] setVideoOrientation:AVCaptureVideoOrientationPortraitUpsideDown];
    }
    else if(oritation==UIDeviceOrientationLandscapeRight){
//        NSLog(@"UIDeviceOrientationLandscapeRight=%d", UIDeviceOrientationLandscapeRight);
        [[self.preLayer connection] setVideoOrientation:AVCaptureVideoOrientationLandscapeLeft];
    }
    else if(oritation==UIDeviceOrientationLandscapeLeft){
//        NSLog(@"UIDeviceOrientationLandscapeLeft=%d", UIDeviceOrientationLandscapeLeft);
        [[self.preLayer connection] setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
    }
}

#pragma mark --AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
//    NSLog(@"metadataObjects = %@ connection=%@", metadataObjects, connection);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
        NSString *message = [metadataObject stringValue];
//        NSLog(@"message=%@", message);
        if(self.BSScanSuccessBlock){
            self.BSScanSuccessBlock(message);
        }
    }else{
        if(self.BSScanFailBlock){
            self.BSScanFailBlock(@"扫描失败");
        }
    }
    [self stopScan];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
