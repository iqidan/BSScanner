//
//  UIView+BSAutoLayoutConstraint.m
//  BSAutoLayoutConstrait
//
//  Created by admin on 15/8/24.
//  Copyright (c) 2015年 iqidan. All rights reserved.
//

#import "UIView+BSAutoLayoutConstraint.h"

@implementation UIView (BSAutoLayoutConstraint)

/**
 * 使约束起作用
 */
- (void)enableConstraint
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

/**
 * 距离父视图的顶部距离
 */
- (void)setTop:(NSInteger)top
{
    //    NSString *topStr = [NSString stringWithFormat:@"V:|-%ld-[self]", (long)top];
    //    NSArray *topConstrait = [NSLayoutConstraint constraintsWithVisualFormat:topStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    //
    //    [self.superview addConstraints:topConstrait];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1 constant:top];
    [self.superview addConstraint:constraint];
}
/**
 * 距离父视图的左端距离
 */
- (void)setLeft:(NSInteger)left
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:left];
    [self.superview addConstraint:constraint];
    
    //    NSString *leftStr = [NSString stringWithFormat:@"H:|-%ld-[self]", (long)left];
    ////    NSArray *leftConstrait = [NSLayoutConstraint constraintsWithVisualFormat:leftStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    ////
    ////    [self.superview addConstraints:leftConstrait];
    //    [self addVisualConstraint:leftStr];
}

/**
 * 距离父视图底部的距离
 */
- (void)setBottom:(NSInteger)bottom
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-bottom];
    [self.superview addConstraint:constraint];
    //    NSString *leftStr = [NSString stringWithFormat:@"H:|-%ld-[self]", (long)left];
    //    NSArray *leftConstrait = [NSLayoutConstraint constraintsWithVisualFormat:leftStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    //
    //    [self.superview addConstraints:leftConstrait];
}
/**
 * 距离父视图右端的距离
 */
- (void)setRight:(NSInteger)right
{
    NSLayoutConstraint *constrait = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1 constant:-right];
    [self.superview addConstraint:constrait];
    //    NSString *leftStr = [NSString stringWithFormat:@"H:|-%ld-[self]", (long)left];
    //    NSArray *leftConstrait = [NSLayoutConstraint constraintsWithVisualFormat:leftStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    //
    //    [self.superview addConstraints:leftConstrait];
}

/**
 * 设置宽度
 */
- (void)setWidth:(CGFloat)width
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:width];
    [self.superview addConstraint:constraint];
    //        NSString *widthStr = [NSString stringWithFormat:@"H:[self(==%lf)]", (double)width];
    ////        NSArray *constrait = [NSLayoutConstraint constraintsWithVisualFormat:widthStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    ////
    ////        [self.superview addConstraints:constrait];
    //    [self addVisualConstraint:widthStr];
}
/**
 * 设置高度
 */
- (void)setHeight:(CGFloat)height
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:height];
    [self.superview addConstraint:constraint];
    //    NSString *heightStr = [NSString stringWithFormat:@"V:[self(==%lf)]", (double)height];
    ////    NSArray *constrait = [NSLayoutConstraint constraintsWithVisualFormat:heightStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    ////
    ////    [self.superview addConstraints:constrait];
    //    [self addVisualConstraint:heightStr];
    //    UIDevice
}

/**
 * 设置视图水平中心 = 父视图水平中心 + space
 */
- (void)setCenterXToSuperView:(NSInteger)space
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:space];
    [self.superview addConstraint:constraint];
}
/**
 * 设置视图垂直中心 = 父视图垂直中心 + space
 */
- (void)setCenterYToSuperView:(NSInteger)space
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:space];
    [self.superview addConstraint:constraint];
}


/**
 * 添加可视化约束
 */
-(void)addVisualConstraint:(NSString *)visualConstrantStr
{
    NSArray *constrait = [NSLayoutConstraint constraintsWithVisualFormat:visualConstrantStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    
    [self.superview addConstraints:constrait];
}

/**
 * 移除所有约束
 */
- (void)removeAllConstraint
{
    NSArray *constraits = [self.superview constraints];
    for(NSLayoutConstraint *constraint in constraits)
    {
        if(constraint.firstItem == self)
        {
            [self.superview removeConstraint:constraint];
        }
    }
}

/**
 * 移除top约束
 */
- (void)removeTop
{
    NSArray *constraits = [self.superview constraints];
    for(NSLayoutConstraint *constraint in constraits)
    {
        if(constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeTop)
        {
            [self.superview removeConstraint:constraint];
            break;
        }
    }
}

/**
 * 移除left约束
 */
- (void)removeLeft
{
    NSArray *constraits = [self.superview constraints];
    for(NSLayoutConstraint *constraint in constraits)
    {
        if(constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeLeft)
        {
            [self.superview removeConstraint:constraint];
            break;
        }
    }
}

/**
 * 移除bottom约束
 */
- (void)removeBottom
{
    NSArray *constraits = [self.superview constraints];
    for(NSLayoutConstraint *constraint in constraits)
    {
        if(constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeBottom)
        {
            [self.superview removeConstraint:constraint];
            break;
        }
    }
}

/**
 * 移除right约束
 */
- (void)removeRight
{
    NSArray *constraits = [self.superview constraints];
    for(NSLayoutConstraint *constraint in constraits)
    {
        if(constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeRight)
        {
            [self.superview removeConstraint:constraint];
            break;
        }
    }
}

/**
 * 移除width约束
 */
- (void)removeWidth
{
    NSArray *constraits = [self.superview constraints];
    for(NSLayoutConstraint *constraint in constraits)
    {
        if(constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeWidth)
        {
            [self.superview removeConstraint:constraint];
            break;
        }
    }
}

/**
 * 移除height约束
 */
- (void)removeHeight
{
    NSArray *constraits = [self.superview constraints];
    for(NSLayoutConstraint *constraint in constraits)
    {
        if(constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeHeight)
        {
            [self.superview removeConstraint:constraint];
            break;
        }
    }
}

/**
 * 移除CenterX约束
 */
- (void)removeCenterX
{
    NSArray *constraits = [self.superview constraints];
    for(NSLayoutConstraint *constraint in constraits)
    {
        if(constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeCenterX)
        {
            [self.superview removeConstraint:constraint];
            break;
        }
    }
}
/**
 * 移除CenterY约束
 */
- (void)removeCenterY
{
    NSArray *constraits = [self.superview constraints];
    for(NSLayoutConstraint *constraint in constraits)
    {
        if(constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeCenterY)
        {
            [self.superview removeConstraint:constraint];
            break;
        }
    }
}

@end
