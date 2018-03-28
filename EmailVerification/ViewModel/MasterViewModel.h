//
//  MasterViewModel.h
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface MasterViewModel : NSObject

@property (copy, nonatomic) NSString *input;
@property (readonly, nonatomic) RACSignal *valid;

@end
