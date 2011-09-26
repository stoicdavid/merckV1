//
//  merckV1ViewController.h
//  merckV1
//
//  Created by Hector Zarate on 8/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"


@interface merckV1ViewController : UIViewController {
    
    UIButton *botonContinuar;
    
  //  UIScrollView *scrollParaSlides;

    MainView* _mainView;
    
    NSArray *posicionesDerechaOrden;
    
    NSArray *definicionesIzquierda;
    
    NSArray *posicionesDerechaEquivalentes;
    
    int indiceDerechoSeleccionado;
    int indiceMedioSeleccionado;
    int indiceIzquierdoSeleccionado;    
    
}

@property (nonatomic,retain)MainView* _mainView;

@property (nonatomic, retain) NSArray *posicionesDerechaOrden;

@property (nonatomic, retain) NSArray *posicionesDerechaEquivalentes;

@property (nonatomic, retain) IBOutlet UIButton *botonContinuar;


@property (nonatomic, retain) NSArray *definicionesIzquierda;


@property (nonatomic, assign) int indiceDerechoSeleccionado;
@property (nonatomic, assign) int indiceMedioSeleccionado;
@property (nonatomic, assign) int indiceIzquierdoSeleccionado;

//@property (nonatomic, retain) IBOutlet UIScrollView *scrollParaSlides;
-(IBAction)limpiar:(id)sender;

-(IBAction) mostrarVentana;

-(BOOL) revisarLlenadoBotones;

-(void)inicia;

-(void) actualizarBotones:(id) sender;

-(void) aparecerBoton: (UIButton *) unBoton enTiempo: (float) elTiempo;
-(void) desaparecerBoton: (UIButton *) unBoton enTiempo: (float) elTiempo;

-(int) offsetDerechoAPartirdePosicionMedia: (int) indicePosicion;

-(void) actualizarBotonMedio: (UIButton *) unBoton;

-(void)deshabilitarBotonesIzquierda:(UIButton *)sender;
-(void)habilitarBotonesIzquierda:(UIButton *)sender;

-(void) desaparecerBotonesMedioEnTiempo: (float) elTiempo;

-(IBAction) presionarBotonIzquierdo: (UIButton *) sender;
-(IBAction) presionarBotonMedio: (UIButton *) sender;
-(IBAction) presionarBotonDerecho: (UIButton *) sender;

-(IBAction)dismissOption:(UIButton *)sender;



@end
