//
//  DDAlertView.m
//  DDAlertView
//
//  Created by longxdragon on 2017/6/21.
//  Copyright © 2017年 longxdragon. All rights reserved.
//

#import "DDAlertView.h"

static UIImage *DDImageWithColor(UIColor *color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@interface DDAlertView ()
@property (nonatomic, weak) UIView *relationView;
@property (nonatomic, strong) UIView *containView;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSArray *otherButtonTitles;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, copy) void (^handle)(DDAlertView *alertView, NSInteger buttonIndex);
@end

@implementation DDAlertView

+ (instancetype)dd_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(DDAlertViewManager *)style handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block {
    DDAlertView *alertView = [[self alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles style:style handler:block];
    [alertView show];
    return alertView;
}

+ (instancetype)dd_showAlertViewWithTitle:(NSString *)title customView:(UIView *)customView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(DDAlertViewManager *)style handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block {
    DDAlertView *alertView = [[self alloc] initWithTitle:title customView:customView cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles style:style handler:block];
    [alertView show];
    return alertView;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(DDAlertViewManager *)style handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block {
    if (self = [super init]) {
        self.title = [title copy];
        self.message = [message copy];
        self.cancelButtonTitle = [cancelButtonTitle copy];
        self.otherButtonTitles = [otherButtonTitles copy];
        self.handle = block;
        if (style) {
            self.style = style;
        }
        [self configueViews];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title customView:(UIView *)customView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(DDAlertViewManager *)style handler:(void (^)(DDAlertView *alertView, NSInteger buttonIndex))block {
    if (self = [super init]) {
        self.title = [title copy];
        self.customView = customView;
        self.cancelButtonTitle = [cancelButtonTitle copy];
        self.otherButtonTitles = [otherButtonTitles copy];
        self.handle = block;
        if (style) {
            self.style = style;
        }
        [self configueViews];
    }
    return self;
}

- (void)showInView:(UIView *)view {
    if (self.superview) {
        return;
    }
    [[DDAlertViewManager shareManager].alerts addObject:self];
    if ([DDAlertViewManager shareManager].alerts.count > 1) {
        [self setRelationView:view];
        return;
    }
    if (view) {
        [view addSubview:self];
        [self showAnimation];
    }
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [self showInView:window];
}

#pragma mark - Private Method

- (void)configueViews {
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, [self screenWidth], [self screenHeight]);
    CGFloat width = self.style.minWidth;
    UIImage *pressedImage = DDImageWithColor(self.style.buttonPressedColor);
    
    self.containView = [UIView new];
    self.containView.backgroundColor = [UIColor whiteColor];
    self.containView.layer.masksToBounds = YES;
    self.containView.layer.cornerRadius = 10.f;
    self.containView.frame = (CGRect){0, 0, width, self.style.maxHeight};
    self.containView.center = (CGPoint){[self screenWidth]/2, [self screenHeight]/2};
    [self addSubview:self.containView];
    
    if (self.customView) {
        CGSize size = self.customView.frame.size;
        self.customView.frame = (CGRect){{0, self.style.titleHeight}, size};
        [self.containView addSubview:self.customView];
        
        width = MAX(size.width, self.style.minWidth);
        width = MIN(width, self.style.maxWidth);
        self.containView.frame = (CGRect){0, 0, width, self.containView.frame.size.height};
    }
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.title;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = self.style.titleColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = self.style.titleFont;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    titleLabel.frame = (CGRect){10, 0, self.containView.bounds.size.width - 10*2, self.style.titleHeight};
    [self.containView addSubview:titleLabel];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = self.style.spliteColor;
    topLine.frame = (CGRect){0, CGRectGetMaxY(titleLabel.frame), self.containView.frame.size.width, 0.5};
    [self.containView addSubview:topLine];
    
    CGFloat offY = CGRectGetMaxY(topLine.frame) + 5;
    UITextView *messageView;
    CGFloat messageHeight = 0;
    
    if (self.customView) {
        offY += self.customView.frame.size.height;
        offY += 5;
        
    } else if (self.message.length) {
        messageView = [UITextView new];
        messageView.text = self.message;
        messageView.backgroundColor = [UIColor clearColor];
        messageView.showsVerticalScrollIndicator = NO;
        messageView.editable = NO;
        messageView.selectable = NO;
        messageView.textColor = self.style.messageColor;
        messageView.font = self.style.messageFont;
        messageView.frame = (CGRect){10, offY, self.containView.bounds.size.width - 10*2, 0};
        
        CGSize size = [messageView sizeThatFits:messageView.frame.size];
        messageHeight = size.height;
        messageView.frame = (CGRect){messageView.frame.origin, size};
        [self.containView addSubview:messageView];
        
        offY += size.height;
        offY += 5;
        
        CGFloat buttonHeight = self.style.buttonItemHeight;
        if (self.otherButtonTitles.count > 1) {
            buttonHeight = (self.otherButtonTitles.count + 1) * self.style.buttonItemHeight;
        }
        offY += buttonHeight;
        offY = MIN(offY, self.style.maxHeight);
        messageHeight = ceil(MAX(offY - buttonHeight - 5 - messageView.frame.origin.y, 0));
        messageView.frame = (CGRect){messageView.frame.origin, {messageView.frame.size.width, messageHeight}};
        messageView.scrollEnabled = messageView.contentSize.height > messageView.frame.size.height;
        
        offY = CGRectGetMaxY(messageView.frame) + 5;
    }
    
    UIView *line = [UIView new];
    line.backgroundColor = self.style.spliteColor;
    line.frame = (CGRect){0, offY, self.containView.frame.size.width, 0.5};
    [self.containView addSubview:line];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTag:0];
    [cancelButton setTitleColor:self.style.cancelTitleColor forState:UIControlStateNormal];
    [cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:self.style.cancelTitleFont];
    [cancelButton setBackgroundImage:pressedImage forState:UIControlStateSelected];
    [cancelButton setBackgroundImage:pressedImage forState:UIControlStateHighlighted];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setFrame:(CGRect){0, offY, self.containView.frame.size.width, self.style.buttonItemHeight}];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.containView addSubview:cancelButton];
    
    if (self.otherButtonTitles.count == 0) {
        offY += cancelButton.frame.size.height;
        
    } else if (self.otherButtonTitles.count == 1) {
        [cancelButton setFrame:(CGRect){0, offY, self.containView.frame.size.width/2, self.style.buttonItemHeight}];
        
        NSString *otherStr = [self.otherButtonTitles firstObject];
        if (otherStr && otherStr.length > 0) {
            CGFloat offX = CGRectGetMaxX(cancelButton.frame);
            UIView *line = [UIView new];
            line.backgroundColor = self.style.spliteColor;
            line.frame = (CGRect){offX, offY, 0.5, cancelButton.frame.size.height};
            [self.containView addSubview:line];
            
            UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [otherBtn setTag:1];
            [otherBtn setTitleColor:self.style.otherTitleColor forState:UIControlStateNormal];
            [otherBtn setTitle:otherStr forState:UIControlStateNormal];
            [otherBtn.titleLabel setFont:self.style.otherTitleFont];
            [otherBtn setBackgroundImage:pressedImage forState:UIControlStateSelected];
            [otherBtn setBackgroundImage:pressedImage forState:UIControlStateHighlighted];
            [otherBtn setBackgroundColor:[UIColor clearColor]];
            [otherBtn setFrame:(CGRect){{offX, cancelButton.frame.origin.y}, cancelButton.frame.size}];
            [otherBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.containView addSubview:otherBtn];
        }
        offY += cancelButton.frame.size.height;
        
    } else if (self.otherButtonTitles.count > 1) {
        for (NSUInteger i = 0, max = self.otherButtonTitles.count; i < max; i++) {
            NSString *otherStr = self.otherButtonTitles[i];
            UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [otherBtn setTag:(i+1)];
            [otherBtn setTitleColor:self.style.otherTitleColor forState:UIControlStateNormal];
            [otherBtn setTitle:otherStr forState:UIControlStateNormal];
            [otherBtn.titleLabel setFont:self.style.otherTitleFont];
            [otherBtn setBackgroundImage:pressedImage forState:UIControlStateSelected];
            [otherBtn setBackgroundImage:pressedImage forState:UIControlStateHighlighted];
            [otherBtn setBackgroundColor:[UIColor clearColor]];
            [otherBtn setFrame:(CGRect){{0, offY}, cancelButton.frame.size}];
            [otherBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.containView addSubview:otherBtn];
            
            offY += otherBtn.frame.size.height;
            
            UIView *line = [UIView new];
            line.backgroundColor = self.style.spliteColor;
            line.frame = (CGRect){0, offY, self.containView.frame.size.width, 0.5};
            [self.containView addSubview:line];
        }
        [cancelButton setFrame:(CGRect){0, offY, self.containView.frame.size.width, self.style.buttonItemHeight}];
        offY += cancelButton.frame.size.height;
    }
    
    self.containView.frame = (CGRect){0, 0, width, offY};
    self.containView.center = (CGPoint){[self screenWidth]/2, [self screenHeight]/2};
}

- (void)cancelButtonClicked:(UIButton *)btn {
    if (self.handle) {
        self.handle(self, 0);
    }
    [self hide];
}

- (void)buttonClick:(UIButton *)btn {
    NSInteger index = btn.tag;
    if (self.handle) {
        self.handle(self, index);
    }
    [self hide];
}

- (void)showAnimation {
    self.containView.alpha = 0.f;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        self.containView.alpha = 1.f;
    } completion:nil];
}

- (void)hide {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containView.alpha = 0.f;

    } completion:^(BOOL finished) {
        [[DDAlertViewManager shareManager].alerts removeObject:self];
        [self removeFromSuperview];
        
        if ([DDAlertViewManager shareManager].alerts.count) {
            DDAlertView *alertView = [[DDAlertViewManager shareManager].alerts firstObject];
            UIView *view = [alertView relationView];
            if (view) {
                [view addSubview:alertView];
                [alertView showAnimation];
            }
        }
    }];
}

- (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

- (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

#pragma mark - Property Getter

- (DDAlertViewManager *)style {
    if (!_style) {
        _style = [[DDAlertViewManager alloc] init];
    }
    return _style;
}

@end





@interface DDAlertViewManager ()

@end

@implementation DDAlertViewManager

+ (instancetype)shareManager {
    static DDAlertViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DDAlertViewManager alloc] init];
    });
    return manager;
}

+ (instancetype)defaultManager {
    return [[DDAlertViewManager alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleHeight = 44;
        self.minWidth = 280;
        self.maxWidth = 300;
        self.maxHeight = [UIScreen mainScreen].bounds.size.height * 7/8;
        self.buttonItemHeight = 44;
        
        self.titleFont = [UIFont boldSystemFontOfSize:17];
        self.titleColor = [UIColor colorWithWhite:0.25 alpha:1];
        self.messageFont = [UIFont boldSystemFontOfSize:17];
        self.messageColor = [UIColor colorWithWhite:0.25 alpha:1];
        self.cancelTitleColor = [UIColor blackColor];
        self.otherTitleColor = [UIColor blackColor];
        self.cancelTitleFont = [UIFont systemFontOfSize:15.f];
        self.otherTitleFont = [UIFont systemFontOfSize:15.f];
        self.spliteColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        self.buttonPressedColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    }
    return self;
}

- (NSMutableArray *)alerts {
    if (!_alerts) {
        _alerts = [NSMutableArray array];
    }
    return _alerts;
}

@end
