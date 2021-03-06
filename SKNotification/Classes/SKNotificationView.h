//
//  SKNotificationView.h
//  SKNotification
//
//  Created by Sandor Kolotenko on 02/07/2014.
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKNotificationView : UIView
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *notificationLabel;
@property (strong, nonatomic) UIButton *bigButton;

@property (readonly) NSUUID *uniqueID;
@property (nonatomic, copy) void (^completion)(void);
@property (nonatomic, copy) void (^cancelation)(void);
@property (assign) BOOL hasStopped;
@property (assign) float duration;
@property (assign) int orderNumber;

- (id)init;
- (id)initWithFrame:(CGRect)frame;
- (void)dropShadow;
@end
