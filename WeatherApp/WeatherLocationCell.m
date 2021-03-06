//
//  WeatherLocationCell.m
//  WeatherApp
//
//  Created by Romain Tholimet on 10/25/13.
//  Copyright (c) 2013 Romain Tholimet. All rights reserved.
//

#import "WeatherLocationsManager.h"
#import "WeatherLocationCell.h"
#import "WeatherAnimatedIcon.h"
#import "WeatherLocation.h"
#import "defines.h"

@implementation WeatherLocationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _weatherLocationIcon = [WeatherAnimatedIcon new];
        _weatherLocationColorTemp = [UIView new];
        
        _weatherLocationCityName = [UILabel new];
        _weatherLocationCityName.textAlignment = NSTextAlignmentLeft;
        _weatherLocationCityName.textColor = [UIColor whiteColor];
        _weatherLocationCityName.font = [UIFont fontWithName:WEATHER_LOCATION_FONT size:14];
        _weatherLocationCityName.lineBreakMode = NSLineBreakByTruncatingTail;
        
        _weatherLocationTemp = [UILabel new];
        _weatherLocationTemp.textAlignment = NSTextAlignmentCenter;
        _weatherLocationTemp.textColor = [UIColor whiteColor];
        _weatherLocationTemp.font = [UIFont fontWithName:WEATHER_LOCATION_FONT size:50];
        
        _weatherLocationCurrentLocation = [UIImageView new];
        _weatherLocationCurrentLocation.contentMode = UIViewContentModeScaleAspectFit;
        
        self.frame = CGRectMake(0, 0, WEATHER_LOCATION_CELL_WIDTH, WEATHER_LOCATION_CELL_HEIGHT);
        self.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:_weatherLocationIcon];
        [self.contentView addSubview:_weatherLocationColorTemp];
        [self.contentView addSubview:_weatherLocationCityName];
        [self.contentView addSubview:_weatherLocationTemp];
        [self.contentView addSubview:_weatherLocationCurrentLocation];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)buildWeatherCell:(WeatherLocation *)location {
    _weatherLocation = location;
    
    [_weatherLocationIcon createIcon:[[WeatherLocationsManager sharedWeatherLocationsManager] getIconFolder:_weatherLocation]];
    [_weatherLocationIcon startAnimating];
    
    _weatherLocationColorTemp.backgroundColor = [[WeatherLocationsManager sharedWeatherLocationsManager] getWeatherColorWithLocation:_weatherLocation];
    
    _weatherLocationCityName.text = location.weatherLocationName;
    [_weatherLocationCityName sizeToFit];
    
    _weatherLocationTemp.text = [NSString stringWithFormat:@"%d%@", [[WeatherLocationsManager sharedWeatherLocationsManager] getConvertedTemperature:_weatherLocation.weatherLocationTemp.integerValue], @"°"];
    
    _weatherLocationCurrentLocation.image = nil;
    if (_weatherLocation.weatherLocationCurrent) {
        _weatherLocationCurrentLocation.image = [UIImage imageNamed:WEATHER_CURRENT_LOCATION_IMAGE];
    }
}

- (void)layoutSubviews {
    CGRect  frame;

    frame = _weatherLocationColorTemp.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = WEATHER_LOCATION_CELL_TEMP_WIDTH;
    frame.size.height = WEATHER_LOCATION_CELL_TEMP_HEIGHT;
    _weatherLocationColorTemp.frame = frame;
    
    frame = _weatherLocationCityName.frame;
    frame.size.width = WEATHER_LOCATION_CELL_CITY_WIDTH;
    frame.origin.x = _weatherLocationColorTemp.frame.origin.x + _weatherLocationColorTemp.frame.size.width + WEATHER_LOCATION_CELL_CITY_PADDING;
    frame.origin.y = (WEATHER_LOCATION_CELL_HEIGHT / 2) - (frame.size.height / 2);
    _weatherLocationCityName.frame = frame;

    frame = _weatherLocationTemp.frame;
    frame.origin.x = _weatherLocationCityName.frame.origin.x + _weatherLocationCityName.frame.size.width + WEATHER_LOCATION_CELL_CITY_PADDING;
    frame.origin.y = 0;
    frame.size.width = WEATHER_LOCATION_CELL_TEMP_HEIGHT;
    frame.size.height = WEATHER_LOCATION_CELL_TEMP_HEIGHT;
    _weatherLocationTemp.frame = frame;
    
    frame = _weatherLocationCurrentLocation.frame;
    frame.size.width = WEATHER_LOCATION_CELL_CURRENT_ICON_WIDTH;
    frame.size.height = WEATHER_LOCATION_CELL_CURRENT_ICON_HEIGHT;
    frame.origin.x = _weatherLocationColorTemp.frame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = _weatherLocationColorTemp.frame.size.height / 2 - frame.size.height / 2;
    _weatherLocationCurrentLocation.frame = frame;
    
    frame = _weatherLocationIcon.frame;
    frame.size.width = WEATHER_LOCATION_CELL_ICON_WIDTH;
    frame.size.height = WEATHER_LOCATION_CELL_ICON_HEIGHT;
    frame.origin.x = WEATHER_LOCATION_CELL_WIDTH - (frame.size.width + frame.size.width / 3);
    frame.origin.y = WEATHER_LOCATION_CELL_HEIGHT / 2 - frame.size.height / 2;
    _weatherLocationIcon.frame = frame;    
}

@end
