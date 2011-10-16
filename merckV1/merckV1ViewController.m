//
//  merckV1ViewController.m
//  merckV1
//
//  Created by Hector Zarate on 8/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "merckV1ViewController.h"


#define kNumeroDiapositivas 5
#define kPantallaAncho 1024
#define kPantallaAlto 768

// Tags Botones
#define kIndicesMenos 400
#define kIndicesMenos2 500
#define kIndicesMas 600

#define kIndicesDerecho 300
#define kIndicesMedio 200
#define kIndicesIzquierdo 100

@implementation merckV1ViewController

@synthesize botonContinuar;

@synthesize _mainView;

@synthesize definicionesIzquierda;

//@synthesize scrollParaSlides;

@synthesize indiceDerechoSeleccionado, indiceMedioSeleccionado, indiceIzquierdoSeleccionado;

@synthesize posicionesDerechaEquivalentes;

@synthesize posicionesDerechaOrden;



-(BOOL) revisarLlenadoBotones
{
    BOOL resultado = YES;
    
    for (ElementosDerecha *unElemento in self.definicionesIzquierda)
    {
        
        if(!unElemento.excluyente && ([unElemento.selecccionesDerecha count] == unElemento.numeroElementos))
        {
            [self habilitarBotonesIzquierda:(UIButton *)[self.view viewWithTag:self.indiceIzquierdoSeleccionado+kIndicesIzquierdo]];
        }
            
        if (unElemento.excluyente && [unElemento.selecccionesDerecha count] == 0)
        {

            return NO;
        }
        
        if (!unElemento.excluyente && ([unElemento.selecccionesDerecha count] != unElemento.numeroElementos))
        {
    
            return NO;
        }
        

        
    }
    
    return resultado;   
}

-(void) actualizarBotones:(id) sender
{
    
    if ([self revisarLlenadoBotones]) self.botonContinuar.alpha = 1.0;
    else self.botonContinuar.alpha = 0.0;
}

-(IBAction) presionarBotonDerecho:(UIButton *)sender
{
    if(sender.tag-kIndicesDerecho<15){
        self.indiceDerechoSeleccionado = sender.tag - kIndicesDerecho;    
    }else{
        self.indiceDerechoSeleccionado = sender.tag - kIndicesMenos;    
        
    }
    ElementosDerecha *elementoCorrespondiente = [self.posicionesDerechaEquivalentes objectAtIndex:self.indiceDerechoSeleccionado];
    
  
        [self desaparecerBoton:(UIButton *)[self.view viewWithTag:indiceDerechoSeleccionado+kIndicesDerecho] enTiempo:0.45];
        [self desaparecerBoton:(UIButton *)[self.view viewWithTag:indiceDerechoSeleccionado+kIndicesMenos] enTiempo:0.45];
    if (elementoCorrespondiente.excluyente)
    {
        [elementoCorrespondiente.selecccionesDerecha removeObjectAtIndex:0];
    }else{
        [elementoCorrespondiente.selecccionesDerecha removeObjectIdenticalTo:
         [NSNumber numberWithInt:[[self.posicionesDerechaOrden objectAtIndex:self.indiceDerechoSeleccionado] intValue]] ];
    }

    
    ElementosDerecha *elementoActual = (ElementosDerecha *)[self.definicionesIzquierda objectAtIndex:self.indiceIzquierdoSeleccionado];
    
    for (int i=0;i < elementoActual.numeroElementos; i++)
    {
    //    if ([self offsetDerechoAPartirdePosicionMedia:i] == self.indiceDerechoSeleccionado && !elementoActual.excluyente)
        if ([self offsetDerechoAPartirdePosicionMedia:i] == self.indiceDerechoSeleccionado)    
        {
            [self aparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMedio +i ] enTiempo:0.45];
            if(!elementoActual.excluyente){
                [self aparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMas +i ] enTiempo:0.45];
                [self aparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMenos2 +i ] enTiempo:0.45];
            }
        }
    }

    
    [self habilitarBotonesIzquierda:(UIButton *)[self.view viewWithTag:self.indiceIzquierdoSeleccionado+kIndicesIzquierdo]];
    [self actualizarBotones:sender];
}


-(IBAction) mostrarVentana
{
    ResultadosATerapeutico *resultados = [[ResultadosATerapeutico alloc] initWithNibName:@"ResultadosATerapeutico" bundle:nil];
    resultados.definiciones = self.definicionesIzquierda;
    [self presentModalViewController: resultados animated:YES];

    [resultados release];
}

-(void) aparecerBoton: (UIButton *) unBoton enTiempo: (float) tiempo
{
    [UIView animateWithDuration:tiempo delay:0.0 options:UIViewAnimationCurveEaseOut animations:
     ^{
         
         
         unBoton.alpha = 1.0;
     }
                     completion:nil];    
    
    
}

-(void) desaparecerBoton: (UIButton *) unBoton enTiempo: (float) tiempo
{
    [UIView animateWithDuration:tiempo delay:0.0 options:UIViewAnimationCurveEaseOut animations:
     ^{
         
         
         unBoton.alpha = 0.0;
     }
                     completion:nil];    
    
}


-(IBAction) presionarBotonMedio:(UIButton *)sender
{
    
    if(sender.tag-kIndicesDerecho<15){
        self.indiceMedioSeleccionado = sender.tag - kIndicesMedio;
    }else{
        self.indiceMedioSeleccionado = sender.tag - kIndicesMas;    
        
    }


    int posicionDerecha = [self offsetDerechoAPartirdePosicionMedia:self.indiceMedioSeleccionado];
    
    UIButton *botonDerecha =
    (UIButton *)[self.view viewWithTag:kIndicesDerecho + posicionDerecha];    
    
    UIButton *botonDerechaMenos =
    (UIButton *)[self.view viewWithTag:kIndicesMenos + posicionDerecha];    
    
    
    NSLog(@"Posicion Media Seleccionada: %d. Indice Medio Añadido: %d", self.indiceIzquierdoSeleccionado, [[NSNumber numberWithInt:self.indiceMedioSeleccionado] intValue]);
    
    if ([[self.definicionesIzquierda objectAtIndex:self.indiceIzquierdoSeleccionado] excluyente])
    {        
        NSString *nombre = [NSString stringWithFormat:@"D_%d_%d", posicionDerecha, self.indiceMedioSeleccionado];

        NSString *nombre2 = [NSString stringWithFormat:@"D_%d_%d_h", posicionDerecha, self.indiceMedioSeleccionado];        
        
        [botonDerecha setImage:[UIImage imageNamed:nombre] forState:UIControlStateNormal];    
        [botonDerecha setImage:[UIImage imageNamed:nombre2] forState:UIControlStateHighlighted];            
        
        
        [[(ElementosDerecha *)[self.definicionesIzquierda objectAtIndex:self.indiceIzquierdoSeleccionado] selecccionesDerecha] removeAllObjects];
        
    } 
    else
    {
        [self desaparecerBoton:(UIButton *)[self.view viewWithTag:indiceMedioSeleccionado+kIndicesMedio] enTiempo:0.2];
        [self desaparecerBoton:(UIButton *)[self.view viewWithTag:indiceMedioSeleccionado+kIndicesMenos2] enTiempo:0.1];
        [self desaparecerBoton:(UIButton *)[self.view viewWithTag:indiceMedioSeleccionado+kIndicesMas] enTiempo:0.1];

    }
    
    // Agregar Numero Seleccion
    
    NSNumber *seleccionEnNumero = [NSNumber numberWithInt:self.indiceMedioSeleccionado];
    
    ElementosDerecha *elementoCorrespondiente = (ElementosDerecha *)[self.definicionesIzquierda objectAtIndex:self.indiceIzquierdoSeleccionado];
    
    if (![elementoCorrespondiente.selecccionesDerecha containsObject:seleccionEnNumero])
    {
        [elementoCorrespondiente.selecccionesDerecha addObject:seleccionEnNumero];        
    }
    
    [self aparecerBoton:botonDerecha enTiempo:0.5]; 
    [self aparecerBoton:botonDerechaMenos enTiempo:0.5]; 
    
    if(elementoCorrespondiente.excluyente){
        [self habilitarBotonesIzquierda:(UIButton *)[self.view viewWithTag:self.indiceIzquierdoSeleccionado+kIndicesIzquierdo]];
        [self desaparecerBotonesMedioEnTiempo:0.0];
    }

    [self actualizarBotones:sender];


}

-(int) offsetDerechoAPartirdePosicionMedia: (int) indicePosicion
{
    int resultado=0;
    
    for (int i=0; i<self.indiceIzquierdoSeleccionado;i++)
    {
        ElementosDerecha *elementoActual = (ElementosDerecha *) [self.definicionesIzquierda objectAtIndex:i];
        
        if (elementoActual.excluyente) ++resultado;
        else resultado += elementoActual.numeroElementos;

    }
    if (![[self.definicionesIzquierda objectAtIndex:indiceIzquierdoSeleccionado] excluyente])
    
    resultado += indicePosicion;
    
    return resultado;
}


-(void)deshabilitarBotonesIzquierda:(UIButton *)sender{
    int i;
    for(i=100;i<106;i++){
        if(i!=sender.tag){
            UIButton *temp = (UIButton *)[self.view viewWithTag:i];
            temp.enabled=NO;
        }
    }

}

-(IBAction)dismissOption:(UIButton *)sender{
    
    if(sender.tag-kIndicesDerecho<15){
        self.indiceMedioSeleccionado = sender.tag - kIndicesMedio;
    }else{
        self.indiceMedioSeleccionado = sender.tag - kIndicesMas;    
        
    }
    
    NSNumber *seleccionEnNumero = [NSNumber numberWithInt:self.indiceMedioSeleccionado];
    
    ElementosDerecha *elementoCorrespondiente = (ElementosDerecha *)[self.definicionesIzquierda objectAtIndex:self.indiceIzquierdoSeleccionado];
    
    if (![elementoCorrespondiente.selecccionesDerecha containsObject:seleccionEnNumero])
    {
        [elementoCorrespondiente.selecccionesDerecha addObject:seleccionEnNumero];        
    }
    
    
//    [self habilitarBotonesIzquierda:(UIButton *)[self.view viewWithTag:self.indiceIzquierdoSeleccionado+kIndicesIzquierdo]];
    [self desaparecerBoton:sender enTiempo:0.2];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:sender.tag-300] enTiempo:0.2];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:sender.tag+100] enTiempo:0.2];
    [self actualizarBotones:sender];
}


-(IBAction)limpiar:(id)sender{
    int i;
    for(i=100;i<106;i++){
        UIButton *temp = (UIButton *)[self.view viewWithTag:i];
        temp.enabled=YES;
    }
    [self desaparecerBotonesMedioEnTiempo:0.2];
    int k;
    for (k=0;k<12;k++)
    {
    
            [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesDerecho+k] enTiempo:0.2];
            [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMenos+k] enTiempo:0.2];
    }

    [self desaparecerBoton:botonContinuar enTiempo:0.2];
    [self inicia];
    
}

-(void)habilitarBotonesIzquierda:(UIButton *)sender{
    
    int i;
    for(i=100;i<106;i++){
        ElementosDerecha *tmp=(ElementosDerecha *)[self.definicionesIzquierda objectAtIndex:i-kIndicesIzquierdo];
        if([tmp selecccionesDerecha].count ==0 && tmp.excluyente){

            UIButton *temp = (UIButton *)[self.view viewWithTag:i];
            temp.enabled=YES;
        }else if([tmp selecccionesDerecha].count >= 0 && [tmp selecccionesDerecha].count <tmp.numeroElementos && !tmp.excluyente){
            UIButton *temp = (UIButton *)[self.view viewWithTag:i];
            temp.enabled=YES;
        }
        
    }
    sender.enabled=NO;
    
}

-(IBAction) presionarBotonIzquierdo: (UIButton *) sender
{
    
    self.indiceIzquierdoSeleccionado = sender.tag - kIndicesIzquierdo;
        
    [self deshabilitarBotonesIzquierda:sender];
    
    
    
    BOOL banderaExcluyente = [[self.definicionesIzquierda objectAtIndex:self.indiceIzquierdoSeleccionado] excluyente];    
//    NSLog(@"Indice Izquierdo: %d", self.indiceIzquierdoSeleccionado);
    
    // Alpha de Botones Inecesarios:

    // Desaparecer Todo
    [self desaparecerBotonesMedioEnTiempo:0.0];
//    NSLog(@"Indice: 3%d", kIndicesDerecho + [self offsetDerechoAPartirdePosicionMedia:3]);
//    NSLog(@"Indice: 2%d", kIndicesDerecho + [self offsetDerechoAPartirdePosicionMedia:2]);
//    NSLog(@"Indice: 1%d", kIndicesDerecho + [self offsetDerechoAPartirdePosicionMedia:1]);
//    NSLog(@"Indice: 0%d", kIndicesDerecho + [self offsetDerechoAPartirdePosicionMedia:0]);                
    

        switch ([[self.definicionesIzquierda objectAtIndex:self.indiceIzquierdoSeleccionado] numeroElementos]) {
            case 4:

                if ([[self.view viewWithTag:kIndicesDerecho + [self offsetDerechoAPartirdePosicionMedia:3]] alpha] != 1.0 || banderaExcluyente)
                
                [self actualizarBotonMedio:(UIButton *)[self.view viewWithTag:kIndicesMedio + 3] ];
            case 3:
                if ([[self.view viewWithTag:kIndicesDerecho + [self offsetDerechoAPartirdePosicionMedia:2]] alpha] != 1.0 || banderaExcluyente)            
                [self actualizarBotonMedio:(UIButton *)[self.view viewWithTag:kIndicesMedio + 2] ];
            case 2:
                if ([[self.view viewWithTag:kIndicesDerecho + [self offsetDerechoAPartirdePosicionMedia:1]] alpha] != 1.0 || banderaExcluyente)            
                [self actualizarBotonMedio:(UIButton *)[self.view viewWithTag:kIndicesMedio + 1] ];
            default:
                if ([[self.view viewWithTag:kIndicesDerecho + [self offsetDerechoAPartirdePosicionMedia:0]] alpha] != 1.0 || banderaExcluyente)            
                [self actualizarBotonMedio:(UIButton *)[self.view viewWithTag:kIndicesMedio + 0] ];
        }
    
    [self habilitarBotonesIzquierda:(UIButton *)[self.view viewWithTag:self.indiceIzquierdoSeleccionado+kIndicesIzquierdo]];

}

-(void) actualizarBotonMedio: (UIButton *) unBoton
{
    NSString *nombre = [NSString stringWithFormat:@"M_%d_%d", self.indiceIzquierdoSeleccionado, unBoton.tag-kIndicesMedio];

    NSString *nombre2 = [NSString stringWithFormat:@"M_%d_%d_h", self.indiceIzquierdoSeleccionado, unBoton.tag-kIndicesMedio];
    
    
    UIImage *imagenBoton = [UIImage imageNamed:nombre];
    UIImage *imagenBoton2 = [UIImage imageNamed:nombre2];    
    
    [unBoton setImage:imagenBoton forState:UIControlStateNormal];
    [unBoton setImage:imagenBoton2 forState:UIControlStateHighlighted];
    
    [unBoton setAlpha:1.0];
    if(![[self.definicionesIzquierda objectAtIndex:self.indiceIzquierdoSeleccionado] excluyente]){
        [self aparecerBoton:(UIButton *)[self.view viewWithTag:unBoton.tag+300]  enTiempo:0.02];
        [self aparecerBoton:(UIButton *)[self.view viewWithTag:unBoton.tag+400]  enTiempo:0.02];
    }
}
     
-(void) desaparecerBotonesMedioEnTiempo: (float) tiempo
{
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMedio + 3] enTiempo:tiempo];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMedio + 2] enTiempo:tiempo];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMedio + 1] enTiempo:tiempo];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMedio + 0] enTiempo:tiempo];
    
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMenos2 + 3] enTiempo:tiempo];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMenos2 + 2] enTiempo:tiempo];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMenos2 + 1] enTiempo:tiempo];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMenos2 + 0] enTiempo:tiempo];

    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMas + 3] enTiempo:tiempo];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMas + 2] enTiempo:tiempo];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMas + 1] enTiempo:tiempo];
    [self desaparecerBoton:(UIButton *)[self.view viewWithTag:kIndicesMas + 0] enTiempo:tiempo];    
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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	_mainView = [[MainView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];		//initialize a mainView
	self.view=_mainView;	//make the mainView as the view of this controller
	[_mainView release];	//don't forget to release what you've been allocated
	
}

-(void) viewDidAppear:(BOOL)animated
{
//    [self mostrarVentana];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    


    
    /*
    
    // Ajustar Tamaño Scroll
    //self.scrollParaSlides.contentSize = CGSizeMake(kPantallaAncho * kNumeroDiapositivas, kPantallaAlto);

    NSLog(@"Tamaños: Width: %f Height: %f", self.view.frame.size.width, self.view.frame.size.height);
    
    // Crear Imagenes de Diapositivas.
    
    NSString *nombreImagen =@"Diapositiva_0";
    
    UIImageView *imagen = [[UIImageView alloc] initWithImage: [UIImage imageNamed:nombreImagen]];
    imagen.frame = CGRectMake(0, 0, kPantallaAncho, kPantallaAlto);
    [self.scrollParaSlides addSubview:imagen];
    [imagen release];
    
        // Crear HTML5
    int i;
    for (i=2;i<5;i++)
    {
        NSString *nomArchivo = [NSString stringWithFormat:@"%dapag",i];    
        NSString *fileString = [[NSBundle mainBundle] pathForResource: nomArchivo ofType: @"html" ];
    
        NSURL *newURL = [[NSURL alloc] initFileURLWithPath: fileString];
        //NSString *html = [NSString stringWithContentsOfFile:fileString 
        //                                           encoding:NSUTF8StringEncoding 
         //                                             error:nil];
        NSURLRequest *newURLRequest = [[NSURLRequest alloc] initWithURL: newURL];
        //NSString *path = [[NSBundle mainBundle] bundlePath];
        //NSURL *baseURL = [NSURL fileURLWithPath:path];
        UIWebView *dummy = [[UIWebView alloc] initWithFrame:CGRectMake(kPantallaAncho*(i-1), 0, kPantallaAncho, kPantallaAlto)];    
//        slide.frame = CGRectMake(kPantallaAncho*(i-1), 0, kPantallaAncho-255, kPantallaAlto*2);
//        [slide loadRequest: newURLRequest];    
//        slide.userInteractionEnabled = NO;
        
        [self.scrollParaSlides addSubview:dummy];
        //[dummy loadHTMLString:html 
          //            baseURL:[[NSURL alloc] initFileURLWithPath: fileString]];
        
        
        [dummy loadRequest:newURLRequest];   
        [[[dummy subviews] lastObject] setScrollEnabled:NO];
        [dummy release];
    }
    
    
//    int i;
//    for (i=0; i<kNumeroDiapositivas-1; i++)
//    {
//        NSString *nombreImagen = [NSString stringWithFormat:@"Diapositiva_%d", i];
//        
//        UIImageView *imagen = [[UIImageView alloc] initWithImage: [UIImage imageNamed:nombreImagen]];
//        imagen.frame = CGRectMake(kPantallaAncho * i, 0, kPantallaAncho, kPantallaAlto);
//        //[self.scrollParaSlides addSubview:imagen];
//        [imagen release];
//
//        
//    }

    // Agregar Diapositiva con el ultimo View: Tratamiento Diagnostico


    UIView *vistaADiagnostico = [[[NSBundle mainBundle] loadNibNamed:@"ATerapeuticoView" owner:self options:nil] lastObject];					
    
    vistaADiagnostico.frame = CGRectMake(kPantallaAncho * 4, 0, kPantallaAncho, kPantallaAlto);
    [self.scrollParaSlides addSubview:vistaADiagnostico];
    */
     UIView *vistaADiagnostico = [[[NSBundle mainBundle] loadNibNamed:@"ATerapeuticoView" owner:self options:nil] lastObject];					
     
     vistaADiagnostico.frame = CGRectMake(0, 0, kPantallaAncho, kPantallaAlto);
     
     [_mainView.paginas addObject:vistaADiagnostico];
    
    // Definiciones de Botones Izquierda:
   
    [self inicia];
    


    [super viewDidLoad];
}

-(void)inicia{
    self.definicionesIzquierda = [[NSArray alloc] initWithObjects:
                                  
                                  [[ElementosDerecha alloc] initConNumero:2 
                                                             esExcluyente:YES 
                                                  conPosicionesIzquierdas: [NSArray arrayWithObject: [NSNumber numberWithInt:0] ]],  // Tipo
                                  
                                  [[ElementosDerecha alloc] initConNumero:3 
                                                             esExcluyente:YES 
                                                  conPosicionesIzquierdas:
                                   [NSArray arrayWithObject: [NSNumber numberWithInt:1]] ],  // Fluoro         
                                  
                                  [[ElementosDerecha alloc] initConNumero:4 
                                                             esExcluyente:NO 
                                                  conPosicionesIzquierdas: [NSArray  arrayWithObjects:
                                                                            [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:5], nil]],// Qt
                                  
                                  [[ElementosDerecha alloc] initConNumero:3 
                                                             esExcluyente:YES 
                                                  conPosicionesIzquierdas:[NSArray arrayWithObject: [NSNumber numberWithInt:6] ]], // Add              
                                  
                                  [[ElementosDerecha alloc] initConNumero:2 
                                                             esExcluyente:YES 
                                                  conPosicionesIzquierdas:[NSArray arrayWithObject: [NSNumber numberWithInt:7]]], // KRAS  
                                  
                                  [[ElementosDerecha alloc] initConNumero:4 
                                                             esExcluyente:NO 
                                                  conPosicionesIzquierdas:[NSArray arrayWithObjects: [NSNumber numberWithInt:8],[NSNumber numberWithInt:9],[NSNumber numberWithInt:10],[NSNumber numberWithInt:11], nil]], // POrque
                                  
                                  
                                  //                                  [[ElementosDerecha alloc] initConNumero:4 
                                  //                                                             esExcluyente:YES conPosicionesIzquierdas:[NSArray arrayWithObject: [NSNumber numberWithInt:11]]], // Color                                                                                                 
                                  nil];
    
    self.posicionesDerechaOrden = [NSArray arrayWithObjects:
                                   [NSNumber numberWithInt:0], // 1
                                   [NSNumber numberWithInt:0], // 2 
                                   [NSNumber numberWithInt:0], // 3
                                   [NSNumber numberWithInt:1], // 4
                                   [NSNumber numberWithInt:2], // 5
                                   [NSNumber numberWithInt:3], // 6
                                   [NSNumber numberWithInt:0], // 7
                                   [NSNumber numberWithInt:0], // 8
                                   [NSNumber numberWithInt:0], // 9
                                   [NSNumber numberWithInt:1], // 10
                                   [NSNumber numberWithInt:2], // 11
                                   [NSNumber numberWithInt:3], // 12
                                   //[NSNumber numberWithInt:0], // 12                                          
                                   nil];
    
    
    
    self.posicionesDerechaEquivalentes = [NSArray arrayWithObjects:
                                          
                                          [self.definicionesIzquierda objectAtIndex:0], // 1
                                          [self.definicionesIzquierda objectAtIndex:1], // 2 
                                          [self.definicionesIzquierda objectAtIndex:2], // 3
                                          [self.definicionesIzquierda objectAtIndex:2], // 4
                                          [self.definicionesIzquierda objectAtIndex:2], // 5
                                          [self.definicionesIzquierda objectAtIndex:2], // 6
                                          [self.definicionesIzquierda objectAtIndex:3], // 7
                                          [self.definicionesIzquierda objectAtIndex:4], // 8
                                          [self.definicionesIzquierda objectAtIndex:5], // 9
                                          [self.definicionesIzquierda objectAtIndex:5], // 10
                                          [self.definicionesIzquierda objectAtIndex:5], // 11
                                          [self.definicionesIzquierda objectAtIndex:5], // 12
                                          //[self.definicionesIzquierda objectAtIndex:6], // 12                                          
                                          nil
                                          
                                          ];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) return YES;
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)return YES;
    else return NO;

}

@end
