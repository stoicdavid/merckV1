//
//  ResultadosATerapeutico.m
//  merckV1
//
//  Created by Hector Zarate on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultadosATerapeutico.h"
#import "ElementosDerecha.h"
#import "DiapositivaAdicional.h"
#import "UIImage-Extensions.h"
#import "merckV1AppDelegate.h"
#import "ZeroIndiceTableView.h"
#import "PrimerIndiceTableViewController.h"


#define kMargenIzquierdo 83
#define kEspacio 310

#define kIndiceVistas 100
#define kIndiceVistasDerecha 200


#define kNumeroDiapositivas 3
#define kPantallaAncho 1024
#define kPantallaAlto 748


@implementation ResultadosATerapeutico

@synthesize definiciones;
@synthesize vistaScroll;
@synthesize reporteButton;
@synthesize datos;
@synthesize indice;

@synthesize popOverController;

-(IBAction) mostrarIndiceDePublicaciones: (id) sender
{
    if (self.popOverController == nil)
    {
        PrimerIndiceTableViewController *primer = [[PrimerIndiceTableViewController alloc] initWithStyle:UITableViewStylePlain];
        
        UINavigationController *controladorNavegacion = [[UINavigationController alloc] initWithRootViewController:primer];
        
        self.popOverController = [[UIPopoverController alloc] initWithContentViewController:controladorNavegacion];
        
        [controladorNavegacion release];
        [primer release];

    }
    if (self.popOverController.isPopoverVisible)
    {
        [self.popOverController dismissPopoverAnimated:YES];
    } else
    {
        [self.popOverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    }
    
    
}

-(IBAction) enviarResultadosPorCorreo:(id)sender
{

    [self emailImageWithImageData:self.datos];    
}


- (void)emailImageWithImageData:(NSData *)data
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Set the subject of email
    [picker setSubject:@"Abordaje Terapéutico - Merck"];
    
    // Add email addresses
    // Notice three sections: "to" "cc" and "bcc" 
//    [picker setToRecipients:[NSArray arrayWithObjects:@"pablo@litoimagen.com", nil]];
    
    //    Fill out the email body text
    NSString *emailBody = @"";
    
    // This is not an HTML formatted email
    [picker setMessageBody:emailBody isHTML:NO];
    
    // Attach image data to the email
    // 'CameraImage.png' is the file name that will be attached to the email
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

-(IBAction)mostrarDiapositiva8A:(id)sender
{
    DiapositivaAdicional *controlador1 = [[DiapositivaAdicional alloc] init];    
    [self presentModalViewController:controlador1 animated:YES];
    controlador1.imagen.image = [UIImage imageNamed:@"Diapositiva_8A"];
    [controlador1 release];
    
    
    
}


-(IBAction)mostrarDiapositiva8B:(id)sender
{
    DiapositivaAdicional *controlador1 = [[DiapositivaAdicional alloc] init];    
    [self presentModalViewController:controlador1 animated:YES];
    controlador1.imagen.image = [UIImage imageNamed:@"Diapositiva_8B"];
    [controlador1 release];
    
}

-(IBAction)mostrarR:(id)sender
{
    QLPreviewController *controlador1 = [[QLPreviewController alloc] init];    
    DiapositivaAdicional *dummy = [[DiapositivaAdicional alloc] init];
    dummy.documents=@"R-Resumen de Resultados.pdf";
    controlador1.dataSource =dummy;
    controlador1.currentPreviewItemIndex =0;
    [self presentModalViewController:controlador1 animated:YES];
    
    [dummy release];
    [controlador1 release];
}






-(IBAction)mostrarTR:(id)sender
{
    QLPreviewController *controlador1 = [[QLPreviewController alloc] init];    
    DiapositivaAdicional *dummy = [[DiapositivaAdicional alloc] init];
    dummy.documents=@"TR Tratamiento Personalizado.pdf";
    controlador1.dataSource =dummy;
    controlador1.currentPreviewItemIndex =0;
    [self presentModalViewController:controlador1 animated:YES];

    [dummy release];
    [controlador1 release];    
}





-(IBAction) regresarADiapositiva5: (id) sender
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

-(void) viewWillAppear:(BOOL)animated
{
//    int posicionResultadosSegundaVista = [[[(ElementosDerecha *)[self.definiciones objectAtIndex:1] selecccionesDerecha] lastObject] intValue];
//    
//    self.vistaMovilDerecha.frame = CGRectMake(kMargenIzquierdo + (kEspacio*posicionResultadosSegundaVista), self.vistaMovilDerecha.frame.origin.y, self.vistaMovilDerecha.frame.size.width, self.vistaMovilDerecha.frame.size.height);
    

    
    
    // Primera Etiqueta Individual:
    
    NSLog(@"Numero de Elementos %d ", [[(ElementosDerecha *)[self.definiciones objectAtIndex:0] selecccionesDerecha] count]);
    
    
    NSString *nombre = [NSString stringWithFormat:@"D_0_%d", [[[(ElementosDerecha *)[self.definiciones objectAtIndex:0] selecccionesDerecha] lastObject] intValue]];
    
    if ([nombre isEqualToString:@"D_0_0"]){
        [tipo setText:@"Tratamiento Agresivo"];
        [tipo2 setText:@"Tratamiento Agresivo"];
    }else{
        [tipo setText:@"Tratamiento No Agresivo"];
        [tipo2 setText:@"Tratamiento No Agresivo"];
    }
//    
//    UIImage *imagenBoton = [UIImage imageNamed:nombre];
//    
//    
//    
//    [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 0] setImage: imagenBoton];
//    [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 0] setImage: imagenBoton forState:UIControlStateNormal];
    
    
    // Segunda Etiqueta Individual:
    
    nombre = [NSString stringWithFormat:@"D_1_%d", [[[(ElementosDerecha *)[self.definiciones objectAtIndex:1] selecccionesDerecha] lastObject] intValue]];
    
    if ([nombre isEqualToString:@"D_1_0"]){
        [fluo setText:@"Aplicacion por Bolo"];
        [fluo2 setText:@"Aplicacion por Bolo"];
        [titulo1 setText:@"Infusión"];
        [titulo2 setText:@"Bolo"];
        [titulo3 setText:@"Oral"];
    }else if ([nombre isEqualToString:@"D_1_1"]) {
        [fluo setText:@"Aplicacion Oral"];
        [fluo2 setText:@"Aplicacion Oral"];
        [titulo1 setText:@"Bolo"];
        [titulo2 setText:@"Oral"];
        [titulo3 setText:@"Infusión"];
    }else{
        [fluo setText:@"Aplicacion por Infusión"];
        [fluo2 setText:@"Aplicacion por Infusión"];
        [titulo1 setText:@"Oral"];
        [titulo2 setText:@"Infusión"];
        [titulo3 setText:@"Bolo"];
    }
    
//    imagenBoton = [UIImage imageNamed:nombre];
//    
//    [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 1] setImage: imagenBoton];
//    [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 1] setImage: imagenBoton forState:UIControlStateNormal];    
//    
    // Tercera Etiqueta Individual:
    
    nombre = [NSString stringWithFormat:@"D_6_%d", [[[(ElementosDerecha *)[self.definiciones objectAtIndex:3] selecccionesDerecha] lastObject] intValue]];
   
    if ([nombre isEqualToString:@"D_6_0"]){
        [add setText:@"ERBITUX"];
        [add2 setText:@"ERBITUX"];
    }else if ([nombre isEqualToString:@"D_6_1"]) {
        [add setText:@"BEVACIZUMAB"];
        [add2 setText:@"BEVACIZUMAB"];
    }else{
        [add setText:@"PANITUMUMAB"];
        [add2 setText:@"PANITUMUMAB"];
    }

    
    
    
//    imagenBoton = [UIImage imageNamed:nombre];
//    
//    [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 6] setImage: imagenBoton];
//    [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 6] setImage: imagenBoton forState:UIControlStateNormal];

    
    // Cuarta Etiqueta Individual:
    
    nombre = [NSString stringWithFormat:@"D_7_%d", [[[(ElementosDerecha *)[self.definiciones objectAtIndex:4] selecccionesDerecha] lastObject] intValue]];
    
    if ([nombre isEqualToString:@"D_7_0"]){
        [kras setText:@"Sí usa KRAS"];
        [kras2 setText:@"Sí usa KRAS"];
    }else{
        [kras setText:@"No usa KRAS"];
        [kras2 setText:@"No usa KRAS"];
    }
    
    
    // Colores
        
    //nombre = [NSString stringWithFormat:@"Color_%d", [[[(ElementosDerecha *)[self.definiciones objectAtIndex:6] selecccionesDerecha] lastObject] intValue]];
    
//    NSString *nombre2 = [NSString string

   // NSString *nombreColor2 = [NSString stringWithFormat:@"Color_%d_2", [[[(ElementosDerecha *)[self.definiciones objectAtIndex:6] selecccionesDerecha] lastObject] intValue]];

    //UIImage *imagenBoton2 = [UIImage imageNamed:nombreColor2];    
    
//    imagenBoton = [UIImage imageNamed:nombre];
//    
//    [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 12] setImage: imagenBoton];
//    [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 13] setImage: imagenBoton];    
    
    //[(UIImageView *)[self.view viewWithTag:kIndiceVistasDerecha - 1] setImage:imagenBoton2];
    //[(UIImageView *)[self.view viewWithTag:kIndiceVistasDerecha - 2] setImage:imagenBoton2];
                         
                         
                         
    // Etiquetas no individuales
    
    
    // Acido Folinico
    [qt setText:@""];
    int j=0;

    if ([[[self.definiciones objectAtIndex:2] selecccionesDerecha] containsObject:[NSNumber numberWithInt:0]])
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 2] setAlpha: 1.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 2] setAlpha: 1.0];
        [qt setText:@"+ Acido Folínico"];
        [qt2 setText:@"+ Acido Folínico"];
        j++;
    }
    else
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 2] setAlpha: 0.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 2] setAlpha: 0.0];

        
    }

    // Oxaliplatino
    
    if ([[[self.definiciones objectAtIndex:2] selecccionesDerecha] containsObject:[NSNumber numberWithInt:2]])
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 3] setAlpha: 1.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 3] setAlpha: 1.0];
        if (j>0) {
             [qt setText:[[qt text] stringByAppendingString:@",+ Oxaliplatino"]];
            [qt2 setText:[[qt2 text] stringByAppendingString:@"\n+ Oxaliplatino"]];
            j++;
        }else{
            [qt setText:@"+ Oxaliplatino"];
            [qt2 setText:@"+ Oxaliplatino"];
            j++;
        }
            
       
    }
    else
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 3] setAlpha: 0.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 3] setAlpha: 0.0];
        
    }

    // Irinotecan
    
    if ([[[self.definiciones objectAtIndex:2] selecccionesDerecha] containsObject:[NSNumber numberWithInt:1]])
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 4] setAlpha: 1.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 4] setAlpha: 1.0];        
        if (j>0) {
            [qt setText:[[qt text] stringByAppendingString:@",+ Irinotecan"]];
            [qt2 setText:[[qt2 text] stringByAppendingString:@"\n+ Irinotecan"]];
            j++;
        }else{
            [qt setText:@"+ Irinotecan"];
            [qt2 setText:@"+ Irinotecan"];
            j++;
        }
    
    
    }
    else
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 4] setAlpha: 0.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 4] setAlpha: 0.0];
        
    }    
    
    // Otros
    
    if ([[[self.definiciones objectAtIndex:2] selecccionesDerecha] containsObject:[NSNumber numberWithInt:3]])
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 5] setAlpha: 1.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 5] setAlpha: 1.0];
        if (j>0) {
            [qt setText:[[qt text] stringByAppendingString:@",+ Otros"]];
            [qt2 setText:[[qt2 text] stringByAppendingString:@"\n+ Otros"]];
            j++;
        }else{
            [qt setText:@"+ Otros"];
            [qt2 setText:@"+ Otros"];
            j++;
        }
        
        
    }
    else
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 5] setAlpha: 0.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 5] setAlpha: 0.0];
        
    }   
    
    
    
    // Tasa de Respuesta
    
    [por setText:@""];
    int k=0;
    
    if ([[[self.definiciones objectAtIndex:5] selecccionesDerecha] containsObject:[NSNumber numberWithInt:0]])
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 8] setAlpha: 1.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 8] setAlpha: 1.0];
        [por setText:@"TR"];
        [por2 setText:@"TR"];
        k++;
    }
    else
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 8] setAlpha: 0.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 8] setAlpha: 0.0];

        
    }    
    
    // Supervivencia Libre de Progresion
    
    if ([[[self.definiciones objectAtIndex:5] selecccionesDerecha] containsObject:[NSNumber numberWithInt:1]])
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 9] setAlpha: 1.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 9] setAlpha: 1.0];
        if (k>0) {
            [por setText:[[por text] stringByAppendingString:@", SLP"]];
            [por2 setText:[[por2 text] stringByAppendingString:@"\nSLP"]];
            k++;
        }else{
            [por setText:@"SLP"];
            [por2 setText:@"SLP"];
            k++;
        }
        
        
    }
    else
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 9] setAlpha: 0.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 9] setAlpha: 0.0];
        
    }        
    
    if ([[[self.definiciones objectAtIndex:5] selecccionesDerecha] containsObject:[NSNumber numberWithInt:2]])
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 10] setAlpha: 1.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 10] setAlpha: 1.0];
        if (k>0) {
            [por setText:[[por text] stringByAppendingString:@", SG"]];
            [por2 setText:[[por2 text] stringByAppendingString:@"\nSG"]];
            k++;
        }else{
            [por setText:@"SG"];
            [por2 setText:@"SG"];
            k++;
        }
        
    }
    else
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 10] setAlpha: 0.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 10] setAlpha: 0.0];
        
    }        

    if ([[[self.definiciones objectAtIndex:5] selecccionesDerecha] containsObject:[NSNumber numberWithInt:3]])
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 11] setAlpha: 1.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 11] setAlpha: 1.0];
        if (k>0) {
            [por setText:[[por text] stringByAppendingString:@", RH"]];
            [por2 setText:[[por2 text] stringByAppendingString:@"\nRH"]];
            k++;
        }else{
            [por setText:@"RH"];
            [por2 setText:@"RH"];
            k++;
        }        
    }
    else
    {
//        [(UIImageView *)[self.view viewWithTag:kIndiceVistas + 11] setAlpha: 0.0];
//        [(UIButton *)[self.view viewWithTag:kIndiceVistasDerecha + 11] setAlpha: 0.0];
        
    }        
    //NSLog([por text]);
    

    
    // Segunda Vista
    
    tipo.text=[tipo.text uppercaseString];
    fluo.text=[fluo.text uppercaseString];
    qt.text=[qt.text uppercaseString];
    add.text=[add.text uppercaseString];
    kras.text=[kras.text uppercaseString];
    por.text=[por.text uppercaseString];
    
    tipo2.text=[tipo2.text uppercaseString];
    fluo2.text=[fluo2.text uppercaseString];
    qt2.text=[qt2.text uppercaseString];
    add2.text=[add2.text uppercaseString];
    kras2.text=[kras2.text uppercaseString];
    por2.text=[por2.text uppercaseString];
    
    [self imprimirSelecciones];
    
}


-(void) viewDidAppear:(BOOL)animated
{
    
    NSDate *now = [NSDate date];
	NSDateFormatter *formatter = nil;
	formatter = [[NSDateFormatter alloc] init];
	//[formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setDateFormat:@" EEEE d MMM yyyy, h:mm a"];

	[fecha setText:[formatter stringFromDate:now]];
	[formatter release];

    [self.view viewWithTag:1000].alpha=0.0;
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
    if(self.datos==nil){
        self.datos = UIImagePNGRepresentation(image);
    }
    //Fin Captura Tabla
        [self.view viewWithTag:1000].alpha=1.0;
}


-(void) imprimirSelecciones
{
    int i=0;
    for (ElementosDerecha *unElemento in self.definiciones)
    {
        NSLog(@"Indice: %d", i);
        
        for (NSNumber *unNumero in unElemento.selecccionesDerecha)
        {
            NSLog(@"Seleccion: %d", [unNumero intValue]);
        }
        
        i++;
    }
    
}

-(IBAction) toggleBotonSegundoEstado:(UIButton *) sender
{
    BOOL cambio = NO;

    if (sender.alpha != 1.00)
    {
        cambio = YES;
        [self transicionDeVista:sender haciaAlpha:1.0];
//        sender.alpha = 1.0;
    }
    
    
    if ([sender.titleLabel.text hasSuffix:@"_2"])
    {
        
        NSString *nombreImagen = [sender.titleLabel.text substringToIndex: ([sender.titleLabel.text length] - 2)];
        
        NSLog(@"NombreImagen: %@", nombreImagen);
        
        [sender setImage:[UIImage imageNamed:nombreImagen ] forState:UIControlStateNormal];        
        [sender setTitle:nombreImagen forState:UIControlStateNormal];
//        [self transicionDeVista:sender haciaAlpha:0.025];        
        sender.alpha = 0.025;
    }
    else
    {
        if (sender.alpha == 1.00 && !cambio) {
            NSString *nombreImagen = [NSString stringWithFormat:@"%@_2", sender.titleLabel.text];
            NSLog(@"NombreImagen: %@", nombreImagen);        
            [sender setTitle:nombreImagen forState:UIControlStateNormal];
            
            [sender setImage:[UIImage imageNamed:nombreImagen ] forState:UIControlStateNormal];
            [sender setImage:[UIImage imageNamed:nombreImagen ] forState:UIControlStateHighlighted];            
        }
    }

    
}

-(void) transicionDeVista:(UIView *) view haciaAlpha:(float) valorAlpha
{
    [UIView animateWithDuration:0.10 delay:0.0 options:UIViewAnimationCurveEaseIn animations:
     ^{
         view.alpha = valorAlpha;
     }
                     completion:nil];    

}

-(IBAction) toggleBoton: (UIView *) sender
{
    NSLog(@"Alpha Actual: %f", sender.alpha);
    
    
    if (sender.alpha == 1.00)
    {
        [self transicionDeVista:sender haciaAlpha:0.025];        
//        sender.alpha = 0.025;
    }
    else
    {
        [self transicionDeVista:sender haciaAlpha:1.0];        
        sender.alpha = 1.00;
    }
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    UIBarButtonItem *dis = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(regresarDiapositiva5)];
//    NSArray *a = [NSArray arrayWithObject:dis];
//    [self setToolbarItems:a animated:YES];
    
    self.vistaScroll.delegate = self;
    
    self.vistaScroll.contentSize = CGSizeMake(kPantallaAncho * kNumeroDiapositivas, kPantallaAlto-44);
    
    UIView *vistaAResultados1 = [[[NSBundle mainBundle] loadNibNamed:@"FirstResultadosATerapeutico" owner:self options:nil] lastObject];					
    
    vistaAResultados1.frame = CGRectMake(0, 0, kPantallaAncho, kPantallaAlto);
    [self.vistaScroll addSubview:vistaAResultados1];   
    
    


    
  
    
    UIView *vistaAResultados2 = [[[NSBundle mainBundle] loadNibNamed:@"SecondResultadoATerapeutico" owner:self options:nil] lastObject];					
    
    vistaAResultados2.frame = CGRectMake(kPantallaAncho * 1, 0, kPantallaAncho, kPantallaAlto-44);
    [self.vistaScroll addSubview:vistaAResultados2];  
 
 
    UIView *vistaAResultados3 = [[[NSBundle mainBundle] loadNibNamed:@"ThirdResultadosATerapeutico" owner:self options:nil] lastObject];					
    
    vistaAResultados3.frame = CGRectMake(kPantallaAncho * 2, 0, kPantallaAncho, kPantallaAlto-44);
    [self.vistaScroll addSubview:vistaAResultados3];    

    
    
    
    // Do any additional setup after loading the view from its nib.
    

}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat anchoPagina = scrollView.frame.size.width;
    
    self.indice = (int)(self.vistaScroll.contentOffset.x / anchoPagina) ;
    NSLog(@"%d",self.indice);
    if(self.indice==2){
       
        self.reporteButton.enabled=YES;
        
        
//        self.reporteButton = [[UIBarButtonItem alloc] initWithTitle:@"Reporte" style:UIBarButtonItemStyleBordered target:self action:@selector(enviarResultadosPorCorreo)];
//        
//        //(UIBarButtonItem *);
//        //[reporteButton setEnabled:YES];
//        self.navigationItem.rightBarButtonItem=reporteButton;
    }else{
        self.reporteButton.enabled=NO;
    }
    
    
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) return YES;
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)return YES;
    else return NO;
}


@end
