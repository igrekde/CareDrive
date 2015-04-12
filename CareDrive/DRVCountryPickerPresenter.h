//
//  DRVCountryPickerPresenter.h
//  CareDrive
//
//  Created by Egor Tolstoy on 12.04.15.
//  Copyright (c) 2015 Egor Tolstoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DRVCountryPickerView;
@protocol RMMapViewDelegate;

@interface DRVCountryPickerPresenter : NSObject

@property (nonatomic, weak) id <DRVCountryPickerView> view;

- (void)setupMapWithTiles;
- (id <RMMapViewDelegate>)delegateForMapView;

@end
