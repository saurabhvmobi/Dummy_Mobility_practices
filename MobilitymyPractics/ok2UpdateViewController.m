//
//  ok2UpdateViewController.m
//  MobilitymyPractics
//
//  Created by Saurabh on 8/8/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import "ok2UpdateViewController.h"
#import "UserInfo.h"
@interface ok2UpdateViewController ()

{
    NSString *targetURL;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ok2UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initializeWebView];

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

-(void)initializeWebView
{
    NSString *currIosVersion = [[NSString alloc] initWithString:[[UIDevice currentDevice] systemVersion]];;
    NSString *model = [[NSString alloc] initWithString:[[UIDevice currentDevice] model]];
    UserInfo *userInfo =[UserInfo shareUserInfo];
    NSString *loc = userInfo.location;
    NSString *baseURL = userInfo.oKToUpdate;

    targetURL = [[NSString alloc] initWithFormat:@"%@?l=%@&i=%@&m=%@", baseURL, loc, currIosVersion,model];
    targetURL = [targetURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",targetURL);
    [self refreshBrowser];


}

- (void)refreshBrowser
{
    //Verify if targetURL was set by MDM
    
    NSURL *url = [NSURL URLWithString:targetURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:requestObj];
    
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}



@end
