#import "MySingleton.h"
#import "GMGridViewCell+Extended.h"
#import "UIView+GMGridViewAdditions.h"
#import "Photo.h"

//////////////////////////////////////////////////////////////
#pragma mark - Interface Private
//////////////////////////////////////////////////////////////

@interface GMGridViewCell(Private)

- (void)actionDelete;

@end

//////////////////////////////////////////////////////////////
#pragma mark - Implementation GMGridViewCell
//////////////////////////////////////////////////////////////

@implementation GMGridViewCell

@synthesize contentView = _contentView;
@synthesize editing = _editing;
@synthesize inShakingMode = _inShakingMode;
@synthesize fullSize = _fullSize;
@synthesize fullSizeView = _fullSizeView;
@synthesize inFullSizeMode = _inFullSizeMode;
@synthesize defaultFullsizeViewResizingMask = _defaultFullsizeViewResizingMask;
@synthesize deleteButton = _deleteButton;
@synthesize deleteBlock = _deleteBlock;
@synthesize deleteButtonIcon = _deleteButtonIcon;
@synthesize flag = _flag;
@synthesize deleteButtonOffset = _deleteButtonOffset;
@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize lab = _lab;
@synthesize fileName = _fileName;
@synthesize ind = _ind;
@synthesize eventsInited = _eventsInited;

//////////////////////////////////////////////////////////////
#pragma mark Constructors
//////////////////////////////////////////////////////////////

- (id)init
{
    return self = [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.autoresizesSubviews = !YES;
        self.editing = NO;
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteButton = deleteButton;
        [self.deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.deleteButton.showsTouchWhenHighlighted = YES;
        self.deleteButtonIcon = nil;
        self.deleteButtonOffset = CGPointMake(-5, -5);
        self.deleteButton.alpha = 0;
        [self addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(actionDelete) forControlEvents:UIControlEventTouchUpInside];
        self.ind = -1;
        self.eventsInited = NO;
    }
    return self;
}

-(void)updateKeys
{
    if (self.ind < 0)
        return;
    
    Photo *photo = (Photo *)[gSingleton.mainData objectAtIndex:self.ind];
    photo.selected = self.flag;
}

-(void)eventHandlerClear: (NSNotification *) notification
{
    self.flag = NO;
    self.backgroundColor = [UIColor clearColor];
}

-(void)eventHandlerLabel: (NSNotification *) notification
{
    if (self.ind < 0)
        return;
    
    BOOL doLab = NO;
    
    Photo *photo = (Photo *)[gSingleton.mainData objectAtIndex:self.ind];
    if (gSingleton.expandOn)
    {
        if (gSingleton.expandedViewIndex == self.ind)
        {
            doLab = YES;
        }
    }
    else
    {
        if (self.flag)
        {
            doLab = YES;
        }
        else if (photo.selected)
        {
            doLab = YES;
        }
    }
    
    if (doLab)
    {
        if (gSingleton.showTrace)
            NSLog(@"labelEvent (GridViewCell) %d, %d, %@", self.ind, gSingleton.expandedViewIndex, gSingleton.expandOn ? @"YES" : @"NO");

        if ([[gSingleton currentLabelDescription] length] == 0)
            self.lab.text = [gSingleton currentLabelString];
        else
            self.lab.text = [gSingleton currentLabelDescription];
        self.backgroundColor = [UIColor clearColor];
        self.flag = NO;

        /*
        we must change the key to a unique identifier in order for this to work
        currently, the filename is intertwined into the code
        refactoring is necessary
        unsigned int timestamp = [[NSDate date] timeIntervalSince1970];
        
        NSString *newName = [NSString stringWithFormat:@"%@_%i.jpg", gSingleton.currentLabelString, timestamp];
        [gSingleton renameImage:self.fileName withName:newName];

        self.fileName = newName;
        */
        [self updateKeys];
    }
}

-(void) dealloc
{
    //NSLog(@"GMGridViewCell dealloc %d", self.ind);
    if (self.eventsInited)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"labelEvent" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"clearEvent" object:nil];
        self.eventsInited = NO;
    }
}

- (void) toggleSel
{
    if (self.flag == NO)
    {
        self.backgroundColor = [UIColor blueColor];
        self.flag = YES;
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
        self.flag = NO;
    }
    [self updateKeys];
}


//////////////////////////////////////////////////////////////
#pragma mark UIView
//////////////////////////////////////////////////////////////

- (void)setFrame:(CGRect)frame;
{
    //if (gSingleton.showTrace)
    //{
    //    NSLog(@"GridViewCell setFrame(%d, %.0f, %.0f, %.0f, %.0f)", self.ind, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    //}
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    if(self.inFullSizeMode)
    {
        CGPoint origin = CGPointMake((self.bounds.size.width - self.fullSize.width) / 2, 
                                     (self.bounds.size.height - self.fullSize.height) / 2);
        self.fullSizeView.frame = CGRectMake(origin.x, origin.y, self.fullSize.width, self.fullSize.height);
    }
    else
    {
        self.fullSizeView.frame = self.bounds;
    }
}

//////////////////////////////////////////////////////////////
#pragma mark Setters / getters
//////////////////////////////////////////////////////////////

- (void)setContentView:(UIView *)contentView
{
    [self shake:NO];
    [self.contentView removeFromSuperview];
    
    if(self.contentView)
    {
        contentView.frame = self.contentView.frame;
    }
    else
    {
        contentView.frame = self.bounds;
    }
    
    _contentView = contentView;
    
    self.contentView.autoresizingMask = UIViewAutoresizingNone;
    [self addSubview:self.contentView];
    
    [self bringSubviewToFront:self.deleteButton];
}

- (void)setFullSizeView:(UIView *)fullSizeView
{
    if ([self isInFullSizeMode]) 
    {
        fullSizeView.frame = _fullSizeView.frame;
        fullSizeView.alpha = _fullSizeView.alpha;
    }
    else
    {
        fullSizeView.frame = self.bounds;
        fullSizeView.alpha = 0;
    }
    
    self.defaultFullsizeViewResizingMask = fullSizeView.autoresizingMask | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    fullSizeView.autoresizingMask = _fullSizeView.autoresizingMask;
    
    [_fullSizeView removeFromSuperview];
    _fullSizeView = fullSizeView;
    [self addSubview:_fullSizeView];
    
    [self bringSubviewToFront:self.deleteButton];
}

- (void)setFullSize:(CGSize)fullSize
{
    _fullSize = fullSize;
    
    [self setNeedsLayout];
}

- (void)setEditing:(BOOL)editing
{
    [self setEditing:editing animated:NO];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (editing != _editing) {
        _editing = editing;
        if (animated) {
            [UIView animateWithDuration:0.2f
                                  delay:0.f
                                options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut
                             animations:^{
                                 self.deleteButton.alpha = editing ? 1.f : 0.f;
                             }
                             completion:nil];
        }else {
            self.deleteButton.alpha = editing ? 1.f : 0.f;
        }

        self.contentView.userInteractionEnabled = !editing;
        [self shakeStatus:editing];
    }
}

- (void)setDeleteButtonOffset:(CGPoint)offset
{
    self.deleteButton.frame = CGRectMake(offset.x, 
                                         offset.y, 
                                         self.deleteButton.frame.size.width, 
                                         self.deleteButton.frame.size.height);
}

- (CGPoint)deleteButtonOffset
{
    return self.deleteButton.frame.origin;
}

- (void)setDeleteButtonIcon:(UIImage *)deleteButtonIcon
{
    [self.deleteButton setImage:deleteButtonIcon forState:UIControlStateNormal];
    
    if (deleteButtonIcon) 
    {
        self.deleteButton.frame = CGRectMake(self.deleteButton.frame.origin.x, 
                                             self.deleteButton.frame.origin.y, 
                                             deleteButtonIcon.size.width, 
                                             deleteButtonIcon.size.height);
        
        [self.deleteButton setTitle:nil forState:UIControlStateNormal];
        [self.deleteButton setBackgroundColor:[UIColor clearColor]];
    }
    else
    {
        self.deleteButton.frame = CGRectMake(self.deleteButton.frame.origin.x, 
                                             self.deleteButton.frame.origin.y, 
                                             35, 
                                             35);
        
        [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
        [self.deleteButton setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    
}

- (UIImage *)deleteButtonIcon
{
    return [self.deleteButton currentImage];
}

//////////////////////////////////////////////////////////////
#pragma mark Private methods
//////////////////////////////////////////////////////////////

- (void)actionDelete
{
    if (self.deleteBlock) 
    {
        self.deleteBlock(self);
    }
}

//////////////////////////////////////////////////////////////
#pragma mark Public methods
//////////////////////////////////////////////////////////////

-(void) initEvents
{
    if (!self.eventsInited)
    {
        self.eventsInited = YES;

        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(eventHandlerClear:)
         name:@"clearEvent"
         object:nil ];
    
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(eventHandlerLabel:)
         name:@"labelEvent"
         object:nil ];
    }
    //else
    //{
    //    NSLog(@"Warning (GridViewCell): Caught attempt to reinitialize label events");
    //}
}

- (void)prepareForReuse
{
    if (self.eventsInited)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"labelEvent" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"clearEvent" object:nil];
        self.eventsInited = NO;
    }

    self.fullSize = CGSizeZero;
    self.fullSizeView = nil;
    self.editing = NO;
    self.deleteBlock = nil;
    self.ind = -1;
}

- (void)shake:(BOOL)on
{
    if ((on && !self.inShakingMode) || (!on && self.inShakingMode)) 
    {
        [self.contentView shakeStatus:on];
        _inShakingMode = on;
    }
}

- (void)switchToFullSizeMode:(BOOL)fullSizeEnabled
{    
    if (fullSizeEnabled)
    {
        self.fullSizeView.autoresizingMask = self.defaultFullsizeViewResizingMask;
        
        CGPoint center = self.fullSizeView.center;
        self.fullSizeView.frame = CGRectMake(self.fullSizeView.frame.origin.x, self.fullSizeView.frame.origin.y, self.fullSize.width, self.fullSize.height);
        self.fullSizeView.center = center;
        
        _inFullSizeMode = YES;
        
        self.fullSizeView.alpha = MAX(self.fullSizeView.alpha, self.contentView.alpha);
        self.contentView.alpha  = 0;
        
        [UIView animateWithDuration:0.3 
                         animations:^{
                             self.fullSizeView.alpha = 1;
                             self.fullSizeView.frame = CGRectMake(self.fullSizeView.frame.origin.x, self.fullSizeView.frame.origin.y, self.fullSize.width, self.fullSize.height);
                             self.fullSizeView.center = center;
                         } 
                         completion:^(BOOL finished){
                             [self setNeedsLayout];
                         }
        ];
    }
    else
    {
        self.fullSizeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _inFullSizeMode = NO;
        self.fullSizeView.alpha = 0;
        self.contentView.alpha  = 0.6;
        
        [UIView animateWithDuration:0.3 
                         animations:^{
                             self.contentView.alpha  = 1;
                             self.fullSizeView.frame = self.bounds;
                         } 
                         completion:^(BOOL finished){
                             [self setNeedsLayout];
                         }
         ];
    }
}

- (void)stepToFullsizeWithAlpha:(CGFloat)alpha
{
    return; // not supported anymore - to be fixed
    
    if (![self isInFullSizeMode]) 
    {
        alpha = MAX(0, alpha);
        alpha = MIN(1, alpha);
        
        self.fullSizeView.alpha = alpha;
        self.contentView.alpha  = 1.4 - alpha;
    }
}

@end
