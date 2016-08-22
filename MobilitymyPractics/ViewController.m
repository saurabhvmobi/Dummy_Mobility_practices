//
//  ViewController.m
//  MobilitymyPractics
//
//  Created by Saurabh on 8/8/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import "ViewController.h"
#import "UserInfo.h"
@interface ViewController ()
{
    UserInfo *userInfo;

}

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *corpIDLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    userInfo =[UserInfo shareUserInfo];
    
  //  [self updateprofileData];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)upgradeButtonAction:(id)sender {

    [self performSegueWithIdentifier:@"upgradeSegue" sender:self];
}
- (IBAction)tipsButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"tipsSegua" sender:self];

}

- (IBAction)bookARoomButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"bookaRoomSegua" sender:self];
}




-(void)updateprofileData
{
    self.emailIDLabel.text = userInfo.emailIDValue;
    self.fullNameLabel.text = userInfo.fullName;
    self.corpIDLabel.text = userInfo.cropID;


}


@end
