//
//  UIViewController+base.h
//  DeckKingsRulersDeal
//
//  Created by DeckKingsRulersDeal on 2024/12/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (base)

- (BOOL)PeakNeedLoadAdBannData;

- (NSString *)hostUrl;

- (void)showAdView:(NSString *)adurl;

@end

NS_ASSUME_NONNULL_END
