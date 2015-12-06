//
//  TodayViewController.m
//  NotificationWidget
//
//  Created by yurongde on 15/12/1.
//  Copyright © 2015年 yurongde. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
static NSString *const kGroupID = @"group.com.ssddd.app";

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation TodayViewController
- (IBAction)clickToApp:(id)sender {
    [self.extensionContext openURL:[NSURL URLWithString:@"SDWidget://"] completionHandler:^(BOOL success) {
        NSLog(@"open url result:%d",success);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.preferredContentSize = CGSizeMake(0,300);

    
    //userdefault存储数据
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:kGroupID];
    
    NSString *string=[NSString stringWithFormat:@"%@",[shared objectForKey:@"number"]];
    
    //nsfile存储数据
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kGroupID];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/test"];
    NSString *value = [NSString stringWithContentsOfURL:containerURL encoding:NSUTF8StringEncoding error:&err];
    
    
    self.numberLabel.text=value;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeWord) userInfo:nil repeats:NO];
    [timer fire];
}
- (void)changeWord {
    NSInteger integer = [self.numberLabel.text integerValue];
    integer++;
    self.numberLabel.text = [NSString stringWithFormat:@"%d",integer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
@end
