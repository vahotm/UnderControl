//
//  ThermostatDetailsViewController.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//

#import "ThermostatDetailsViewController.h"
#import "FirebaseManager.h"
#import "Thermostat.h"

#import <MARKRangeSlider.h>


const float kMinTemperatureF = 50;
const float kMinTemperatureC = 9;
const float kMaxTemperatureF = 90;
const float kMaxTemperatureC = 32;


@interface ThermostatDetailsViewController ()
@property (nonatomic, strong) Thermostat *thermostat;
@end


@implementation ThermostatDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    WEAKIFY_SELF
    [[FirebaseManager sharedManager] addSubscriptionToURL:[self thermostatUrl] withBlock:^(id data) {
        
        STRONGIFY_SELF
        NSError *error = nil;
        Thermostat *thermostat = [MTLJSONAdapter modelOfClass:[Thermostat class]
                                           fromJSONDictionary:data
                                                        error:&error];
        NSAssert(error == nil, @"%@", error.localizedDescription);
        self.thermostat = thermostat;
        [self updateUIWithThermostat:self.thermostat];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[FirebaseManager sharedManager] removeSubscriptionToURL:[self thermostatUrl]];
    
    [super viewWillDisappear:animated];
}

#pragma mark - Private

- (void)updateUIWithThermostat:(Thermostat *)thermostat
{
    self.navigationItem.title = thermostat.nameLong;
    
    //  Segmented control
    [self.hvacSegmentedControl setTitle:@"Off" forSegmentAtIndex:0];
    [self.hvacSegmentedControl setTitle:@"Cool" forSegmentAtIndex:1];
    [self.hvacSegmentedControl setTitle:@"Heat" forSegmentAtIndex:2];
    
    if ([self.thermostat hasHeatCool] && self.hvacSegmentedControl.numberOfSegments == 3) {
        [self.hvacSegmentedControl insertSegmentWithTitle:@"Heat-Cool" atIndex:3 animated:NO];
    }
    else if (![self.thermostat hasHeatCool] && (self.hvacSegmentedControl.numberOfSegments == 4)) {
        [self.hvacSegmentedControl removeSegmentAtIndex:3 animated:NO];
    }
    self.hvacSegmentedControl.selectedSegmentIndex = self.thermostat.hvacMode;
    
    //  Current HVAC state
    self.hvacStateLabel.text = [NSString stringWithFormat:@"Current state: %@", [thermostat stringFromHVACState]];
    
    //  Slider
    self.rangeSlider.minimumDistance = 0.5;
    
    if (thermostat.temperatureScale == TemperatureScaleCelsius) {
        [self.rangeSlider setMinValue:kMinTemperatureC maxValue:kMaxTemperatureC];
        [self.singleSlider setMinimumValue:kMinTemperatureC];
        [self.singleSlider setMaximumValue:kMaxTemperatureC];
    }
    else {
        [self.rangeSlider setMinValue:kMinTemperatureF maxValue:kMaxTemperatureF];
        [self.singleSlider setMinimumValue:kMinTemperatureF];
        [self.singleSlider setMaximumValue:kMaxTemperatureF];
    }
    
    if (thermostat.hvacMode == HVACModeHeat || thermostat.hvacMode == HVACModeCool) {
        self.rangeSlider.hidden = YES;
        self.singleSlider.hidden = NO;
        self.targetTemp.hidden = NO;
    }
    else if (thermostat.hvacMode == HVACModeHeatCool) {
        self.rangeSlider.hidden = NO;
        self.singleSlider.hidden = YES;
        self.targetTemp.hidden = NO;
    }
    else if (thermostat.hvacMode == HVACModeOff) {
        self.rangeSlider.hidden = YES;
        self.singleSlider.hidden = YES;
        self.targetTemp.hidden = YES;
    }
    
    [self.rangeSlider setLeftValue:thermostat.targetTemperatureLow
                        rightValue:thermostat.targetTemperatureHigh];
    [self.singleSlider setValue:thermostat.targetTemperature];
    
    //  Slider label
    [self updateTargetTempLabel];
    
    //  Current label
    self.currentTemp.text = [NSString stringWithFormat:@"Current: %.1f %@",
                             thermostat.ambientTemperature,
                             [thermostat stringFromTemperatureScale]];
    
}

- (void)updateTargetTempLabel
{
    if (!self.rangeSlider.hidden) {
        self.targetTemp.text = [NSString stringWithFormat:@"%.1f - %.1f %@",
                                self.thermostat.targetTemperatureLow,
                                self.thermostat.targetTemperatureHigh,
                                [self.thermostat stringFromTemperatureScale]];
    }
    else if (!self.singleSlider.hidden) {
        self.targetTemp.text = [NSString stringWithFormat:@"%.1f %@",
                                self.thermostat.targetTemperature,
                                [self.thermostat stringFromTemperatureScale]];
    }
}

- (NSString *)thermostatUrl
{
    return [NSString stringWithFormat:@"%@/%@", kFirebaseThermostatsPath, self.thermostatId];
}

- (void)submitTemperature
{
    NSDictionary *dict = [self.thermostat dictionaryWithTemperature];
    [[FirebaseManager sharedManager] setValues:dict forURL:[self thermostatUrl]];
}

- (void)submitMode
{
    NSDictionary *dict = [self.thermostat dictionaryWithHVACMode];
    [[FirebaseManager sharedManager] setValues:dict forURL:[self thermostatUrl]];
}

#pragma mark - Actions

- (IBAction)onSegmentedControl:(UISegmentedControl *)sender
{
    self.thermostat.hvacMode = sender.selectedSegmentIndex;
    [self submitMode];
}

- (IBAction)onRangeSlider:(MARKRangeSlider *)sender
{
    if (self.thermostat.temperatureScale == TemperatureScaleCelsius) {
        self.thermostat.targetTemperatureLowC = sender.leftValue;
        self.thermostat.targetTemperatureHighC = sender.rightValue;
    }
    else {
        self.thermostat.targetTemperatureLowF = sender.leftValue;
        self.thermostat.targetTemperatureHighF = sender.rightValue;
    }
    [self updateTargetTempLabel];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(submitTemperature)
                                               object:nil];
    [self performSelector:@selector(submitTemperature)
               withObject:nil
               afterDelay:0.5];
}

- (IBAction)onRangeSliderTouchUp:(MARKRangeSlider *)sender
{
    
}

- (IBAction)onSingleSlider:(UISlider *)sender
{
    if (self.thermostat.temperatureScale == TemperatureScaleCelsius) {
        self.thermostat.targetTemperatureC = sender.value;
    }
    else {
        self.thermostat.targetTemperatureF = sender.value;
    }
    [self updateTargetTempLabel];
}

- (IBAction)inSingleSliderTouchUp:(UISlider *)sender
{
    [self submitTemperature];
}

@end
