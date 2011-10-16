//
//  DiapositivaAdicional.h
//  merckV1
//
//  Created by Hector Zarate on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickLook/QuickLook.h"


@interface DiapositivaAdicional : UIViewController <QLPreviewControllerDataSource,QLPreviewControllerDelegate> {
    
    UIImageView *imagen;
    NSString *documents;
        
}


@property (nonatomic, retain) IBOutlet UIImageView *imagen;
@property (nonatomic, retain) NSString *documents;

-(IBAction) cerrarVentana: (id) sender;

-(NSInteger) numberOfPreviewItemsInPreviewController:(QLPreviewController *) controller;
- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex:(NSInteger)index;


@end
