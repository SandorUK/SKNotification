//
//  SKNotification.m
//  SKNotification
//
//  Created by Sandor Kolotenko on 02/07/2014.
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import "SKNotification.h"
#import "SKNotificationView.h"
#import "UIImageOverlay.h"

@implementation SKNotification

+ (instancetype)centre
{
	static id sharedClient;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedClient = [[self alloc] init];
	});
	return sharedClient;
}

- (id)init
{
    if (self = [super init]) {
        _displayedNotifications = [[NSMutableArray alloc] init];
        
        // Set default colours
        // http://www.colourlovers.com/palette/3392791/Notifications
        /*[self setColorAlert:UIColorFromRGB(0xFFBB00)];
         [self setColorFailure:UIColorFromRGB(0xCC0000)];
         [self setColorInfo:UIColorFromRGB(0x074CBC)];
         [self setColorSuccess:UIColorFromRGB(0x77B300)];*/
        
        // http://ios7colors.com/
        [self setColorAlert:UIColorFromRGB(0xFFCD02)];
        [self setColorFailure:UIColorFromRGB(0xFF1300)];
        [self setColorInfo:UIColorFromRGB(0x5856D6)];
        [self setColorSuccess:UIColorFromRGB(0x0BD318)];
        
        [self shouldIncludeStatusBar:YES];
        [self setTransparent:NO];
        [self setAlpha:1.0f];
        [self setDisplayDuration:2.5f];
        [self setMessageFont:[UIFont systemFontOfSize:13.0f]];
        [self setUseAutomaticTextColor:YES];
        [self setElastic:YES];
    }
    return self;
}

- (UIColor *)inverseColor:(UIColor*)sourceColor{
    const CGFloat *componentColors = CGColorGetComponents(sourceColor.CGColor);
    
    UIColor *invertedColor = [[UIColor alloc] initWithRed:(1.0 - componentColors[0])
                                                    green:(1.0 - componentColors[1])
                                                     blue:(1.0 - componentColors[2])
                                                    alpha:componentColors[3]];
    
    return invertedColor;
}

- (UIColor *)automaticColor:(UIColor*)sourceColor{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [sourceColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int threshold = 105;
    int bgDelta = ((red * 255.0f * 0.299f) + (green * 255.0f * 0.587f) + (blue * 255.0f * 0.114f));
    
    UIColor *textColor = ((255.0f - bgDelta) < threshold) ? [UIColor blackColor] : [UIColor whiteColor];
    
    return textColor;
}

- (CGRect)frameForLabel:(UILabel *)label {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:label.text attributes:@{NSFontAttributeName: self.messageFont}];
    CGRect frame = [attributedText boundingRectWithSize:(CGSize){label.bounds.size.width, CGFLOAT_MAX}
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                context:nil];
    return frame;
}

- (void)setImageWithName:(NSString *)imageName forType:(SKNotificationType)type{
    
    UIImage *loadedImage = [UIImage imageNamed:imageName];
    
    if (self.colorizeIcon) {
        loadedImage = [loadedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    if (loadedImage) {
        
        switch (type) {
            case SKNAlert:
                [self setImageAlert:loadedImage];
                break;
            case SKNFailure:
                [self setImageFailure:loadedImage];
                break;
            case SKNInfo:
                [self setImageInfo:loadedImage];
                break;
            case SKNSuccess:
                [self setImageSuccess:loadedImage];
                break;
            case SKNCustom:
                [self setImageCustom:loadedImage];
                break;
            default:
                break;
        }
    }
}

- (void)show:(SKNotificationType)type withLocalizedKey:(NSString *)key in:(UIViewController *)controller withCompletion:(void (^)(void))completion{
    NSString *message = NSLocalizedString(key, key);
    [self show:type withMessage:message in:controller withCompletion:completion];
}

- (void)show:(SKNotificationType)type withMessage:(NSString *)message in:(UIViewController *)controller withCompletion:(void (^)(void))completion{
    
    CGFloat bannerHeight = 35.0f;
    const CGFloat bannerLabelPadding = 5.0f;
    const CGFloat bannerImagePaddig = 3.0f;
    const CGFloat bannerImageSide = 38.0f;
    
    CGRect frame = CGRectMake(0, -bannerHeight, controller.view.frame.size.width, bannerHeight);
    
    // Setup background
    SKNotificationView *notificationView = [[SKNotificationView alloc] initWithFrame:frame];
    [notificationView setCompletion:completion];
    
    // Setup imageview
    notificationView.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(bannerImagePaddig, bannerImagePaddig, bannerImageSide, bannerImageSide)];
    [notificationView.iconView setContentMode:UIViewContentModeCenter];
    
    switch (type) {
        case SKNAlert:
            [notificationView setBackgroundColor:self.colorAlert];
            [notificationView.iconView setImage:self.imageAlert];
            break;
        case SKNFailure:
            [notificationView setBackgroundColor:self.colorFailure];
            [notificationView.iconView setImage:self.imageFailure];
            break;
        case SKNInfo:
            [notificationView setBackgroundColor:self.colorInfo];
            [notificationView.iconView setImage:self.imageInfo];
            break;
        case SKNSuccess:
            [notificationView setBackgroundColor:self.colorSuccess];
            [notificationView.iconView setImage:self.imageSuccess];
            break;
        case SKNCustom:
            [notificationView setBackgroundColor:self.colorCustom];
            [notificationView.iconView setImage:self.imageCustom];
            break;
        default:
            break;
    }
    
    if (self.isTransparent) {
        [notificationView setAlpha:self.alpha];
    }
    
    // Setup label and icon (if any)
    float labelOffsetX = bannerLabelPadding;
    
    if (notificationView.iconView.image) {
        labelOffsetX = bannerImagePaddig * 2 + bannerImageSide;
    }
    
    CGRect notificationLabelFrame = CGRectMake(labelOffsetX,
                                               bannerLabelPadding,
                                               frame.size.width - bannerLabelPadding - labelOffsetX,
                                               frame.size.height - bannerLabelPadding);
    notificationView.notificationLabel = [[UILabel alloc] initWithFrame:notificationLabelFrame];
    
    if (self.hasCustomFont) {
        [notificationView.notificationLabel setFont:self.messageFont];
    }
    
    if (self.colorizeIcon) {
        [notificationView.iconView setTintColor:self.colorIconTint];
    }
    
    if (self.automaticColor) {
        UIColor *invertedColor = [self automaticColor:notificationView.backgroundColor];
        [notificationView.notificationLabel setTextColor:invertedColor];
    }
    else{
        if (self.colorForeground) {
            [notificationView.notificationLabel setTextColor:self.colorForeground];
        }
        else{
            [notificationView.notificationLabel setTextColor:[UIColor whiteColor]];
        }
    }
    
    // Set text aligment
    [notificationView.notificationLabel setNumberOfLines:0];
    [notificationView.notificationLabel setFont:self.messageFont];
    [notificationView.notificationLabel setTextAlignment:NSTextAlignmentLeft];
    [notificationView.notificationLabel setLineBreakMode:NSLineBreakByCharWrapping];
    [notificationView.notificationLabel setText:message];
    
    // Adjust size if elastic
    if (self.isElastic) {
        CGRect frame = [self frameForLabel:notificationView.notificationLabel];
        
        if (frame.size.height <= controller.view.frame.size.height / 2) {
            
            // Setup the minimum size of the label
            if (frame.size.height <= bannerImageSide) {
                frame.size.height = bannerImageSide;
            }
            
            // Adjust label
            CGRect notificationLabelFrame = CGRectMake(labelOffsetX,
                                                       bannerLabelPadding,
                                                       frame.size.width - bannerLabelPadding,
                                                       frame.size.height);
            [notificationView.notificationLabel setFrame:notificationLabelFrame];
            
            // Resize the banner
            bannerHeight = bannerLabelPadding * 2.0f + notificationLabelFrame.size.height;
            [notificationView.notificationLabel setNumberOfLines:0];
            
            CGRect frame = CGRectMake(0, - bannerHeight, controller.view.frame.size.width, bannerHeight);
            [notificationView setFrame:frame];
            
        }
    }
    
    float statusHeight = 0.0f;
    BOOL includeStatusBar = ![UIApplication sharedApplication].statusBarHidden &&
                    ![controller isKindOfClass:[UINavigationController class]] &&
                    (_latestOffsetY == 0) && self.includeStatusBar;
    
    if (includeStatusBar) {
        // Get the statusbar height
        statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        bannerHeight += statusHeight;
    }
    
    // Adjust the label
    notificationLabelFrame = notificationView.notificationLabel.frame;
    notificationLabelFrame.origin.y += statusHeight;
    [notificationView.notificationLabel setFrame:notificationLabelFrame];
    
    // Adjust the banner
    frame = CGRectMake(0, - bannerHeight, controller.view.frame.size.width, bannerHeight);
    [notificationView setFrame:frame];
    
    // Adjust position of an icon
    CGRect iconFrame = notificationView.iconView.frame;
    iconFrame.origin.y = bannerHeight / 2.0f - bannerImageSide / 2.0f + (includeStatusBar ? statusHeight / 2.0f : 0.0f);
    [notificationView.iconView setFrame:iconFrame];
    
    [notificationView addSubview:notificationView.notificationLabel];
    [notificationView addSubview:notificationView.iconView];
    [notificationView bringSubviewToFront:notificationView.iconView];
    
    // Dismiss on tap
    notificationView.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissOnTap:)];
    [notificationView setupRecognizer];
    
    // Drop shadow
    if ([self dropsShadow]) {
        [notificationView dropShadow];
    }
    
    @synchronized(notificationView){
        [notificationView setOrderNumber:_counter];
        _counter++;
    }
    
    [controller.view addSubview:notificationView];
    
    float fracture = 0.25f;
    
    NSArray *unsortedArray = controller.view.subviews;
    NSArray *sortedArray = [unsortedArray sortedArrayUsingComparator:^(id obj1, id obj2) {
        if([obj1 isKindOfClass:[SKNotificationView class]] &&
           [obj2 isKindOfClass:[SKNotificationView class]])
        {
            if([(SKNotificationView*)obj1 orderNumber] < [(SKNotificationView*)obj2 orderNumber]){
                return NSOrderedDescending;
            }
            else{
                return NSOrderedAscending;
            }
        }
        else{
            return NSOrderedSame;
        }
    }];
    
    for(UIView* view in sortedArray){
        if([view isKindOfClass:[SKNotificationView class]]){
            SKNotificationView *subView = ((SKNotificationView*)view);
            fracture += 0.1;
            subView.duration += fracture;
        }
    }
    
    // Animate!
    [UIView animateWithDuration:.5 delay:0.1f options:UIViewAnimationOptionCurveEaseIn animations:^{
        // Slide down
        CGRect frame = notificationView.frame;
        frame.origin.y = _latestOffsetY;
        [notificationView setFrame:frame];
        
    } completion:^(BOOL finished) {
        [self slideUp:notificationView immediately:NO];
    }];
    
    _latestOffsetY = notificationView.frame.origin.y + notificationView.frame.size.height;
    
}

- (void)slideUp:(SKNotificationView *)notificationView immediately:(BOOL)immediately{
    
    float duration = 0.5f;
    float baseDuration = 0.5f;
    
    if (self.duration > duration) {
        duration = self.duration - 0.5f;
    }
    
    if(notificationView.duration > duration){
        duration = notificationView.duration;
    }
    
    if (immediately) {
        duration = .25f;
        baseDuration = .15f;
    }
    
    
    [UIView animateWithDuration:baseDuration delay:duration options:UIViewAnimationOptionCurveEaseOut animations:^{
        // Slide back up
        CGRect frame = CGRectMake(0, - notificationView.frame.size.height, notificationView.frame.size.width, notificationView.frame.size.height);
        [notificationView setFrame:frame];
    } completion:^(BOOL finished) {
        // Call completion block
        [notificationView removeFromSuperview];
        notificationView.completion;
    }];
    
    
    _latestOffsetY = notificationView.frame.origin.y - notificationView.frame.size.height;
    if (_latestOffsetY < 0) {
        _latestOffsetY = 0;
    }
}

- (void)dismissOnTap:(UIGestureRecognizer *)recognizer{
    for (SKNotificationView *notificationView in _displayedNotifications) {
        [self slideUp:notificationView immediately:YES];
    }
}

@end
