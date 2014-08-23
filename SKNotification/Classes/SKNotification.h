//
//  SKNotification.h
//  SKNotification
//
//  Created by Sandor Kolotenko on 02/07/2014.
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SKNotificationType){
    SKNSuccess,
    SKNFailure,
    SKNAlert,
    SKNInfo,
    SKNCustom
};

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface SKNotification : NSObject
{
    NSMutableArray *_displayedNotifications;
    int _counter;
    float _latestOffsetY;
}

+ (instancetype)centre;
- (void)setImageWithName:(NSString*)imageName forType:(SKNotificationType)type;
- (void)show:(SKNotificationType)type withMessage:(NSString*)message in:(UIViewController*)controller withCompletion:(void (^)(void))completion;
- (void)show:(SKNotificationType)type withLocalizedKey:(NSString *)key in:(UIViewController *)controller withCompletion:(void (^)(void))completion;
- (void)dismissOnTap:(UIGestureRecognizer *)recognizer;

@property (strong, nonatomic) UIColor *colorSuccess;
@property (strong, nonatomic) UIColor *colorFailure;
@property (strong, nonatomic) UIColor *colorAlert;
@property (strong, nonatomic) UIColor *colorInfo;

@property (strong, nonatomic) UIImage *imageSuccess;
@property (strong, nonatomic) UIImage *imageFailure;
@property (strong, nonatomic) UIImage *imageAlert;
@property (strong, nonatomic) UIImage *imageInfo;
@property (strong, nonatomic) UIImage *imageCustom;

@property (strong, nonatomic) UIColor *colorCustom;
@property (strong, nonatomic) UIColor *colorForeground;
@property (strong, nonatomic) UIColor *colorIconTint;

@property (strong, nonatomic) UIFont  *messageFont;

@property (assign) double alpha;
@property (assign, getter = isTransparent, setter = setTransparent:) BOOL transparent;
@property (assign, getter = isElastic, setter = setElastic:) BOOL elastic;
@property (assign, getter = includesStatusBar, setter = shouldIncludeStatusBar:) BOOL includeStatusBar;
@property (assign, getter = hasCustomFont, setter = setUseCustomFont:) BOOL customFont;
@property (assign, setter = setUseAutomaticTextColor:) BOOL automaticColor;
@property (assign, setter = setColorizeIcon:) BOOL colorizeIcon;
@property (assign, getter = dropsShadow, setter = shouldDropShadow:) BOOL shadow;
@property (assign, setter = setDisplayDuration:) float duration;

@end
