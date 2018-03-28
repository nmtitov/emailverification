//
//  MasterViewModel.h
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "Ensurable.h"

@interface MasterViewModel : NSObject <Ensurable>

@property (copy, nonatomic) NSString *input;
@property (readonly, nonatomic) RACSignal *empty;
@property (readonly, nonatomic) RACSignal *valid;

@end
