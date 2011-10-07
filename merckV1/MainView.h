//
//  MainView.h
//  merckV1
//
//  Created by David Rodriguez on 9/11/11.
//  Copyright (c) 2011 UNAM. All rights reserved.
//

#import <UIKit/UIKit.h>

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
}
@property(nonatomic,retain)NSMutableArray *paginas;
@property (nonatomic, assign) int swipes;





-(void)produceHTMLForPage:(NSInteger)pagina withRightDirection:(BOOL)direction;



@end