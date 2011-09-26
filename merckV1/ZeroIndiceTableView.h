//
//  ZeroIndiceTableView.h
//  merckV1
//
//  Created by Hector Zarate on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZeroIndiceTableView : UITableViewController<UIDocumentInteractionControllerDelegate> {
    NSString *nombreDelRecurso;
    
    NSMutableArray *idiomasDisponibles;
    
    UIDocumentInteractionController *docInteractionController;
}

@property (nonatomic, retain) UIDocumentInteractionController *docInteractionController;


@property (nonatomic, retain) NSString *nombreDelRecurso;
@property (nonatomic, retain) NSMutableArray *idiomasDisponibles;
- (void)setupDocumentControllerWithURL:(NSURL *)url;
- (void)setNombreDelRecurso:(NSString *)nombreDelRecurso;

@end
