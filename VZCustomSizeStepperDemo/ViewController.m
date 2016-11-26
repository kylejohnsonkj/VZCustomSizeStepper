//
//  ViewController.m
//  VZCustomSizeStepperDemo
//
//  Created by Vyacheslav Zubenko on 26/11/16.
//  Copyright © 2016 Vyacheslav Zubenko. All rights reserved.
//

#import "ViewController.h"
#import "VZCustomSizeStepper.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize label;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = CGRectMake(self.view.frame.size.width*0.1, self.view.frame.size.height*0.7, self.view.frame.size.width*0.8, self.view.frame.size.width*0.25);
    VZCustomSizeStepper *stepper = [[VZCustomSizeStepper alloc] initWithFrame:frame];
    stepper.maximumValue = 100;
    stepper.minimumValue = 1;
    stepper.stepValue = 1;
    stepper.value = 10;
    [stepper addTarget:self action:@selector(chanegestep:)    forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:stepper];
    label.text = [NSString stringWithFormat:@"%d",(int)stepper.value];
    
}

- (IBAction)chanegestep:(UIStepper *)sender {
    NSLog(@"stepper pressed");
    label.text = [NSString stringWithFormat:@"%d",(int)sender.value];
    [label setNeedsDisplay];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
