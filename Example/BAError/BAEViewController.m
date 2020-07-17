//
//  BAEViewController.m
//  BAError
//
//  Created by benarvin on 07/17/2020.
//  Copyright (c) 2020 benarvin. All rights reserved.
//

#import "BAEViewController.h"
#import <BAError/NSError+BAError.h>

@interface BAEViewController ()

@end

@implementation BAEViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSError *error1 = [NSError bae_errorWith:@"TestDomain" code:1001 description:@"testDes_1" causes:nil];
    NSError *error2 = [NSError bae_errorWith:@"TestDomain" code:1002 description:@"testDes_2" causes:error1, nil];
    NSLog(@"%@", error2.localizedDescription);
    NSLog(@"%@", error2.localizedFailureReason);
    NSLog(@"%@", error2.localizedRecoverySuggestion);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSError *error1 = [NSError bae_errorWith:@"TestDomain" code:1001 description:@"testDes_1" reason:@"testReason_1" recoverySuggestion:@"testSuggestion_1" causes:nil];
    NSError *error2 = [NSError bae_errorWith:@"TestDomain" code:1002 description:@"testDes_2" reason:@"testReason_2" recoverySuggestion:@"testSuggestion_2" causes:error1, nil];
    NSError *error3 = [NSError bae_errorWith:@"TestDomain" code:1003 description:@"testDes_3" reason:@"testReason_3" recoverySuggestion:@"testSuggestion_3" causes:nil];
    NSError *error4 = [NSError bae_errorWith:@"TestDomain" code:1004 description:@"testDes_4" reason:@"testReason_4" recoverySuggestion:@"testSuggestion_4" causes:error3, nil];
    NSError *error5 = [NSError bae_errorWith:@"TestDomain" code:1005 description:@"testDes_5" reason:@"testReason_5" recoverySuggestion:@"testSuggestion_5" causes:error2, error4, nil];
    NSLog(@"%@", error5.localizedDescription);
    NSError *error6 = [NSError errorWithDomain:@"NormalError" code:1006 userInfo:@{NSLocalizedDescriptionKey: @"normalDes"}];
    NSError *error7 = [NSError bae_errorWith:@"TestDomain" code:1007 description:@"testDes_7" causes:error5, error6, nil];
    NSLog(@"%@", error7.localizedDescription);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
