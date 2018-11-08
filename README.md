# BSScanner
	iOS 二维码、条码扫描

# Use
# 1)
	BSScanner/BSScanner/BSScanner 文件拖入工程
# 2)
	BSScannerController *scanVC = [BSScannerController new];
    __weak ViewController *weakSelf = self;
    scanVC.BSScanSuccessBlock = ^(NSString *res){
        NSLog(@"BSScanSuccessBlock res=%@", res);
    };
    scanVC.BSScanFailBlock = ^(NSString *res){
        NSLog(@"BSScanFailBlock res=%@", res);
    };
    scanVC.BSScanCancelBlock = ^(NSString *res){
        NSLog(@"BSScanCancelBlock res=%@", res);
    };
    [self presentViewController:scanVC animated:YES completion:nil];