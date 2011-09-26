//
//  merckV1AppDelegate.h
//  merckV1
//
//  Created by Hector Zarate on 8/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class merckV1ViewController;

@interface merckV1AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet merckV1ViewController *viewController;

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
