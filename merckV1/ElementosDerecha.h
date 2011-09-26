//
//  ElementosDerecha.h
//  merckV1
//
//  Created by Hector Zarate on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ElementosDerecha : NSObject {
    
//    BOOL editado;
    NSMutableArray *seleccionesDerecha;
    NSArray *posicionesDerecha;
    BOOL excluyente;
    char numeroElementos;

}

//@property (nonatomic, assign) BOOL editado;
@property (nonatomic, retain) NSMutableArray *selecccionesDerecha;
@property (nonatomic, assign) BOOL excluyente;
@property (nonatomic, assign) char numeroElementos; 
@property (nonatomic, retain) NSArray *posicionesDerecha;



-(id) initConNumero: (char) unNumero esExcluyente: (BOOL) banderaExcluyente conPosicionesIzquierdas:(NSArray *) posiciones;


@end