//
//  DDAlertView.m
//  DDAlertView
//
//  Created by longxdragon on 2017/6/21.
//  Copyright © 2017年 longxdragon. All rights reserved.
//

#import "DDAlertView.h"

@interface DDAlertView ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSArray *otherButtonTitles;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, copy) void (^handle)(DDAlertView *alertView, NSInteger buttonIndex);
@end

@implementation DDAlertView

+ (instancetype)dd_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block {
    DDAlertView *alertView = [[self alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles handler:block];
    [alertView show];
    return alertView;
}

+ (instancetype)dd_showAlertViewWithTitle:(NSString *)title customView:(UIView *)customView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block {
    DDAlertView *alertView = [[self alloc] initWithTitle:title customView:customView cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles handler:block];
    [alertView show];
    return alertView;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block {
    if (self = [super init]) {
        self.title = [title copy];
        self.message = [message copy];
        self.cancelButtonTitle = [cancelButtonTitle copy];
        self.otherButtonTitles = [otherButtonTitles copy];
        self.handle = block;
        
        [self configueViews];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title customView:(UIView *)customView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block {
    if (self = [super init]) {
        self.title = [title copy];
        self.customView = customView;
        self.cancelButtonTitle = [cancelButtonTitle copy];
        self.otherButtonTitles = [otherButtonTitles copy];
        self.handle = block;
        
        [self configueViews];
    }
    return self;
}

- (void)showInView:(UIView *)view {
    
}

- (void)show {
    
}

#pragma mark - Private Method

- (void)configueViews {
    
}

@end
