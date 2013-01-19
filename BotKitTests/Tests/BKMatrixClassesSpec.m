#import "BKObjectTensor.h"
#import "BKFloatMatrix.h"
#import "BKObjectMatrix.h"

SPEC_BEGIN(BKMatrixClassesSpec)

describe(@"Tests for matrix and tensor classes", ^{
    
    context(@"BKObjectTensorTest", ^{
        
        __block BKObjectTensor *tensor;
        
        beforeAll(^{
            NSUInteger dimentionArray[] = {2,3,5,6};
            NSIndexPath *dimentions = [[NSIndexPath alloc] initWithIndexes:dimentionArray length:4];
            tensor = [[BKObjectTensor alloc] initWithDimentions:dimentions];
            
            [tensor mapIndicesToBlock:^(NSIndexPath *index) {
                NSMutableString *pathStr = [[NSMutableString alloc] init];
                for (int i=0; i<index.length; ++i) [pathStr appendFormat:@"[%d] ", [index indexAtPosition:i]];
                [tensor replaceObjectAtIndex:index withObject:pathStr];
            }];
        });
        
        it(@"should have a string: [1] [2] [2] [3], at index:{1,2,2,3}", ^{
            NSUInteger indexArr[] = {1,2,2,3};
            NSIndexPath *index = [[NSIndexPath alloc] initWithIndexes:indexArr length:4];
            NSString *tensorObj = [tensor objectAtIndex:index];
            BOOL equal = [tensorObj isEqualToString:@"[1] [2] [3] [3] "];
            [[theValue(equal) should] beTrue];
        });
        
        it(@"should not have a string: [1] [2] [3] [3], at index:{1,2,2,3}", ^{
            NSUInteger indexArr[] = {1,2,2,3};
            NSIndexPath *index = [[NSIndexPath alloc] initWithIndexes:indexArr length:4];
            NSString *tensorObj = [tensor objectAtIndex:index];
            BOOL equal = [tensorObj isEqualToString:@"[1] [2] [3] [3] "];
            [[theValue(equal) should] beFalse];
        });
        
        pending_(@"should be awesome", ^{
            //
        });
        
    });
    
});

SPEC_END