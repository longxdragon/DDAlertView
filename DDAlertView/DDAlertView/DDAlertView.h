//
//  DDAlertView.h
//  DDAlertView
//
//  Created by longxdragon on 2017/6/21.
//  Copyright © 2017年 longxdragon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDAlertView : UIView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block;

- (instancetype)initWithTitle:(NSString *)title customView:(UIView *)customView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block;

+ (instancetype)dd_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block;

+ (instancetype)dd_showAlertViewWithTitle:(NSString *)title customView:(UIView *)customView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block;

- (void)showInView:(UIView *)view;

- (void)show;

@end
