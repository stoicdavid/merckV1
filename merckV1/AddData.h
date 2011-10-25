//
//  AddData.h
//  merckV1
//
//  Created by David Rodriguez on 10/12/11.
//  Copyright (c) 2011 UNAM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@protocol AddDataDelegate
-(IBAction) dismissModalView:(id)sender;
@end

@interface AddData : UIViewController<MFMailComposeViewControllerDelegate,UIApplicationDelegate,UITextFieldDelegate,UITextViewDelegate> {


    id <AddDataDelegate>   delegate;
    
    IBOutlet UITextField *dat0;
    IBOutlet UITextField *dat1;
    IBOutlet UITextField *dat2;
    IBOutlet UITextField *dat3;
    IBOutlet UITextField *dat4;
    IBOutlet UITextField *dat5;
    IBOutlet UITextField *dat6;
    IBOutlet UITextView *dat7;
    IBOutlet UITextView *dat8;
    IBOutlet UITextView *dat9;
    NSData * datos;
        NSData * datos2;
    CGFloat animatedDistance;
    
    BOOL elegido;
//    NSString *dato1;
//    NSString *dato2;
//    NSString *dato3;
//    NSString *dato4;
//    NSString *dato5;
//    NSString *dato6;
    NSString *color;
    
    

}

@property (nonatomic, copy ) NSString *color;
@property (nonatomic, retain) id <AddDataDelegate> delegate;
@property (nonatomic, retain) NSData *datos;
@property (nonatomic, retain) NSData *datos2;

-(IBAction) enviarResultadosPorCorreo:(id) sender;

- (void)emailImageWithImageData:(NSData *)data additional:(NSData *)data;

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;

-(IBAction)eligeColor:(UIButton *)sender;
//-(void) actualizaColores:(UIButton *)sender;
-(void) scroll:(UIView *)text;
@end
