@interface UIColor (Serialization)

- (NSString *)stringValue;
- (NSString *)hexStringValue;
+ (UIColor *)colorFromString:(NSString *)colorString;
+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end
