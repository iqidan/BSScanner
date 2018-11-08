//
//  BSScannerController.h
//  BSScanner
//
//  Created by iqidan on 2018/11/5.
//  Copyright © 2018 iqidan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSScannerController : UIViewController
@property (nonatomic, copy) void(^BSScanSuccessBlock)(NSString *res);
@property (nonatomic, copy) void(^BSScanFailBlock)(NSString *err);
@property (nonatomic, copy) void(^BSScanCancelBlock)(NSString *res);
@end

NS_ASSUME_NONNULL_END
