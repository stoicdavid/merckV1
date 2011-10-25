//
//  ZeroIndiceTableView.m
//  merckV1
//
//  Created by Hector Zarate on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZeroIndiceTableView.h"
#import "PrimerIndiceTableViewController.h"


@implementation ZeroIndiceTableView

@synthesize nombreDelRecurso, idiomasDisponibles, docInteractionController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
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
    
    self.idiomasDisponibles = [[NSMutableArray alloc] initWithCapacity:2];
    
    
    NSString *pathEspanol = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_es", self.nombreDelRecurso] ofType:@"pdf"];

    NSString *pathIngles = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_en", self.nombreDelRecurso] ofType:@"pdf"];

    
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    // Buscar Español
    if ([fileManager fileExistsAtPath: pathEspanol])
    {
        NSDictionary *diccionarioEspanol = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Español", [NSString stringWithFormat:@"%@_es", self.nombreDelRecurso],nil ]
                                                                      forKeys:[NSArray arrayWithObjects:@"titulo", @"archivo",nil]];
        
        [self.idiomasDisponibles addObject:diccionarioEspanol];
    }
    if ([fileManager fileExistsAtPath:pathIngles])
    {
        NSDictionary *diccionarioIngles = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Inglés", [NSString stringWithFormat:@"%@_en", self.nombreDelRecurso],nil ]
                                                                      forKeys:[NSArray arrayWithObjects:@"titulo", @"archivo",nil]];
        
        [self.idiomasDisponibles addObject:diccionarioIngles];        
    }    
    
    
    [fileManager release];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) return YES;
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)return YES;
    else return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

        
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    // Return the number of rows in the section.
    return [self.idiomasDisponibles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [[self.idiomasDisponibles objectAtIndex:indexPath.row] valueForKey:@"titulo"];
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *fileURL;
    
    fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[[self.idiomasDisponibles objectAtIndex:indexPath.row] valueForKey:@"archivo"] 
                                                                     ofType:@"pdf"]];
    
    [self setupDocumentControllerWithURL:fileURL];
    [self.docInteractionController presentPreviewAnimated:YES];
    //UIInterfaceOrientation orienta = [[UIApplication sharedApplication] statusBarOrientation];
    //[self.docInteractionController shouldAutorotateToInterfaceOrientation:orienta];
     
}

- (void)setupDocumentControllerWithURL:(NSURL *)url
{
    if (self.docInteractionController == nil)
    {
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    }
    else
    {
        self.docInteractionController.URL = url;
    }
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self;

}

- (void) documentInteractionController: (UIDocumentInteractionController *) controller{
    UIInterfaceOrientation orienta = [[UIApplication sharedApplication] statusBarOrientation];
    [self shouldAutorotateToInterfaceOrientation:orienta];
}

    

@end
