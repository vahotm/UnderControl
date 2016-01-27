//
//  ThermostatDetailsViewController.h
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//

#import <UIKit/UIKit.h>

@class MARKRangeSlider;
@interface ThermostatDetailsViewController : UIViewController

@property (nonatomic, strong) NSString *thermostatId;

@property (weak, nonatomic) IBOutlet UISegmentedControl *hvacSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *hvacStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureHeaderLabel;
@property (weak, nonatomic) IBOutlet MARKRangeSlider *rangeSlider;
@property (weak, nonatomic) IBOutlet UISlider *singleSlider;
@property (weak, nonatomic) IBOutlet UILabel *targetTemp;
@property (weak, nonatomic) IBOutlet UILabel *currentTemp;

@end
