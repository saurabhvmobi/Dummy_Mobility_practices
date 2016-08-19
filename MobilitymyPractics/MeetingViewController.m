//
//  MeetingViewController.m
//  UCB_POC
//
//  Created by Saurabh on 8/9/16.
//  Copyright © 2016 Amit. All rights reserved.
//

#import "MeetingViewController.h"
#import "RoomManager.h"
#import "Constant.h"
#import "MyEventModel.h"
#import "CLWeeklyCalendarViewSourceCode/CLWeeklyCalendarView.h"
#define MIN_TIME_SLOT_FOR_SEARCH 15*60
#import "RoomModel.h"
@interface MeetingViewController ()<RoomManagerDelegate,CLWeeklyCalendarViewDelegate>
{
    RoomManager *roomManager;
    NSMutableArray *meetingListArr;
    NSString *userName;
    NSString *password;
    UIAlertController * alert;
    NSDateFormatter *localeDateFormatter,*dateFormatter;
    NSDate *startDate, *endDate;
    NSArray *emailIDsOfRoomsToCheck, *roomsToCheckModelArray;
    NSMutableArray *roomsAvailable;
    NSInteger selectedindex;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *todayDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *noMeetingPlaceHolder;
@property (weak, nonatomic) IBOutlet UIView *calenderViewContainer;
@property (nonatomic, strong) CLWeeklyCalendarView *calendarView;


@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;

@property (weak, nonatomic) IBOutlet UIView *availableRoomsView;

@property (weak, nonatomic) IBOutlet UILabel *selectedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UIButton *serachRoomsButton;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;

@end

@implementation MeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBarHidden = NO;
    self.title = @"Meeting";
    self.tableView.estimatedRowHeight =45;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
        meetingListArr =[[NSMutableArray alloc]init];
    roomManager =[[RoomManager alloc]init];
    roomManager.delegate = self;
   
     self.calenderViewContainer.layer.masksToBounds = YES;
    //self.todayDateLabel.text = [self dateFormetterMethod:[NSDate date]];
    
    
    //[self getAllRoomList];
    
    localeDateFormatter =[[NSDateFormatter alloc]init];
    
    [self AskingUserNameAndPassword];
    
   // [self callExchangeServerApiForTodayMeeting];


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.noMeetingPlaceHolder.hidden = YES;

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



- (IBAction)findAvailableRooms:(id)sender
{
//    currentlyExcutingMethod = @"findAvailableRooms:";
//    if ([sender tag] == 100)
//    {
//        [self performSegueWithIdentifier:@"RoomFinderToFreeSlotsSegue" sender:nil];
//        return;
//    }
//    
//    //Start time can be 5 mins less than current time. Because we are round time to multiple of 5 mins (less than current time). So intervel can be till 300 seconds to be valid.
//    
//    NSTimeInterval intervel = [[NSDate date] timeIntervalSinceDate:startDate];
//    if (intervel > 300)
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR_FOR_ALERT"
//                                                            message:@"ALERT_MSG_SELECT_FUTURE_TIME"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles: nil];
//        [alertView show];
//        
//        [self resetView];
//        
//        return;
//    }
//    
//    NSString *ewsRequestURL = [[NSUserDefaults standardUserDefaults] objectForKey:EWS_REQUSET_URL_KEY];
//    if (ewsRequestURL == nil)
//    {
//        AppDelegate *appDel = [UIApplication sharedApplication].delegate;
//        [appDel getEWSRequestURL];
//        
//        if (!tryAgainAlert)
//        {
//            tryAgainAlert = [[UIAlertView alloc] initWithTitle:@"ERROR_FOR_ALERT"
//                                                       message:@"ALERT_MSG_TRY_LATER"
//                                                      delegate:self
//                                             cancelButtonTitle:@"OK_FOR_ALERT"
//                                             otherButtonTitles: nil];
//            
//        }
//       
//        [tryAgainAlert show];
//    }
//    
//    if (![self timeWindowIsValid])
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"WARNING_TEXT"
//                                                            message:@"ALERT_MSG_MINIMUM_TIME_SLOT"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//        NSLog(@"Time window is less than MIN Value");
//        return;
//    }
    
//    if (emailIDsOfRoomsToCheck.count == 0 | emailIDsOfRoomsToCheck == nil)
//    {
//        if (!tryAgainAlert)
//        {
//            tryAgainAlert = [[UIAlertView alloc] initWithTitle:@"ERROR_FOR_ALERT"
//                                                       message:@"ALERT_MSG_TRY_LATER"
//                                                      delegate:self
//                                             cancelButtonTitle:@"OK"
//                                             otherButtonTitles: nil];
//            
//        }
//        [tryAgainAlert show];
//        
//        return;
//    }
    
    self.placeHolderLabel.hidden = YES;
    
    [self resetView];
    
    //When you are booking a room for two consicutive time slots, [eg)12:00 to 12:30 and second Time slots is 12:30 to 1:00.] second time slot will not be valid as at 12:30 room is already booked. So to avoid this, what we can do is START TIME will always have AN ADDITIONAL SECOND ADDED. [eg) 12:00:01 to 12:30:00 and second time will be 12:30:01 to 1:00:00],
    startDate = [startDate dateByAddingTimeInterval:1];
    [roomManager availablityOfRooms:emailIDsOfRoomsToCheck forStart:startDate toEnd:endDate];
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    startDate = [startDate dateByAddingTimeInterval:-1];
    
}





- (IBAction)setStartTime:(UIButton *)sender
{
    [self setSelectedAsStart];
    self.availableRoomsView.hidden = YES;
    
    NSTimeInterval differenceFromCurrentDate = [startDate timeIntervalSinceDate:[NSDate date]];
    
    if (differenceFromCurrentDate < 0)
    {
        startDate = [self dateByGettingTimefrom:[NSDate date] withDateFrom:self.calendarView.selectedDate];
    }
    
    startDate = startDate?:[self dateByGettingTimefrom:[NSDate date] withDateFrom:self.calendarView.selectedDate];
    [self.startDatePicker setDate:startDate animated:YES];
    
    self.startDatePicker.minimumDate = [self isDateToday:startDate]?[self dateByGettingTimefrom:[NSDate date] withDateFrom:self.calendarView.selectedDate]:nil;
    
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *dateInString = [dateFormatter stringFromDate:startDate];
    [self.startTimeButton setTitle:dateInString forState:(UIControlStateNormal)];
    
}

- (IBAction)setEndTime:(UIButton *)sender
{
    if (startDate == nil)
    {
        return;
    }
    [self setSelectedAsEnd];
    self.availableRoomsView.hidden = YES;
    NSDate *minDate = [startDate?:[NSDate date] dateByAddingTimeInterval:MIN_TIME_SLOT_FOR_SEARCH];
    [self.endDatePicker setMinimumDate:minDate];
    
    //if START_DATE is nil, we will set END_DATE as currentDate+Min_TIME+SLOT
    endDate = endDate?:[self dateByGettingTimefrom:minDate withDateFrom:self.calendarView.selectedDate];
    [self.endDatePicker setDate:endDate animated:YES];
    
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *dateInString = [dateFormatter stringFromDate:endDate];
    [self.endTimeButton setTitle:dateInString forState:(UIControlStateNormal)];
    
    [self showSearchButton];
}

- (void)setSelectedAsStart
{
    self.startTimeButton.selected = YES;
    self.startDatePicker.hidden = NO;
    self.endDatePicker.hidden = YES;
    self.endTimeButton.selected = NO;
    
    [self.endTimeButton setTitle:@"End time" forState:(UIControlStateNormal)];
    endDate = nil;
    self.serachRoomsButton.hidden = YES;
    
    self.placeHolderLabel.hidden = YES;
}

- (void)setSelectedAsEnd
{
    self.startTimeButton.selected = NO;
    self.startDatePicker.hidden = YES;
    self.endDatePicker.hidden = NO;
    self.endTimeButton.selected = YES;
    
    self.placeHolderLabel.hidden = YES;
}



- (void)showSearchButton
{
    if (startDate == nil | endDate == nil)
    {
        return;
    }
    [self setButtonForSearchingFreeRoom];
    self.serachRoomsButton.hidden = NO;
}
- (void)setButtonForSearchingFreeRoom
{
    self.serachRoomsButton.tag = 111;
    [self.serachRoomsButton setTitle:@"Search Meeting Room(s)" forState:(UIControlStateNormal)];
}
- (BOOL)isDateToday:(NSDate *)dateToTest
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *todayDate = [calender dateFromComponents:components];
    
    components = [calender components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:dateToTest];
    NSDate *date = [calender dateFromComponents:components];
    
    if ([todayDate isEqualToDate:date])
    {
        return YES;
    }
    
    return NO;
}



- (void)viewDidLayoutSubviews
{
    [self calendarView];
}

- (CLWeeklyCalendarView *)calendarView
{
    if(!_calendarView)
    {
        _calendarView = [[CLWeeklyCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.calenderViewContainer.bounds.size.width, 79)];
        _calendarView.delegate = self;
        
        [self.calenderViewContainer addSubview:self.calendarView];
    }
    
    return _calendarView;
}

#pragma mark - CLWeeklyCalendarViewDelegate

- (NSDictionary *)CLCalendarBehaviorAttributes
{
    return @{
             CLCalendarWeekStartDay : @1,                 //Start Day of the week, from 1-7 Mon-Sun -- default 1
             CLCalendarDayTitleTextColor : [UIColor darkGrayColor],
             CLCalendarBackgroundImageColor: [UIColor colorWithRed:0.44 green:0.81 blue:0.96 alpha:1]
             };
}

- (void)dailyCalendarViewDidSelect:(NSDate *)date
{
        startDate = startDate?:[NSDate date];
        endDate = endDate?:[startDate dateByAddingTimeInterval:MIN_TIME_SLOT_FOR_SEARCH];
    
//    if ([date isPastDate] && ![date isDateToday])
//    {
//        [self.calendarView redrawToDate:[NSDate date]];
//        return;
//    }
    
    startDate = [self dateByGettingTimefrom:startDate withDateFrom:date];
    NSLog(@"Start date = %@", startDate);
    
    endDate = [self dateByGettingTimefrom:endDate withDateFrom:date];
    NSLog(@"End date = %@", endDate);

    localeDateFormatter.dateFormat = @"dd MMMM yyyy";
    localeDateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    self.todayDateLabel.text = [localeDateFormatter stringFromDate:date];
    
    if (endDate != nil)
    {
       // self.serachRoomsButton.hidden = NO;
    }
    
    [self resetView];
}
- (NSDate *)dateByGettingTimefrom:(NSDate *)dateForTime withDateFrom:(NSDate *)dateFromDdate
{
    if (dateForTime == nil | dateFromDdate == nil)
    {
        return nil;
    }
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unitFlags fromDate:dateFromDdate];
    NSDate *dateFromCalendar = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit ;
    components = [[NSCalendar currentCalendar] components:unitFlags fromDate:dateForTime];
    components.minute = (components.minute / 5) * 5;
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:dateFromCalendar options:0];
    
    return date;
}


- (void)resetView
{
    self.startDatePicker.hidden = YES;
    self.endDatePicker.hidden = YES;
    self.startTimeButton.selected = NO;
    self.endTimeButton.selected = NO;
    self.availableRoomsView.hidden = YES;
}

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender
{
    UIButton *selectedButton;
    
    if ([sender isEqual:self.startDatePicker])
    {
        selectedButton = self.startTimeButton;
        startDate = [self dateByGettingTimefrom:sender.date withDateFrom:self.calendarView.selectedDate];
        NSLog(@"Start date = %@", startDate);
        
    }else if ([sender isEqual:self.endDatePicker])
    {
        selectedButton = self.endTimeButton;
        endDate = [self dateByGettingTimefrom:sender.date withDateFrom:self.calendarView.selectedDate];
        NSLog(@"End date = %@", endDate);
    }
    
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *dateInString = [dateFormatter stringFromDate:sender.date];
    [selectedButton setTitle:dateInString forState:(UIControlStateNormal)];
    
    [self showSearchButton];
}









-(void)AskingUserNameAndPassword
{
       alert=   [UIAlertController
                                  alertControllerWithTitle:@"Alert !!"
                                  message:@"Please Enter MicroSoft ExchangeServer User Credentials"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   //Do Some action here
                                                   [self okButtonActionFromAlertView];
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       
                                                       [self.navigationController popViewControllerAnimated:YES];
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Username";
        textField.text = @"user1@vmexchange.com";
        userName = textField.text;
    
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
        textField.secureTextEntry = YES;
        textField.text = @"Power@1234";
        password = textField.text;
   
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)okButtonActionFromAlertView
{
    UITextField *alertTextField1 = alert.textFields.firstObject;
    UITextField *alertTextField2 = alert.textFields.lastObject;
    userName = alertTextField1.text;
    password = alertTextField2.text;
    if (![self validateLoginFields])
    {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:EWS_REQUSET_USERID_KEY];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:EWS_USERS_PASSWORD_KEY];
    NSLog(@"And the text is... %@! and %@",userName,password);
    //[self callExchangeServerApiForTodayMeeting];
    [self getAllRoomList];

}

#pragma mark - Table view data source

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [roomsAvailable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:101];
    RoomModel *model = roomsAvailable[indexPath.row];
    label.text = model.nameOfRoom;
    UIImageView *beaconIndicatorImageView = (UIImageView *)[cell viewWithTag:555];
    
    if (model.RSSIValue > NSIntegerMin & model.RSSIValue != 0)
    {
        beaconIndicatorImageView.image = [UIImage imageNamed:@"ibeacon-green"];
    }else
    {
        beaconIndicatorImageView.image = nil;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedindex = indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if ([self checkForPrivteRoom:roomsAvailable[indexPath.row]])
//    {
//        [self performSegueWithIdentifier:@"romeFinderToInvite_segue" sender:nil];
//    }else
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:WARNING_TEXT
//                                                        message:ALERT_MSG_AUTHORIZED_BOOKING
//                                                       delegate:self
//                                              cancelButtonTitle:STRING_FOR_LANGUAGE(@"No")
//                                              otherButtonTitles:STRING_FOR_LANGUAGE(@"Yes"), nil];
//        [alert show];
   // }
}

-(NSString *)dateFormetterMethod:(NSDate *)startTime and:(NSDate*)endTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *start = [dateFormatter stringFromDate:startTime];
    NSString *end = [dateFormatter stringFromDate:endTime];
    NSString *timingString = [NSString stringWithFormat:@"%@ - %@",start,end];
    return timingString;
}


-(NSString *)dateFormetterMethod:(NSDate *)date
{
    NSString *dateString ;
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"dd MMMM yyyy";
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
     dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

-(void)callExchangeServerApiForTodayMeeting
{
//   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDate *startTime = [calender dateBySettingHour:0 minute:0 second:1 ofDate:[NSDate date] options:kNilOptions];
    NSTimeInterval secondsInEightHours = (24 * 60 * 60)-60;
   NSDate *endTime = [startTime dateByAddingTimeInterval:secondsInEightHours];
   NSArray *currentUserEmail = @[userName];
   [roomManager getAllMyEvents:currentUserEmail forStart:startTime toEnd:endTime];
    
}

-(void)getAllRoomList
{
    [roomManager getRoomsForRoomList:EWS_REQUSET_EMAIL_ID];

}

// Method for camparing meeting And find out colapse Meeting

-(void)comparingMeetingandfindOutColaspeTimegetCalenderEvents:(NSMutableArray *)calenderEvents{
    for (int i = 0; i< calenderEvents.count;i++) {
        MyEventModel *firstmeetingModel = meetingListArr[i];
              for (int j = i+1;j< calenderEvents.count; j++) {
         MyEventModel *nextmeetingModel = meetingListArr[j];
            if ([firstmeetingModel.endTime compare:nextmeetingModel.startTime ] == NSOrderedDescending) {
                [firstmeetingModel.conflictMeeting addObject:nextmeetingModel];
                [nextmeetingModel.conflictMeeting addObject:firstmeetingModel];
            }
        }
    }
}



#pragma RoomManager Delegate

- (void)roomManager:(RoomManager *)manager getCalenderEvents:(NSMutableArray *)calenderEvents
{
     meetingListArr = calenderEvents;
    [self.tableView reloadData];
    [self comparingMeetingandfindOutColaspeTimegetCalenderEvents:calenderEvents];
    
    if (meetingListArr.count==0) {
        self.noMeetingPlaceHolder.hidden = NO;
    } else {
        self.noMeetingPlaceHolder.hidden = YES;
    }
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)roomManager:(RoomManager *)manager FoundRooms:(NSArray *)rooms
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (RoomModel *aRoom in rooms)
    {
        [array addObject:aRoom.emailIDOfRoom];
    }
    
    emailIDsOfRoomsToCheck = array;
    roomsToCheckModelArray = rooms;


}

- (void)roomManager:(RoomManager *)manager failedWithError:(NSError *)error
{
    NSLog(@"%@",error);

// [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)roomManager:(RoomManager *)manager foundAvailableRooms:(NSArray *)availableRooms
{
    selectedindex = -1;//Negative value wont be INDEX of cell
    
    if (roomsAvailable == nil)
    {
        roomsAvailable = [[NSMutableArray alloc] init];
    }else
    {
        [roomsAvailable removeAllObjects];
    }
    
    for (NSString *anEmailID in availableRooms)
    {
        RoomModel *model = [self roomForEmailID:anEmailID];
        if (model)
        {
            [roomsAvailable addObject:model];
        }
    }
    
    if (roomsAvailable.count == 0)
    {
        self.placeHolderLabel.hidden = NO;
                self.placeHolderLabel.text = @"No Meeting Rooms are available for the selected time slot.";
        
        
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"nameOfRoom" ascending:YES];
    roomsAvailable = [[roomsAvailable sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];
    
    [self.tableView reloadData];
    self.availableRoomsView.hidden = NO;
    [self setButtonForSearchingFreeRoom];
    self.serachRoomsButton.hidden = YES;
    
    //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (RoomModel *)roomForEmailID:(NSString *)emailID
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"emailIDOfRoom = %@", emailID];
    NSArray *filterdArray = [roomsToCheckModelArray filteredArrayUsingPredicate:predicate];
    
    if (filterdArray.count > 0)
    {
        return [filterdArray firstObject];
    }
    
    return nil;
}




- (BOOL)validateLoginFields
{
    BOOL goodToGo = YES;
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    if (userName.length == 0)
    {
        goodToGo = NO;
        [mutableString appendString:@"Email Id is required"];
    }
    if (password.length == 0)
    {
        goodToGo = NO;
        if (mutableString.length>0) {
            [mutableString appendString:@"\nPassword is required"];
        }
        else
        {
            [mutableString appendString:@"Password is required"];
        }
    }
    
//    else if (![self stringIsValidEmail:password]&&userName.length!=0)
//    {
//        goodToGo = NO;
//        [mutableString appendString:@"Please enter a valid Email Id"];
//    }
//    
    
    if (!goodToGo)
    {
//        [self mbProgress:mutableString];
    }
    return goodToGo;
    
}
-(BOOL)stringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

//- (void)mbProgress:(NSString*)message
//{
//    MBProgressHUD *hubHUD=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    hubHUD.mode=MBProgressHUDModeText;
//    hubHUD.detailsLabelText = message;
//    hubHUD.detailsLabelFont=[UIFont systemFontOfSize:15];
//    hubHUD.margin=20.f;
//    hubHUD.yOffset=150.f;
//    hubHUD.removeFromSuperViewOnHide = YES;
//    [hubHUD hide:YES afterDelay:2];
//}





@end
