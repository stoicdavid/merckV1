//
//  ResultadosATerapeutico.h
//  merckV1
//
//  Created by Hector Zarate on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <QuartzCore/QuartzCore.h>
#import "AddData.h"

@interface ResultadosATerapeutico : UIViewController  <MFMailComposeViewControllerDelegate, UIScrollViewDelegate,AddDataDelegate> {
    
    
    int indice;
    UIScrollView *vistaScroll;
    NSArray *definiciones;
    NSData * datos;
    

    
    
    //UIView *vistaMovilDerecha;
    
    UIPopoverController *popOverController;
    IBOutlet UILabel *tipo;
    IBOutlet UILabel *fluo;
    IBOutlet UILabel *qt;
    IBOutlet UILabel *add;
    IBOutlet UILabel *kras;
    IBOutlet UILabel *por;
    
    IBOutlet UILabel *tipo2;
    IBOutlet UILabel *fluo2;
    IBOutlet UILabel *qt2;
    IBOutlet UILabel *add2;
    IBOutlet UILabel *kras2;
    IBOutlet UILabel *por2;
    
    IBOutlet UILabel *titulo1;
    IBOutlet UILabel *titulo2;
    IBOutlet UILabel *titulo3;
    
    IBOutlet UILabel *fecha;
    
    UIBarButtonItem *reporteButton;

    
    
}

@property (nonatomic, retain) UIPopoverController *popOverController;

@property (nonatomic, assign) int indice;

@property (nonatomic, retain) IBOutlet UIScrollView *vistaScroll;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *reporteButton;
@property (nonatomic, retain) NSArray *definiciones;
@property (nonatomic, retain) NSData *datos;



-(void) transicionDeVista:(UIView *) view haciaAlpha:(float) valorAlpha;

-(IBAction) capturarDatos:(id) sender;

-(IBAction) enviarResultadosPorCorreo:(id) sender;

- (void)emailImageWithImageData:(NSData *)data;

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;




-(IBAction) mostrarIndiceDePublicaciones: (id) sender;
-(IBAction) capturarDatos: (id) sender;

-(IBAction)mostrarDiapositiva8A:(id)sender;
-(IBAction)mostrarDiapositiva8B:(id)sender;

-(IBAction) regresarADiapositiva5: (id) sender;
-(void) imprimirSelecciones;
-(IBAction) toggleBoton: (id) sender;
-(IBAction) toggleBotonSegundoEstado:(UIButton *) sender;



@end
