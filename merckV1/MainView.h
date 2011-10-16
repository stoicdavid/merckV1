//
//  MainView.h
//  merckV1
//
//  Created by David Rodriguez on 9/11/11.
//  Copyright (c) 2011 UNAM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "page.h"
#import <QuartzCore/QuartzCore.h>
#import "ResultadosATerapeutico.h"
#import "ElementosDerecha.h"
#import "merckV1ViewController.h"

@interface MainView : UIView <UIGestureRecognizerDelegate>{
    NSMutableArray *paginas;			//array of pages
    int swipes;
    UIImageView *imagen;
    UIWebView *vista2;
    UIWebView *vista3;
    //gesture & touch
    ////shaking capability
    //BOOL shake;
    //UIAccelerometer *accelerometer;
    //UIAccelerationValue totalG;
    CALayer *_animationLayer;
    CAShapeLayer *_pathLayer;
}
@property(nonatomic,retain)NSMutableArray *paginas;
@property (nonatomic, assign) int swipes;
@property (nonatomic, retain) CALayer *animationLayer;
@property (nonatomic, retain) CAShapeLayer *pathLayer;




-(void)produceHTMLForPage:(NSInteger)pagina withRightDirection:(BOOL)direction;



@end