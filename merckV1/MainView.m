//
//  MainView.m
//  merckV1
//
//  Created by David Rodriguez on 9/11/11.
//  Copyright (c) 2011 UNAM. All rights reserved.
//

#import "MainView.h"



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
    
    CGRect pathRect = CGRectInset(self.animationLayer.bounds, 100.0f, 100.0f);
    CGPoint inicial = CGPointMake(717.49f, 228.31f);
    CGPoint topLeft		= CGPointMake(CGRectGetMinX(pathRect), CGRectGetMinY(pathRect) + CGRectGetHeight(pathRect) * 2.0f/3.0f);
    CGPoint bottomLeft 	= CGPointMake(CGRectGetMinX(pathRect), CGRectGetMinY(pathRect));

    CGPoint bottomRight = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMinY(pathRect));
    CGPoint topRight	= CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMinY(pathRect) + CGRectGetHeight(pathRect) * 2.0f/3.0f);
    
    
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
    pathLayer.lineWidth = 10.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [self.animationLayer addSublayer:pathLayer];
    
    self.pathLayer = pathLayer;
}


- (void) startAnimation
{
    [self.pathLayer removeAllAnimations];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    
}  


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //717.49f, 228.31f
        self.animationLayer = [CALayer layer];
        self.animationLayer.frame = CGRectMake(668.0f, 220.0f, 
                                               93.0f, 
                                               427.0f);
        [self.layer addSublayer:self.animationLayer];
        
        
        
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
        NSString *pag2=@"pagina2";
        UIImageView *pagina1 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:pag2]];
        pagina1.frame = CGRectMake(0, 0, kPantallaAncho, kPantallaAlto);
        pagina1.backgroundColor = [UIColor whiteColor];
        [paginas addObject:pagina1];
        
        
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
        if (swipes==3) {
            

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
