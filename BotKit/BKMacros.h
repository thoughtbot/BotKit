// Logs with line numbers
#define SLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define ALog(fmt, ...) SLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

// Logs for timing processes
#define TIMER_BEGIN CFAbsoluteTime before = CFAbsoluteTimeGetCurrent();
#define TIMER_RENEW before = CFAbsoluteTimeGetCurrent();
#define TIMER_LOG ALog(@"Function Time:  %f",CFAbsoluteTimeGetCurrent()-before);