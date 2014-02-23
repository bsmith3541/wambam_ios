//
//  MapViewViewController.m
//  Wambam
//
//  Created by Brandon Smith on 2/16/14.
//  Copyright (c) 2014 Wambam. All rights reserved.
//

#import "MapViewController.h"
#import "InfoWindow.h"

@interface MapViewController ()

@end

@implementation MapViewController {
    CLLocationManager *locationManager;
    GMSMapView *mapView;
    CLLocation *currLocation;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // allocate and initialize CLLocationManager
    // complete setup for location updates
    //GMSCameraPosition *camera;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 50.0f;
//    if(currLocation) {
//        camera = [GMSCameraPosition cameraWithLatitude:currLocation.coordinate.latitude longitude:currLocation.coordinate.longitude zoom:6];
//        mapView.camera = camera;
//    }
    [locationManager startUpdatingLocation];
    //mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView = [[GMSMapView alloc] initWithFrame:self.view.bounds];
    mapView.delegate = self;
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    self.view = mapView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D) coordinate
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = coordinate;
    marker.appearAnimation = YES;
    
    // anchors the marker's annotation window (displays task info)
    marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
    marker.map = mapView;
}

//- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
//    InfoWindow *view = [[InfoWindow alloc] init];
//    view.name.text = @"Place Name";
//    view.description.text = @"Place description";
//    view.phone.text = @"123 456 789";
//    view.placeImage.image = [UIImage imageNamed:@"customPlaceImage"];
//    view.placeImage.transform = CGAffineTransformMakeRotation(-.08);
//    return view;
//}

- (void)mapView:(GMSMapView *)mapView didTapOverlay:(GMSOverlay *) overlay
{
    NSLog(@"Overlay: %@", overlay);
}


- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    NSLog(@"Marker: %@", marker);
    
    // center camera around marker
    GMSCameraPosition *newCamera = [GMSCameraPosition cameraWithLatitude:marker.position.latitude longitude:marker.position.longitude zoom:15];
    mapView.camera = newCamera;
    
    // we return true because this delegate method handles
    // the event rather than using the default response
    return TRUE;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    currLocation = newLocation;
    
    if (currentLocation != nil) {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currLocation.coordinate.latitude longitude:currLocation.coordinate.longitude zoom:15];
        //NSLog(@"Current Location: %@", currLocation);
        //NSLog(@"%@", [self myLocation]);
        mapView.camera = camera;
    }
}

@end
