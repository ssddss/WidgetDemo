//
//  ViewController.m
//  WidgetDemo
//
//  Created by yurongde on 15/12/1.
//  Copyright © 2015年 yurongde. All rights reserved.
//

#import "ViewController.h"
static NSString *const kGroupID = @"group.com.ssddd.app";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:kGroupID];
    [shared setObject:[NSNumber numberWithInt:10] forKey:@"number"];
    [shared synchronize];
    
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kGroupID];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/test"];
    
    NSString *value =@"123";
    
    BOOL result = [value writeToURL:containerURL atomically:YES encoding:NSUTF8StringEncoding error:&err];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
