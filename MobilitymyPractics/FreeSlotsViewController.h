//
//  FreeSlotsViewController.h
//  MobilitymyPractics
//
//  Created by Saurabh on 8/19/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomManager.h"

@interface FreeSlotsViewController : UIViewController
@property (strong, nonatomic) NSArray *rooms;
@property (strong, nonatomic) RoomManager *roomManager;
@end
