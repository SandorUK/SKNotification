SKNotification
==============

for CocoaPods
______________

Nice and easy customisable unobtrusive in-app notifications.

Customisation:
* Autoresizing for large text
* Support for localization keys (NSLocalizedString)
* Colours and icons for various statuses (e.g. Alert, Failure)
* Notification without icon
* Custom fonts supported
* Translucent notifications supported
* Multiple notifications on one screen

![alt text](http://files.softicons.com/download/toolbar-icons/mono-general-icons-by-custom-icon-design/png/64x64/alert.png "Alert")
*Still under development, watchout for minor bugs. Please report to issues if found*

Usage:

There are two ways to display a notification: using a localization key or a direct string

Here are the method signatures and an example of usage

```
- (void)show:(SKNotificationType)type withMessage:(NSString*)message in:(UIViewController*)controller withCompletion:(void (^)(void))completion;
- (void)show:(SKNotificationType)type withLocalizedKey:(NSString *)key in:(UIViewController *)controller withCompletion:(void (^)(void))completion;


[[SKNotification centre] show:SKNSuccess
                      withMessage:@"Alert, your location is too far from the actual address."
                               in:self withCompletion:^{
                                   NSLog(@"Completed 2");
                               }];
    
```

How it looks like with default colours, which are fully customisable:

![alt text](https://raw.githubusercontent.com/SandorUK/SKNotification/master/screen1.png "Screen1 1")

![alt text](https://raw.githubusercontent.com/SandorUK/SKNotification/master/screen2.png "Screen1 2")

![alt text](https://raw.githubusercontent.com/SandorUK/SKNotification/master/screen3.png "Screen1 3")

Notification types:
```
typedef NS_ENUM(NSInteger, SKNotificationType){
    SKNSuccess,
    SKNFailure,
    SKNAlert,
    SKNInfo,
    SKNCustom
};
```
Additional options and usage:
```
[[SKNotification centre] setImageWithName:@"alert" forType:SKNAlert];
[[SKNotification centre] setImageWithName:@"success" forType:SKNSuccess];
[[SKNotification centre] setImageWithName:@"failure" forType:SKNFailure];
[[SKNotification centre] setImageWithName:@"info" forType:SKNInfo];
[[SKNotification centre] setDisplayDuration:1.85f];
[[SKNotification centre] shouldDropShadow:YES];
[[SKNotification centre] setMessageFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];

[[SKNotification centre] setTransparent:NO];
[[SKNotification centre] setAlpha:1.0f];
[[SKNotification centre] setDisplayDuration:2.5f];
[[SKNotification centre] setMessageFont:[UIFont systemFontOfSize:13.0f]];
[[SKNotification centre] setUseAutomaticTextColor:YES];
[[SKNotification centre] setElastic:YES];
```
