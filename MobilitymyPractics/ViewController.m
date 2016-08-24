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
    
    [self updateprofileData];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)upgradeButtonAction:(id)sender {

    BOOL didOpen = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""]];
    if (!didOpen)
    {
      UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"Alert !!" message:@"please install " preferredStyle:UIAlertControllerStyleAlert];
        [alertControl addAction:[UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertControl addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // [self.navigationController popToRootViewControllerAnimated:YES];
            
        }]];
        [self presentViewController:alertControl animated:YES completion:^{
            
        }];

    
    
    
    }

    
    
    
    
    
    
    
    //[self performSegueWithIdentifier:@"upgradeSegue" sender:self];
}
- (IBAction)tipsButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"tipsSegua" sender:self];

}

- (IBAction)bookARoomButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"bookaRoomSegua" sender:self];
}
- (IBAction)newsButtonAction:(id)sender {
[self performSegueWithIdentifier:@"newsSegue" sender:self];
}




-(void)updateprofileData
{
    self.emailIDLabel.text = userInfo.emailIDValue;
    self.fullNameLabel.text = userInfo.fullName;
    self.corpIDLabel.text = userInfo.cropID;


}


@end
