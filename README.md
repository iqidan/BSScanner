# BSScanner
	iOS 二维码、条码扫描
	采用系统AVFoundation框架自带的扫描功能, 支持横竖屏(需iOS7以上)

# Use
## 1)添加文件
	将文件夹BSScanner/BSScanner/BSScanner 拖入工程
## 2)使用
	BSScannerController *scanVC = [BSScannerController new];
    __weak ViewController *weakSelf = self;
    //成功
    scanVC.BSScanSuccessBlock = ^(NSString *res){
        NSLog(@"BSScanSuccessBlock res=%@", res);
    };
    //失败
    scanVC.BSScanFailBlock = ^(NSString *res){
        NSLog(@"BSScanFailBlock res=%@", res);
    };
    //取消
    scanVC.BSScanCancelBlock = ^(NSString *res){
        NSLog(@"BSScanCancelBlock res=%@", res);
    };
    [self presentViewController:scanVC animated:YES completion:nil];

# Effect
## 1测试页
	![image](https://github.com/iqidan/BSScanner/blob/master/BSScanner/imgs/BSScanner1.png)
## 2竖屏
	![image](https://github.com/iqidan/BSScanner/blob/master/BSScanner/imgs/BSScanner2.png)
## 3横屏
	![image](https://github.com/iqidan/BSScanner/blob/master/BSScanner/imgs/BSScanner3.png)
	
