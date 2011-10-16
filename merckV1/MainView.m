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
@synthesize animationLayer = _animationLayer;
@synthesize pathLayer = _pathLayer;


- (void) setupDrawingLayer
{
    if (self.pathLayer != nil) {
        [self.pathLayer removeFromSuperlayer];
        self.pathLayer = nil;
    }
    
    CGRect pathRect = CGRectInset(self.animationLayer.bounds, 0.0, 0.0);
    CGPoint inicial = CGPointMake(717.49f, 210.0f);
    CGPoint topLeft		= CGPointMake(668,210);
    CGPoint bottomLeft 	= CGPointMake(668,-220);

    CGPoint bottomRight = CGPointMake(761,-220);
    CGPoint topRight	= CGPointMake(761,210);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:inicial];
    [path addLineToPoint:topLeft];
    [path addLineToPoint:bottomLeft];
    [path addLineToPoint:bottomRight];
    [path addLineToPoint:topRight];
    [path addLineToPoint:inicial];

    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.animationLayer.bounds;
    pathLayer.bounds = pathRect;
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor orangeColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 5.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [self.animationLayer addSublayer:pathLayer];
    //[vista.layer addSublayer:pathLayer];
    
    self.pathLayer = pathLayer;
        [self.layer addSublayer:self.animationLayer];
}


- (void) startAnimation
{
    [self.pathLayer removeAllAnimations];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];

    
    
}  


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //717.49f, 228.31f
        
        
        
        
        
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
            if(i!=3){
            page *diapo = [[page alloc] init ];
            NSString *nomArchivo = [NSString stringWithFormat:@"%dapag",i];    
            NSString *fileString = [[NSBundle mainBundle] pathForResource: nomArchivo ofType: @"html" ];
            NSURL *newURL = [[NSURL alloc] initFileURLWithPath: fileString];    
            diapo.pag = newURL;
            [paginas addObject:diapo];
            [diapo release];
            }else{
                NSString *pag2=@"pagina2";
                UIImageView *anima2 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:pag2]];
                //UIImageView *pagina1 = [[UIImageView alloc] init];
                anima2.frame = CGRectMake(0, 0, kPantallaAncho, kPantallaAlto);
                //pagina1.backgroundColor = [UIColor orangeColor];
                //pagina1.alpha=0.5;
                
                [paginas addObject:anima2];
                self.animationLayer = [CALayer layer];
                self.animationLayer.frame = CGRectMake(0.0, 0.0, 
                                                       93.0f, 
                                                       427.0f);
            }
            
            
        }        
       
        
        //[self setupDrawingLayer];
        //[self startAnimation];
        

        
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
            
            
            swipes++;
            

            
        }
        
    }
}

-(void)produceHTMLForPage:(NSInteger)pageNumber withRightDirection:(BOOL)direction{
    
    
    if ([[paginas objectAtIndex:pageNumber] isKindOfClass:[page class]])
    {
        
        [vista3 removeFromSuperview];
        [[paginas objectAtIndex:paginas.count-1] removeFromSuperview];
        [[paginas objectAtIndex:0] removeFromSuperview];
        [[paginas objectAtIndex:1] removeFromSuperview];
        vista3 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kPantallaAncho, kPantallaAlto)];
        vista3.backgroundColor = [UIColor whiteColor];
        [self addSubview:vista3];
        vista3.hidden=NO;
        NSURLRequest *newURLRequest = [[NSURLRequest alloc] initWithURL: [[paginas objectAtIndex:pageNumber] pag] ];
        [vista3 loadRequest:newURLRequest];     
    }else {
            [vista3 removeFromSuperview];
            [[paginas objectAtIndex:paginas.count-1] removeFromSuperview];
            [[paginas objectAtIndex:0] removeFromSuperview];
            [[paginas objectAtIndex:1] removeFromSuperview];
            [self addSubview:[paginas objectAtIndex:pageNumber]];
        if (pageNumber ==3 ) {
            [self.layer addSublayer:self.animationLayer];
            [self setupDrawingLayer];
            [self startAnimation];
        }            
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
    self.animationLayer = nil;
    self.pathLayer = nil;

    [super dealloc];
}


@end
