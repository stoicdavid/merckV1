//
//  page.m
//  Reader
//
//  Created by David Samuel on 6/6/10.
//  Copyright 2010 Institut Teknologi Bandung. All rights reserved.
//

#import "page.h"


@implementation page
@synthesize pag;

-(id)init{						//method called for the initialization of this object
	if(self=[super init]){}
	return self;
}

-(void)dealloc{					//method called when object is released
	[pag release];			//release each member of this object

	[super dealloc];
}

@end
