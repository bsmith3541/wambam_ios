//
//  InfoWindow.h
//  Wambam
//
//  Created by Brandon Smith on 2/19/14.
//  Copyright (c) 2014 Wambam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoWindow : UIView
    @property(nonatomic, weak) NSString *name;
    @property(nonatomic, weak) NSString *description;
    @property(nonatomic, weak) NSString *phone;
    @property(nonatomic, weak) UIImage *placeImage;
    //@property(nonatomic, weak) IBOutlet UILabel *description;
@end
