//
//  ElementosDerecha.m
//  merckV1
//
//  Created by Hector Zarate on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ElementosDerecha.h"


@implementation ElementosDerecha

@synthesize numeroElementos, excluyente;
@synthesize posicionesDerecha;
@synthesize selecccionesDerecha;

//@synthesize editado;

-(id) initConNumero: (char) unNumero esExcluyente: (BOOL) banderaExcluyente conPosicionesIzquierdas:(NSArray *) posiciones
{
    if ((self = [super init]))
    {
        excluyente = banderaExcluyente;
        numeroElementos = unNumero;
        posicionesDerecha = [[NSArray alloc] initWithArray:posiciones];
        selecccionesDerecha = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    //NSLog(@"Numero de Elementos: %d", [self.posicionesDerecha count]);
    int i;
    for(i=0; i< [self.posicionesDerecha count]; i++)
    {
        NSLog(@"Numero: %d", [[self.posicionesDerecha objectAtIndex:i] intValue]);
    }
    
    return self;
}

-(void) dealloc
{
    [posicionesDerecha release];
    [selecccionesDerecha release];
    [super dealloc];
}

@end
