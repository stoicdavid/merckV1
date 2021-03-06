//
//  PrimerIndiceTableViewController.m
//  merckV1
//
//  Created by Hector Zarate on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrimerIndiceTableViewController.h"
#import "LastLevelTableViewController.h"
#import "ErbituxTableViewController.h"


@implementation PrimerIndiceTableViewController
@synthesize detailViewController;
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
    self.title = @"Índice de Publicaciones";
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
//    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)return YES;
//    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)return YES;
//    else return NO;
    
    BOOL innerResult = [detailViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];

    return innerResult;
    
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Erbitux";
            break;
        case 1:
            cell.textLabel.text = @"Bevacizumab";
            break;
        case 2:
            cell.textLabel.text = @"Panitumumab";
            break;
        case 3:
            cell.textLabel.text = @"Complementos";
            break;
            
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    
    
    switch (indexPath.row) {
        case 0:
            detailViewController = [[ErbituxTableViewController alloc] init];

            
            
            // Pass the selected object to the new view controller.
            break;
        case 1:
            detailViewController = [[LastLevelTableViewController alloc] init];
            
            
            [[(LastLevelTableViewController *)detailViewController diccionarioDeDatos] addObject:
             [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:@"Booth", @"Booth",
                                                   nil]
              
                                         forKeys:[NSArray arrayWithObjects:@"title", @"archivo",
                                                  nil] ]];
            
            [[(LastLevelTableViewController *)detailViewController diccionarioDeDatos] addObject:
             [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:@"Hurwitz", @"Hurwitz",
                                                   nil]
              
                                         forKeys:[NSArray arrayWithObjects:@"title", @"archivo",
                                                  nil] ]];
            
            [[(LastLevelTableViewController *)detailViewController diccionarioDeDatos] addObject:
             [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:@"Hurwitz 2009", @"Hurwitz 2009",
                                                   nil]
              
                                         forKeys:[NSArray arrayWithObjects:@"title", @"archivo",
                                                  nil] ]];

            [[(LastLevelTableViewController *)detailViewController diccionarioDeDatos] addObject:
             [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:@"Saltz", @"Saltz",
                                                   nil]
              
                                         forKeys:[NSArray arrayWithObjects:@"title", @"archivo",
                                                  nil] ]];

            [[(LastLevelTableViewController *)detailViewController diccionarioDeDatos] addObject:
             [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:@"Stathopoulos", @"Statophoulus",
                                                   nil]
              
                                         forKeys:[NSArray arrayWithObjects:@"title", @"archivo",
                                                  nil] ]];     
            
            [[(LastLevelTableViewController *)detailViewController diccionarioDeDatos] addObject:
             [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:@"Tol", @"Tol",
                                                   nil]
              
                                         forKeys:[NSArray arrayWithObjects:@"title", @"archivo",
                                                  nil] ]];      
            break;
        case 2:
            
            detailViewController = [[LastLevelTableViewController alloc] init];
            
            
            [[(LastLevelTableViewController *)detailViewController diccionarioDeDatos] addObject:
             [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:@"Hecht", @"Hecht",
                                                   nil]
                                                                                                                              
                                         forKeys:[NSArray arrayWithObjects:@"title", @"archivo",
                                                  nil] ]];
            
            
            [[(LastLevelTableViewController *)detailViewController diccionarioDeDatos] addObject:
             [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:@"PRIME", @"PRIME",
                                                   nil]
              
                                         forKeys:[NSArray arrayWithObjects:@"title", @"archivo",
                                                  nil] ]];
            // Pass the selected object to the new view controller.
            
            break;
        case 3:
            
            detailViewController = [[LastLevelTableViewController alloc] init];            
            
            [[(LastLevelTableViewController *)detailViewController diccionarioDeDatos] addObject:
             [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:@"Data on File", @"Data on file",
                                                   nil]
              
                                         forKeys:[NSArray arrayWithObjects:@"title", @"archivo",
                                                  nil] ]];
            

            
            [[(LastLevelTableViewController *)detailViewController diccionarioDeDatos] addObject:
             [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:@"Marcadores Moleculares", @"Marcadores Moleculares y Terapias Biológicas Dirigidas",
                                                   nil]
              
                                         forKeys:[NSArray arrayWithObjects:@"title", @"archivo",
                                                  nil] ]];

            // Pass the selected object to the new view controller.            
            break;
            
        default:
            break;
    }
    detailViewController.title = [[(UITableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
    
    [detailViewController release];


}

@end
