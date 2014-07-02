//
//  SKNotificationView.m
//  SKNotification
//
//  Created by Sandor Kolotenko on 02/07/2014.
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import "SKNotificationView.h"

@implementation SKNotificationView

- (id)init{
    self = [super init];
    
    if (self) {
        _uniqueID = [NSUUID UUID];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        _uniqueID = [NSUUID UUID];
    }
    
    return self;
}

- (void)dropShadow{
    [self.layer setShadowOffset:CGSizeMake(0.0f, 2.0f)];
    [self.layer setShadowRadius:3.5f];
    [self.layer setShadowColor:self.backgroundColor.CGColor];
    [self.layer setShadowOpacity:0.6f];
}

- (void)setupRecognizer{
    if (self.tapRecognizer) {
        [self.tapRecognizer setNumberOfTapsRequired:1];
        [self.tapRecognizer setCancelsTouchesInView:NO];
        [self addGestureRecognizer:self.tapRecognizer];
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        
        [self.notificationLabel setUserInteractionEnabled:YES];
        [self.iconView setUserInteractionEnabled:YES];
    }
}
@end
