//
//  lastLevelTableViewController.h
//  merckV1
//
//  Created by Hector Zarate on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface LastLevelTableViewController : UITableViewController <UIDocumentInteractionControllerDelegate> {
 
    NSMutableArray *diccionarioDeDatos;
    UIDocumentInteractionController *docInteractionController;
}

@property (nonatomic, retain) UIDocumentInteractionController *docInteractionController;

@property (nonatomic, retain) NSMutableArray *diccionarioDeDatos;

@end
