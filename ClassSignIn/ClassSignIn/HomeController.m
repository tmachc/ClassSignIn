//
//  HomeViewController.m
//  ClassSignIn
//
//  Created by tmachc on 15/11/26.
//  Copyright © 2015年 tmachc. All rights reserved.
//

#import "HomeController.h"
#import "LoginViewController.h"
#import "ClassViewController.h"

@interface HomeController () 

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self setTitle:@"课堂"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];;
//    [self presentViewController:loginViewController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"--->>>%@",viewController);
    if ([viewController isKindOfClass:[ClassViewController class]]) {
        [self setTitle:@"课堂"];
    }
    else {
        [self setTitle:@"我的"];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
