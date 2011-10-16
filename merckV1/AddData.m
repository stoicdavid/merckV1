//
//  AddData.m
//  merckV1
//
//  Created by David Rodriguez on 10/12/11.
//  Copyright (c) 2011 UNAM. All rights reserved.
//

#import "AddData.h"
#import <QuartzCore/QuartzCore.h>
#import "merckV1AppDelegate.h"
#import "UIImage-Extensions.h"

@implementation AddData

//@synthesize dato1,dato2,dato3,dato4,dato5,dato6;
@synthesize color,delegate,datos,datos2;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 264;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 352;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(IBAction) enviarResultadosPorCorreo:(id)sender
{
    //Capturar Tabla
    merckV1AppDelegate *delegado = [[UIApplication sharedApplication] delegate];
    UIGraphicsBeginImageContext(delegado.window.bounds.size);
    
    CALayer *test = delegado.window.layer;
    [test renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIInterfaceOrientation orienta = [[UIApplication sharedApplication] statusBarOrientation];
    if (orienta ==UIInterfaceOrientationLandscapeLeft) {
        image = [image imageRotatedByDegrees:90];        
    }else{
        image = [image imageRotatedByDegrees:-90];        
    }
    //if(self.datos2==nil){
        self.datos2 = UIImagePNGRepresentation(image);
    //}
    //Fin Captura Tabla

    [self emailImageWithImageData:self.datos additional:datos2];    
}


-(IBAction)dismissModalView:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)emailImageWithImageData:(NSData *)data additional:(NSData *)data2
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Set the subject of email
    [picker setSubject:@"Abordaje Terapéutico - Merck"];
    
    // Add email addresses
    // Notice three sections: "to" "cc" and "bcc" 
    //    [picker setToRecipients:[NSArray arrayWithObjects:@"pablo@litoimagen.com", nil]];
    
    //    Fill out the email body text
    
//    NSMutableString *cadena=[[NSMutableString alloc]init];
//    [cadena appendString:dat1.text];
//    [cadena appendString:dat1.text];
//    [cadena appendString:dat1.text];
//    [cadena appendString:dat2.text];
//    [cadena appendString:dat3.text];
//    [cadena appendString:dat4.text];
//    [cadena appendString:dat5.text];
//    [cadena appendString:dat6.text];
    
    NSString *emailBody = @"";
    
    // This is not an HTML formatted email
    [picker setMessageBody:emailBody isHTML:NO];
    
    // Attach image data to the email
    // 'CameraImage.png' is the file name that will be attached to the email
    [picker addAttachmentData:data2 mimeType:@"image/png" fileName:@"CameraImage2"];
    [picker addAttachmentData:data mimeType:@"image/png" fileName:@"CameraImage"];

    
    // Show email view    
    [self presentModalViewController:picker animated:YES];
    
    // Release picker
    [picker release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{
    // Called once the email is sent
    // Remove the email view controller  
    //[self.view viewWithTag:1000].alpha=1.0;
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)eligeColor:(UIButton *)sender{
    
    switch(sender.tag){
        case 100:{
            //[self actualizaColores:sender];
            UIImage *imagen2 = [UIImage imageNamed:@"azul_b"];
            
            [sender setImage:imagen2 forState:UIControlStateNormal];

            [sender setImage:imagen2 forState:UIControlStateNormal];
            UIImage *res = [UIImage imageNamed:@"verde"];
            UIButton *tmp = (UIButton *)[self.view viewWithTag:101];
            [tmp setImage:res forState:UIControlStateNormal];
            UIImage *res1 = [UIImage imageNamed:@"rojo"];
            UIButton *tmp1 = (UIButton *)[self.view viewWithTag:102];
            UIImage *res2 = [UIImage imageNamed:@"amarillo"];
            [tmp1 setImage:res1 forState:UIControlStateNormal];
            UIButton *tmp2 = (UIButton *)[self.view viewWithTag:103];
            [tmp2 setImage:res2 forState:UIControlStateNormal];
            elegido=YES;
            break;
        }
        case 101:{
            //[self actualizaColores:sender];
            UIImage *imagen2 = [UIImage imageNamed:@"verde_b"];
            
            [sender setImage:imagen2 forState:UIControlStateNormal];
            UIImage *res = [UIImage imageNamed:@"azul"];
            UIButton *tmp = (UIButton *)[self.view viewWithTag:100];
            [tmp setImage:res forState:UIControlStateNormal];
            UIImage *res1 = [UIImage imageNamed:@"rojo"];
            UIButton *tmp1 = (UIButton *)[self.view viewWithTag:102];
            UIImage *res2 = [UIImage imageNamed:@"amarillo"];
            [tmp1 setImage:res1 forState:UIControlStateNormal];
            UIButton *tmp2 = (UIButton *)[self.view viewWithTag:103];
            [tmp2 setImage:res2 forState:UIControlStateNormal];


            elegido=YES;
                        break;
        }

        case 102:{
            //[self actualizaColores:sender];
            UIImage *imagen2 = [UIImage imageNamed:@"rojo_b"];
            [sender setImage:imagen2 forState:UIControlStateNormal];

            [sender setImage:imagen2 forState:UIControlStateNormal];
            UIImage *res = [UIImage imageNamed:@"verde"];
            UIButton *tmp = (UIButton *)[self.view viewWithTag:101];
            [tmp setImage:res forState:UIControlStateNormal];
            UIImage *res1 = [UIImage imageNamed:@"azul"];
            UIButton *tmp1 = (UIButton *)[self.view viewWithTag:100];
            UIImage *res2 = [UIImage imageNamed:@"amarillo"];
            [tmp1 setImage:res1 forState:UIControlStateNormal];
            UIButton *tmp2 = (UIButton *)[self.view viewWithTag:103];
            [tmp2 setImage:res2 forState:UIControlStateNormal];
            
            elegido=YES;      
                        break;
        }

        case 103:{
            //[self actualizaColores:sender];
            UIImage *imagen2 = [UIImage imageNamed:@"amarillo_b"];
            
            [sender setImage:imagen2 forState:UIControlStateNormal];
            
            [sender setImage:imagen2 forState:UIControlStateNormal];
            UIImage *res = [UIImage imageNamed:@"verde"];
            UIButton *tmp = (UIButton *)[self.view viewWithTag:101];
            [tmp setImage:res forState:UIControlStateNormal];
            UIImage *res1 = [UIImage imageNamed:@"azul"];
            UIButton *tmp1 = (UIButton *)[self.view viewWithTag:100];
            UIImage *res2 = [UIImage imageNamed:@"rojo"];
            [tmp1 setImage:res1 forState:UIControlStateNormal];
            UIButton *tmp2 = (UIButton *)[self.view viewWithTag:102];
            [tmp2 setImage:res2 forState:UIControlStateNormal];
            

            elegido=YES;      
                        break;
        }
    }
    
    
    
}

//-(void)actualizaColores:(UIButton *)sender{
//    int i;
//
//        for(i=100;i<104;i++){
//            if( sender.tag != i ){
//                
//                switch(i){
//                    case 100:{
//                        [self actualizaColores:sender];
//                        UIImage *imagen2 = [UIImage imageNamed:@"azul"];
//                        UIButton *tmp = (UIButton *)[self.view viewWithTag:i];
//                        [tmp setImage:imagen2 forState:UIControlStateNormal];
//                        
//                        elegido=YES;            
//                    }
//                    case 101:{
//                        [self actualizaColores:sender];
//                        UIImage *imagen2 = [UIImage imageNamed:@"verde"];
//                        UIButton *tmp = (UIButton *)[self.view viewWithTag:i];
//                        [tmp setImage:imagen2 forState:UIControlStateNormal];
//                        
//                        elegido=YES;
//                    }
//                        
//                    case 102:{
//                        [self actualizaColores:sender];
//                        UIImage *imagen2 = [UIImage imageNamed:@"rojo"];
//                        UIButton *tmp = (UIButton *)[self.view viewWithTag:i];
//                        [tmp setImage:imagen2 forState:UIControlStateNormal];
//                        
//                        elegido=YES;            
//                    }
//                        
//                    case 103:{
//                        [self actualizaColores:sender];
//                        UIImage *imagen2 = [UIImage imageNamed:@"amarillo"];
//                        UIButton *tmp = (UIButton *)[self.view viewWithTag:i];
//                        [tmp setImage:imagen2 forState:UIControlStateNormal];
//                        
//                        elegido=YES;            
//                    }
//                }
//                
//        }
//    }
//}

-(void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event
{
	// do the following for all textfields in your current view
    [dat0 resignFirstResponder];
	[dat1 resignFirstResponder];
	[dat2 resignFirstResponder];
	[dat3 resignFirstResponder];
    [dat4 resignFirstResponder];
	[dat5 resignFirstResponder];
	[dat6 resignFirstResponder];
	[dat7 resignFirstResponder];
	[dat8 resignFirstResponder];
	[dat9 resignFirstResponder];    
	// save the value of the textfield, ...
	
}


-(BOOL) textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder]; 
	return YES;
}

-(void) textViewDidBeginEditing:(UITextView *)textView{
    CGRect textFieldRect = [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
	CGFloat midline = textFieldRect.origin.x + 0.5 * textFieldRect.size.width;
    CGFloat numerator = midline - viewRect.origin.x - MINIMUM_SCROLL_FRACTION * viewRect.size.width;
    CGFloat denominator =(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.width;
    CGFloat heightFraction = numerator / denominator;
	
	if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
	
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation != UIInterfaceOrientationLandscapeLeft || orientation != UIInterfaceOrientationLandscapeRight)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
	
	CGRect viewFrame = self.view.frame;
    viewFrame.origin.x -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];   
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.x += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

#pragma mark Métodos del UITextFieldDelegateProtocol 
- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{ 
	[textField resignFirstResponder]; 
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
	CGFloat midline = textFieldRect.origin.x + 0.5 * textFieldRect.size.width;
    CGFloat numerator = midline - viewRect.origin.x - MINIMUM_SCROLL_FRACTION * viewRect.size.width;
    CGFloat denominator =(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.width;
    CGFloat heightFraction = numerator / denominator;
	
	if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
	
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation != UIInterfaceOrientationLandscapeLeft || orientation != UIInterfaceOrientationLandscapeRight)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
	
	CGRect viewFrame = self.view.frame;
    viewFrame.origin.x -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
	//enviar.enabled=YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.x += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}





#pragma mark - View lifecycle

- (void)viewDidLoad
{
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
	return YES;
}

- (void) dealloc{
    [datos dealloc];
    [datos2 dealloc];

    [color dealloc];
    [super dealloc];
}

@end
