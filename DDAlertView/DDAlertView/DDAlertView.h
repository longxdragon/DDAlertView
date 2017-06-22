//
//  DDAlertView.h
//  DDAlertView
//
//  Created by longxdragon on 2017/6/21.
//  Copyright © 2017年 longxdragon. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DDAlertViewManager;


@interface DDAlertView : UIView

@property (nonatomic, strong) DDAlertViewManager *style;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(DDAlertViewManager *)style handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block;

- (instancetype)initWithTitle:(NSString *)title customView:(UIView *)customView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(DDAlertViewManager *)style handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block;

+ (instancetype)dd_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(DDAlertViewManager *)style handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block;

+ (instancetype)dd_showAlertViewWithTitle:(NSString *)title customView:(UIView *)customView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(DDAlertViewManager *)style handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block;

- (void)showInView:(UIView *)view;

- (void)show;

@end



@interface DDAlertViewManager : NSObject

+ (instancetype)defaultManager;

@property (nonatomic, assign) CGFloat minWidth;

@property (nonatomic, assign) CGFloat maxWidth;

@property (nonatomic, assign) CGFloat maxHeight;

@property (nonatomic, assign) CGFloat titleHeight;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *messageFont;

@property (nonatomic, strong) UIColor *messageColor;

@property (nonatomic, assign) CGFloat buttonItemHeight;

@property (nonatomic, strong) UIColor *buttonPressedColor;

@property (nonatomic, strong) UIColor *cancelTitleColor;

@property (nonatomic, strong) UIColor *otherTitleColor;

@property (nonatomic, strong) UIFont *cancelTitleFont;

@property (nonatomic, strong) UIFont *otherTitleFont;

@property (nonatomic, strong) UIColor *spliteColor;

@end
