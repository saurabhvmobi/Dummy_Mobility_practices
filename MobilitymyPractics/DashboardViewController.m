//
//  DashboardViewController.m
//  MobilitymyPractics
//
//  Created by Saurabh on 8/18/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import "DashboardViewController.h"

@interface DashboardViewController ()
{
    NSMutableArray *collectionArr;

}
@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    collectionArr = @[@"YAMMER",@"Approval",@"News",@"BOOK A ROOM",@"PASSWORD EXPIRE DAYS",@"TIPS",@"CALL SERVICE DESK",@"SERVICES",@"SHOULD I UPGRADE MY DEVICE?"].mutableCopy;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
