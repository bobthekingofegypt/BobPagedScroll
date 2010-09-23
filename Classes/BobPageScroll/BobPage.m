#import "BobPage.h"


@implementation BobPage

@synthesize index = _index, reuseIdentifier = _reuseIdentifier;

- (id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithFrame:frame])) {
        _reuseIdentifier = [reuseIdentifier copy];
		
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[_reuseIdentifier release];
    [super dealloc];
}


@end
