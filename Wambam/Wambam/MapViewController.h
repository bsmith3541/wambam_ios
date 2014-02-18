//
//  MapViewViewController.h
//  Wambam
//
//  Created by Brandon Smith on 2/16/14.
//  Copyright (c) 2014 Wambam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
@interface MapViewController : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>

@end
