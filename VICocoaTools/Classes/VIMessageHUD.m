//
//  VIMessageHUD.m
//  AFNetworking
//
//  Created by 熊国锋 on 2018/7/18.
//

#import "VIMessageHUD.h"
#import <Masonry/Masonry.h>
#import "UIView+VI.h"
#import "NSAttributedString+GF.h"
#import "UIColor+GF.h"

const NSTimeInterval MESSAGE_DELAY_INVERTAL = 1.5;

@interface VIMessageAction ()

@property (nonatomic, copy) NSString                        *title;
@property (nonatomic, copy) VIMessageHUDCompletionBlock     completion;

@end

@implementation VIMessageAction

+ (instancetype)actionWithTitle:(NSString *)title completion:(VIMessageHUDCompletionBlock)completion {
    return [[self alloc] initWithTitle:title completion:completion];
}

- (instancetype)initWithTitle:(NSString *)title completion:(nullable VIMessageHUDCompletionBlock)completion {
    if (self = [super init]) {
        self.title = title;
        self.completion = completion;
    }
    
    return self;
}

@end

@interface VIBackgroundView : UIView

@property (nonatomic, assign) CGFloat   destAlpha;

@end

@implementation VIBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = .0;
        self.destAlpha = .3;
    }
    
    return self;
}

- (void)showAnimated:(BOOL)animated {
    [UIView animateWithDuration:.3
                          delay:0
         usingSpringWithDamping:.7
          initialSpringVelocity:.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = self.destAlpha;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}


- (void)hideAnimated:(BOOL)animated {
    [UIView animateWithDuration:.3
                          delay:0
         usingSpringWithDamping:.7
          initialSpringVelocity:.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

@end

@protocol VIContentViewDelegate <NSObject>

- (void)barItemClicked:(UIBarButtonItem *)item;

@end

@interface VIContentView : UIView

@property (nonatomic, weak) id<VIContentViewDelegate>       delegate;

@property (nonatomic, copy) NSString                        *titleString;
@property (nonatomic, copy) NSString                        *detailString;
@property (nonatomic, copy) NSArray<VIMessageAction *>      *actions;

@property (nonatomic, copy) UIFont                          *titleFont;
@property (nonatomic, copy) UIFont                          *detailFont;
@property (nonatomic, copy) UIColor                         *titleColor;
@property (nonatomic, copy) UIColor                         *detailColor;
@property (nonatomic, assign) NSInteger                     padding;

@property (nonatomic, assign) CGFloat                       preferredMaxLayoutWidth;
@property (nonatomic, strong) UILabel                       *labelView;
@property (nonatomic, assign) CGFloat                       toolBarHeight;
@property (nonatomic, strong) UIToolbar                     *toolBar;
@end

@implementation VIContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorFromHex:0x242424];
        CALayer *layer = self.layer;
        layer.cornerRadius = 8.;
        
        self.titleFont = [UIFont boldSystemFontOfSize:17];
        self.detailFont = [UIFont systemFontOfSize:15];
        self.titleColor = [UIColor whiteColor];
        self.detailFont = [UIColor colorFromHex:0xd0d0d0];
        self.padding = 16;
        self.toolBarHeight = 48;
        
        self.labelView = [UILabel new];
        self.labelView.numberOfLines = 100;
        [self addSubview:self.labelView];
        [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(self.padding);
            make.right.equalTo(self).offset(-self.padding);
            make.top.equalTo(self).offset(self.padding);
        }];
        
        self.toolBar = [UIToolbar new];
        [self.toolBar setBackgroundImage:[UIImage new]
                      forToolbarPosition:UIBarPositionAny
                              barMetrics:UIBarMetricsDefault];
        
        [self addSubview:self.toolBar];
        [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(self.padding);
            make.right.equalTo(self).offset(-self.padding);
            make.top.equalTo(self.labelView.mas_bottom).offset(self.padding);
            make.height.equalTo(@(self.toolBarHeight));
        }];
    }
    
    return self;
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = [titleString copy];
    
    [self updateContent];
}

- (void)setDetailString:(NSString *)detailString {
    _detailString = [detailString copy];
    
    [self updateContent];
}

- (void)setActions:(NSArray<VIMessageAction *> *)actions {
    _actions = [actions copy];
    
    [self updateContent];
}

- (NSAttributedString *)attributedString {
    NSAttributedString *string;
    
    if (self.titleString.length && self.detailString.length) {
        string = [NSAttributedString attributedStringWithString:self.titleString font:self.titleFont color:self.titleColor
                                                         string:[@"\r\n" stringByAppendingString:self.detailString] font:self.detailFont color:self.detailColor];
    }
    else if (self.titleString.length) {
        string = [NSAttributedString attributedStringWithStrings:self.titleString, self.titleFont, self.titleColor, nil];
    }
    else if (self.detailString.length) {
        string = [NSAttributedString attributedStringWithStrings:self.detailString, self.detailFont, self.detailColor, nil];
    }
    
    return string;
}

- (CGSize)intrinsicContentSize {
    CGFloat height = 0;
    
    NSAttributedString *string = [self attributedString];
    CGSize stringSize = [string boundingRectWithSize:CGSizeMake(self.preferredMaxLayoutWidth - self.padding * 2, 1024)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                             context:nil].size;
    
    height = self.padding + stringSize.height;
    
    if (self.actions.count) {
        height += self.padding + self.toolBarHeight;
    }
    
    height += self.padding;
    return CGSizeMake(self.preferredMaxLayoutWidth, height);
}

- (void)updateContent {
    self.labelView.attributedText = [self attributedString];
    
    self.toolBar.hidden = self.actions.count == 0;
    if (self.actions.count) {
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        NSMutableArray *arr = @[flex].mutableCopy;
        
        [arr addObject:flex];
        for (VIMessageAction *action in self.actions) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:action.title
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(touchToolBarButton:)];
            [arr addObject:item];
        }
        [arr addObject:flex];
        
        self.toolBar.items = arr.copy;
    }
}

- (void)touchToolBarButton:(UIBarButtonItem *)item {
    for (VIMessageAction *action in self.actions) {
        if ([action.title isEqualToString:item.title]) {
            if (action.completion) {
                action.completion();
            }
            
            break;
        }
    }
    
    [self.delegate barItemClicked:item];
}

@end

@interface VIMessageHUD () < VIContentViewDelegate >

@property (nonatomic, strong) VIBackgroundView      *backgroundView;
@property (nonatomic, strong) VIContentView         *contentView;

@property (nonatomic, strong) NSTimer               *hideTimer;

@end

@implementation VIMessageHUD

+ (VIMessageHUD *)showHudOn:(UIView *)view
                      title:(nullable NSString *)title
                    message:(nullable NSString *)message
                    actions:(nullable NSArray<VIMessageAction *> *)actions
                  delayHide:(BOOL)delayHide
                 completion:(nullable VIMessageHUDCompletionBlock)completionBlock {
    
    VIMessageHUD *hud = [[self alloc] initWithView:view];
    hud.contentView.titleString = title;
    hud.contentView.detailString = message;
    hud.contentView.actions = actions;
    
    [view addSubview:hud];
    
    [hud showAnimated:YES];
    
    if (delayHide) {
        [hud hideAnimated:YES afterDelay:MESSAGE_DELAY_INVERTAL];
    }
    
    hud.completionBlock = completionBlock;
    
    return hud;
}

- (instancetype)initWithView:(UIView *)view {
    return [self initWithFrame:view.bounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    
    [self setupViews];
}

- (void)setupViews {
    self.backgroundView = [[VIBackgroundView alloc] initWithFrame:self.bounds];
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.backgroundView];
    
    self.contentView = [VIContentView new];
    self.contentView.delegate = self;
    [self addSubview:self.contentView];
}

- (void)showAnimated:(BOOL)animated {
    [self.backgroundView showAnimated:animated];
    
    NSInteger padding = 16;
    CGRect rect = CGRectInset(self.bounds, padding, padding);
    self.contentView.preferredMaxLayoutWidth = rect.size.width;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.mas_bottom).offset(padding);
    }];
    
    [self layoutIfNeeded];
    
    NSInteger bottomMargin = self.safeAreaInsets.bottom;
    bottomMargin = bottomMargin > 0?:padding;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(self).offset(-bottomMargin);
    }];
    
    [UIView animateWithDuration:.3
                          delay:0
         usingSpringWithDamping:.7
          initialSpringVelocity:.7
                        options:0
                     animations:^{
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         if (self.completionBlock) {
                             self.completionBlock();
                         }
                     }];
}

- (void)startHideTimer:(NSTimeInterval)delay {
    [self stopHideTimer];
    
    self.hideTimer = [NSTimer scheduledTimerWithTimeInterval:delay
                                                      target:self
                                                    selector:@selector(hideTimerFire:)
                                                    userInfo:nil
                                                     repeats:NO];
}

- (void)stopHideTimer {
    if ([self.hideTimer isValid]) {
        [self.hideTimer invalidate];
    }
    
    self.hideTimer = nil;
}

- (void)hideTimerFire:(NSTimer *)timer {
    [self hideAnimated:YES];
}

- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [self startHideTimer:delay];
}

- (void)hideAnimated:(BOOL)animated {
    [self.backgroundView hideAnimated:YES];
    
    NSInteger padding = 16;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.mas_bottom).offset(-16);
    }];
    
    [UIView animateWithDuration:.3
                     animations:^{
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - VIContentViewDelegate

- (void)barItemClicked:(UIBarButtonItem *)item {
    [self hideAnimated:YES];
}

@end
