#import "FullScreenNumberPage.h"


@implementation FullScreenNumberPage

@synthesize number;

-(id) initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame andReuseIdentifier:reuseIdentifier]) {
		self.backgroundColor = [UIColor whiteColor];
		
		number = [[UILabel alloc] initWithFrame:frame];
		number.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		number.textAlignment = UITextAlignmentCenter;
		number.font = [UIFont systemFontOfSize:170.0f];
		number.textColor = [UIColor blackColor];
		number.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.35];
		number.shadowOffset = CGSizeMake(0, -1.0);
		number.backgroundColor = [UIColor clearColor];
		[self addSubview:number];
	}
	
	return self;
}

-(void) dealloc {
	[number release];
	
	[super dealloc];
}

@end
