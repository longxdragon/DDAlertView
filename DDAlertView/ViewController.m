//
//  ViewController.m
//  DDAlertView
//
//  Created by longxdragon on 2017/6/21.
//  Copyright © 2017年 longxdragon. All rights reserved.
//

#import "ViewController.h"
#import "DDAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(id)sender {
    UITextView *textView = [UITextView new];
    textView.text = @"打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上";
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = CGRectMake(0, 0, 300, 300);
    
    [DDAlertView dd_showAlertViewWithTitle:@"提示" customView:textView cancelButtonTitle:@"取消" otherButtonTitles:@[@"1", @"2"] style:[DDAlertViewManager defaultManager] handler:^(DDAlertView *alertView, NSInteger buttonIndex) {
        
    }];
}

- (IBAction)showNormalAlert:(id)sender {
    [DDAlertView dd_showAlertViewWithTitle:@"提示" message:@"打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上打死你的骄傲可能大家卡萨诺的空间那上" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] style:[DDAlertViewManager defaultManager] handler:^(DDAlertView *alertView, NSInteger buttonIndex) {
        
    }];
}

@end
