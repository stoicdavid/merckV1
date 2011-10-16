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
#define kPantallaAlto 768
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
        
        imagen = [[UIImageView alloc] initWithImage: [UIImage imageNamed:nombreImagen]];
        imagen.frame = CGRectMake(0, 0, kPantallaAncho, kPantallaAlto);
        imagen.backgroundColor = [UIColor whiteColor];
        [paginas addObject:imagen];

        NSString *nombreImagen2 =@"home2";
        UIImageView *imagen2 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:nombreImagen2]];
        imagen2.frame = CGRectMake(0, 0, kPantallaAncho, kPantallaAlto);

        imagen2.backgroundColor = [UIColor whiteColor];
        [paginas addObject:imagen2];
        
        //Agregar animaciones HTML5
        vista2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kPantallaAncho, kPantallaAlto)];
        //vista3 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kPantallaAncho, kPantallaAlto)];
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
            
            
            [self produceHTMLForPage:swipes withRightDirection:YES];
        }else{
            [self produceHTMLForPage:swipes-1 withRightDirection:YES];
            swipes--;
//            CATransition *animation = [CATransition animation];
//            [animation setDuration:0.5];
//            [animation setType:kCATransitionPush];
//            UIInterfaceOrientation orienta = [[UIApplication sharedApplication] statusBarOrientation];
//            if (orienta ==UIInterfaceOrientationLandscapeLeft) {
//                [animation setSubtype:kCATransitionFromTop];
//            }else{
//                [animation setSubtype:kCATransitionFromBottom];
//            }
//            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//            
//            [[self layer] addAnimation:animation forKey:nil];
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


            [self produceHTMLForPage:swipes+1 withRightDirection:NO];
            //[[paginas objectAtIndex:swipes ] removeFromSuperview];
            
            swipes++;
            

            
        }
        
    }
}

-(void)produceHTMLForPage:(NSInteger)pageNumber withRightDirection:(BOOL)direction{
    
    
    if ([[paginas objectAtIndex:pageNumber] isKindOfClass:[page class]])
    {
        
//        imagen.hidden=YES;
//        vista2=(UIWebView *)self;
//        vista2.hidden=YES;
        [vista3 removeFromSuperview];
        [[paginas objectAtIndex:paginas.count-1] removeFromSuperview];
        [[paginas objectAtIndex:0] removeFromSuperview];
        vista3 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kPantallaAncho, kPantallaAlto)];
        vista3.backgroundColor = [UIColor whiteColor];
        [self addSubview:vista3];
        vista3.hidden=NO;
        NSURLRequest *newURLRequest = [[NSURLRequest alloc] initWithURL: [[paginas objectAtIndex:pageNumber] pag] ];
        
        [vista3 loadRequest:newURLRequest];     
        //[dummy release];
        
        
        
        

        
        
        
        
        //    }else if ([[paginas objectAtIndex:pageNumber] isKindOfClass:[UIImageView class]]){
    }else {

        [self addSubview:[paginas objectAtIndex:pageNumber]];
        //imagen.hidden=NO;
    }
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.4];
    [animation setType:kCATransitionPush];
    UIInterfaceOrientation orienta = [[UIApplication sharedApplication] statusBarOrientation];
    if(!direction){
        if (orienta ==UIInterfaceOrientationLandscapeLeft)
            [animation setSubtype:kCATransitionFromBottom];
        else
            [animation setSubtype:kCATransitionFromTop];
    }else{
        if (orienta ==UIInterfaceOrientationLandscapeLeft) 
            [animation setSubtype:kCATransitionFromTop];
        else
            [animation setSubtype:kCATransitionFromBottom];            
    }
    
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [[self layer] addAnimation:animation forKey:nil];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (swipes==0) {
        [self addSubview:imagen];
    }else{
        [self addSubview:vista3];
    }
}

-(void)dealloc{
    [paginas dealloc];
    [imagen dealloc];
    [vista2 dealloc];
    [vista3 dealloc];    
    [super dealloc];
}


@end
