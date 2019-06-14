#import "AnalytisRecorderBenchPlugin.h"
#import <analytis_recorder_bench/analytis_recorder_bench-Swift.h>

@implementation AnalytisRecorderBenchPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnalytisRecorderBenchPlugin registerWithRegistrar:registrar];
}
@end
