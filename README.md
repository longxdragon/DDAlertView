DDAlertView
==============

A custom alert view what can be setting custom stype and shown in queue.

Usage
==============

### Basic
```objc
[DDAlertView dd_showAlertViewWithTitle:@"Tips" message:@"Messages" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"OK"] style:[DDAlertViewManager defaultManager] handler:^(DDAlertView *alertView, NSInteger buttonIndex) {
}];
```

### Custom content view
```objc
UITextView *textView = [UITextView new];
textView.text = @"Custom content view";
textView.font = [UIFont systemFontOfSize:15];
textView.frame = CGRectMake(0, 0, 300, 300);
    
[DDAlertView dd_showAlertViewWithTitle:@"Tips" customView:textView cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"1", @"2"] style:[DDAlertViewManager defaultManager] handler:^(DDAlertView *alertView, NSInteger buttonIndex) {
}];
```

If you want to set the theme of alertView, just use `DDAlertViewManager` to style. Also, use `defaultManager` to get the default style.

```objc
DDAlertViewManager *style = [[DDAlertViewManager alloc] init];
style.cancelTitleColor = [UIColor redColor];
            
[DDAlertView dd_showAlertViewWithTitle:@"Tips" message:@"Messages" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"OK"] style:style handler:^(DDAlertView *alertView, NSInteger buttonIndex) {
}];
```
