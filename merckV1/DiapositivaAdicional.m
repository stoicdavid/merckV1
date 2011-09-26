//
//  DiapositivaAdicional.m
//  merckV1
//
//  Created by Hector Zarate on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DiapositivaAdicional.h"


@implementation DiapositivaAdicional

@synthesize imagen;
@synthesize documents;

-(IBAction) cerrarVentana: (id) sender
{
    [self dismissModalViewControllerAnimated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (BOOL) previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id<QLPreviewItem>)item{
    return YES;
}

-(NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller{
    return 1;
}

- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex:(NSInteger)index{

    return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:documents ofType:nil]];

    }

- (void)dealloc
{
    [documents release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) return YES;
    else return NO;
}

@end
