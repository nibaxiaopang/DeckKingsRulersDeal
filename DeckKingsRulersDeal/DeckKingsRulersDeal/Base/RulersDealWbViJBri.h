//
//  PeakWbViJBri.h
//  DeckKingsRulersDeal
//
//  Created by DeckKingsRulersDeal on 2024/10/18.
//

#import <Foundation/Foundation.h>
#import "RulersDealWbViewJBriBase.h"
#import <WebKit/WebKit.h>

@interface RulersDealWbViJBri : NSObject<WKNavigationDelegate, RulersDealWwJtBriBaseDelegate>

+ (instancetype)bridForWebView:(WKWebView*)webView;
+ (void)enableLogging;

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler;
- (void)removeHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;
- (void)reset;
- (void)setWebViewDelegate:(id)webViewDelegate;
- (void)disableJavscriptAlertBoxSafetyTimeout;

@end
