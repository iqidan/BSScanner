//
//  UIView+BSAutoLayoutConstraint.h
//  BSAutoLayoutConstrait
//
//  Created by admin on 15/8/24.
//  Copyright (c) 2015年 iqidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BSAutoLayoutConstraint)

/**
 * 使约束起作用
 */
- (void)enableConstraint;
/**
 * 距离父视图的顶部距离
 */
- (void)setTop:(NSInteger)top;
/**
 * 距离父视图的左端距离
 */
- (void)setLeft:(NSInteger)left;
/**
 * 距离父视图底部的距离
 */
- (void)setBottom:(NSInteger)bottom;
/**
 * 距离父视图右端的距离
 */
- (void)setRight:(NSInteger)right;
/**
 * 设置宽度
 */
- (void)setWidth:(CGFloat)width;
/**
 * 设置高度
 */
- (void)setHeight:(CGFloat)height;
/**
 * 设置视图水平中心 = 父视图水平中心 + space
 */
- (void)setCenterXToSuperView:(NSInteger)space;
/**
 * 设置视图垂直中心 = 父视图垂直中心 + space
 */
- (void)setCenterYToSuperView:(NSInteger)space;
/**
 * 添加可视化约束
 */
-(void)addVisualConstraint:(NSString *)visualConstrantStr;
/**
 * 移除所有约束
 */
- (void)removeAllConstraint;
/**
 * 移除top约束
 */
- (void)removeTop;
/**
 * 移除left约束
 */
- (void)removeLeft;
/**
 * 移除bottom约束
 */
- (void)removeBottom;
/**
 * 移除right约束
 */
- (void)removeRight;
/**
 * 移除width约束
 */
- (void)removeWidth;
/**
 * 移除height约束
 */
- (void)removeHeight;
/**
 * 移除CenterX约束
 */
- (void)removeCenterX;
/**
 * 移除CenterY约束
 */
- (void)removeCenterY;
@end
