//
//  DRVCountryGeoServiceBaseTests.m
//  CareDrive
//
//  Created by Egor Tolstoy on 12.04.15.
//  Copyright (c) 2015 Egor Tolstoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>

#import "DRVCountryGeoServiceBase.h"
#import "DRVCountryGeoData.h"

#define XCTAssertEqualLocations(loc1, loc2) \
do { \
CGFloat distance = [loc1 distanceFromLocation:loc2]; \
if (distance > 0.001) { \
XCTFail(@"'%@' doesn't equal '%@'", loc1, loc2); \
} \
} while (0)

@interface DRVCountryGeoServiceBaseTests : XCTestCase

@property (strong, nonatomic) DRVCountryGeoServiceBase *countryGeoService;

@end

@implementation DRVCountryGeoServiceBaseTests

- (void)setUp {
    [super setUp];
    
    self.countryGeoService = [[DRVCountryGeoServiceBase alloc] init];
}

- (void)tearDown {
    self.countryGeoService = nil;
    
    [super tearDown];
}

- (void)testThatServiceReturnsPolygonGeoDataForCountryCode {
    // given
    NSString *const kCountryCode = @"HTI";
    CLLocation *const kExpectedFirstLocation = [[CLLocation alloc] initWithLatitude:19.91568391 longitude:-73.18979062];
    CLLocation *const kExpectedLastLocation = [[CLLocation alloc] initWithLatitude:19.91568391 longitude:-73.18979062];
    NSInteger const kExpectedLocationsArrayCount = 21;
    NSInteger const kExpectedPolygonsCount = 1;
    
    // when
    DRVCountryGeoData *geoData = [self.countryGeoService geoDataForCountryWithCountryCode:kCountryCode];
    NSArray *polygon = [geoData.polygons firstObject];

    // then
    XCTAssertEqualLocations([polygon firstObject], kExpectedFirstLocation);
    XCTAssertEqualLocations([polygon lastObject], kExpectedLastLocation);
    XCTAssertEqual(polygon.count, kExpectedLocationsArrayCount);
    XCTAssertEqual(geoData.polygons.count, kExpectedPolygonsCount);
}

- (void)testThatServiceReturnsMultiPolygonGeoDataForCountryCode {
    // given
    NSString *const kCountryCode = @"NZL";
    NSInteger const kExpectedPolygonsCount = 2;
    NSInteger const kExpectedFirstPolygonCount = 30;
    NSInteger const kExpectedSecondPolygonCount = 36;
    
    // when
    DRVCountryGeoData *geoData = [self.countryGeoService geoDataForCountryWithCountryCode:kCountryCode];
    
    // then
    XCTAssertEqual(geoData.polygons.count, kExpectedPolygonsCount);
    XCTAssertEqual([[geoData.polygons firstObject] count], kExpectedFirstPolygonCount);
    XCTAssertEqual([[geoData.polygons lastObject] count], kExpectedSecondPolygonCount);
}

@end
