/*!
 @header EMChatCommand.h
 @abstract 聊天的命令对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "IEMChatObject.h"

@protocol IEMMessageBody;

/*!
 @class
 @brief 聊天的命令对象类型
 */
@interface EMChatCommand : NSObject<IEMChatObject>

/*!
 @property
 @brief 命令
 */
@property (nonatomic, strong) NSString *cmd;

/*!
 @property
 @brief 命令参数
 */
@property (nonatomic, strong) NSArray *params;

/*!
 @property
 @brief
 聊天对象所在的消息体对象
 @discussion
 当消息体通过聊天对象创建完成后, messageBody为非nil, 当聊天对象并不属于任何消息体对象的时候, messageBody为nil
 */
@property (nonatomic, weak) id<IEMMessageBody> messageBody;

@end
