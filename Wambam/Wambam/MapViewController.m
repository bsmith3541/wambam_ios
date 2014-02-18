//
//  MapViewViewController.m
//  Wambam
//
//  Created by Brandon Smith on 2/16/14.
//  Copyright (c) 2014 Wambam. All rights reserved.
//

#import "MapViewController.h"

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
    GMSCameraPosition *camera;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
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

- (void)mapView:(GMSMapView *)mapVIew didTapAtCoordinate:(CLLocationCoordinate2D) coordinate
{
    NSLog(@"Coordinate: %f", coordinate.latitude);
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = coordinate;
    marker.appearAnimation = YES;
    marker.map = mapView;
}

@end
