//
//  MainView.m
//  merckV1
//
//  Created by David Rodriguez on 9/11/11.
//  Copyright (c) 2011 UNAM. All rights reserved.
//

#import "MainView.h"
#import "page.h"
#import <QuartzCore/QuartzCore.h>
#import "ResultadosATerapeutico.h"
#import "ElementosDerecha.h"
#import "merckV1ViewController.h"


#define kPantallaAncho 1024
#define kPantallaAlto 748
#define kIndicesDerecho 300
#define kIndicesMedio 200
#define kIndicesIzquierdo 100


@implementation MainView
@synthesize paginas,swipes;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //Agregar vista inicial
        
        self.backgroundColor=[UIColor whiteColor];

        swipes = 0;
        paginas =[[NSMutableArray alloc]initWithCapacity:5];
        NSString *nombreImagen =@"Diapositiva_0";
        
        UIImageView *imagen = [[UIImageView alloc] initWithImage: [UIImage imageNamed:nombreImagen]];
        imagen.frame = CGRectMake(0, 0, kPantallaAncho, kPantallaAlto);
        imagen.backgroundColor = [UIColor whiteColor];
        [paginas addObject:imagen];
        [imagen release];

        //Agregar animaciones HTML5
        int i;
        for (i=2;i<5;i++)
        {

            page *diapo = [[page alloc] init ];
            NSString *nomArchivo = [NSString stringWithFormat:@"%dapag",i];    
            NSString *fileString = [[NSBundle mainBundle] pathForResource: nomArchivo ofType: @"html" ];
            NSURL *newURL = [[NSURL alloc] initFileURLWithPath: fileString];    
            diapo.pag = newURL;
            [paginas addObject:diapo];
            [diapo release];
        }        
        
        //Agregar reconocedor de gesturas
        
         UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(swipeRightAction:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        swipeRight.delegate = self;
        [self addGestureRecognizer:swipeRight];
        [swipeRight release];
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        swipeLeft.delegate = self;
        [self addGestureRecognizer:swipeLeft];
        [swipeLeft release];
        
        
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)swipeRightAction:(id)ignored
{
    NSLog(@"Swipe Right");
    //add Function
    if (swipes>=0 ) {
        if (swipes==0) {
         
            
            [self produceHTMLForPage:swipes];
        }else{
            [self produceHTMLForPage:swipes-1];
            swipes--;
        }
    }
}

- (void)swipeLeftAction:(id)ignored
{
    
    
    NSLog(@"Swipe Left");
    //add Function
    if (swipes<=paginas.count-1 ) {
        if (swipes==paginas.count-1) {

     
            //[[paginas objectAtIndex:swipes-1 ] removeFromSuperview];
           
        }else{

            [self produceHTMLForPage:swipes+1];
            //[[paginas objectAtIndex:swipes ] removeFromSuperview];

            swipes++;
        }
   
    }
}

-(void)produceHTMLForPage:(NSInteger)pageNumber{
    
    
    if ([[paginas objectAtIndex:pageNumber] isKindOfClass:[page class]])
    {

             
     UIWebView *dummy = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kPantallaAncho, kPantallaAlto)];
     [self addSubview: dummy];
     NSURLRequest *newURLRequest = [[NSURLRequest alloc] initWithURL: [[paginas objectAtIndex:pageNumber] pag] ];

     [dummy loadRequest:newURLRequest];     
     [dummy release];
 
        
       
//    }else if ([[paginas objectAtIndex:pageNumber] isKindOfClass:[UIImageView class]]){
      }else {

               [self addSubview:[paginas objectAtIndex:pageNumber]];

    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self addSubview:[paginas objectAtIndex:swipes]];

}

-(void)dealloc{
    [paginas dealloc];
    
       
    [super dealloc];
}


@end
