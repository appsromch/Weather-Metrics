//
//  WeatherAnimatedIcon.m
//  WeatherApp
//
//  Created by Romain Tholimet on 10/23/13.
//  Copyright (c) 2013 Romain Tholimet. All rights reserved.
//

#import "WeatherAnimatedIcon.h"
#import "defines.h"

@implementation WeatherAnimatedIcon

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (void)createIcon:(NSString *)name {
    NSFileManager   *fm = [NSFileManager defaultManager];
    NSError         *dataError = nil;
    NSString        *path = [NSString stringWithFormat:@"%@/%@", [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:WEATHER_ICON_FOLDER], name];
    NSArray         *fileNames = nil;

    _weatherAnimatedIconImages = [[NSMutableArray alloc] init];
    fileNames = [fm contentsOfDirectoryAtPath:[path stringByExpandingTildeInPath]  error:&dataError];
    
    if (!dataError) {
        for (NSString *file in fileNames) {
            if ([file rangeOfString:@"@2x"].location == NSNotFound) {
                UIImage     *image = [UIImage imageNamed:[[WEATHER_ICON_FOLDER stringByAppendingPathComponent:name] stringByAppendingPathComponent:file]];

                if (image) {
                    [_weatherAnimatedIconImages addObject:image];
                }
            }
        }
    } else {
        NSLog(@"Files are missing. Cannot create animation with %@", _weatherAnimatedIconName);
    }
    _weatherAnimatedIconName = name;
    self.weatherAnimatedIconDuration = WEATHER_ICON_DURATION;
    self.animationImages = _weatherAnimatedIconImages;
    self.animationDuration = self.weatherAnimatedIconDuration;
    self.contentMode = UIViewContentModeScaleAspectFit;
}

@end
