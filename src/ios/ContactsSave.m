/********* ContactsSave.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <Contacts/Contacts.h>

@interface ContactsSave : CDVPlugin {
  // Member variables go here.
}

- (void)saveContacts:(CDVInvokedUrlCommand*)command;
@end

@implementation ContactsSave

- (void)saveContacts:(CDVInvokedUrlCommand*)command
{
    // get contacts argument
    NSArray* contacts = [command.arguments objectAtIndex:0];

    // get container argument
    NSString* container = [command.arguments objectAtIndex:1];

    // check contacts argument
    if ([contacts isEqual:[NSNull null]] || contacts.count == 0) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Contacts missing."] callbackId:command.callbackId];
        return;
    }
    
    // check container argument
    if ([container isEqual:[NSNull null]] || container.length == 0) {
        container = nil;
    }
    
    // save contacts
    [contacts enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL* _Nonnull stop) {
        // create mutable contact
        CNMutableContact* mutableContact = [[CNMutableContact alloc] init];

        // populate mutable contact
        mutableContact.givenName = @"Kosta";
        mutableContact.familyName = @"Tsanakas";

        // create save request
        CNSaveRequest* saveRequest = [[CNSaveRequest alloc] init];

        // add mutable contact to save request
        [saveRequest addContact:mutableContact toContainerWithIdentifier:container];

        // create store
        CNContactStore* store = [[CNContactStore alloc] init];

        // execute save request
        if(![store executeSaveRequest:saveRequest error:nil]) {
            // save request failed because of missing permission
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Permission missing."] callbackId:command.callbackId];
            return;
        }
    }];
    
    // return success
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Contacts saved."] callbackId:command.callbackId];
}

@end
