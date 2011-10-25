//
//  PrimerIndiceTableViewController.h
//  merckV1
//
//  Created by Hector Zarate on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PrimerIndiceTableViewController : UITableViewController {
 UITableViewController *detailViewController;   
}
@property(nonatomic,retain) UITableViewController *detailViewController;   

@end
