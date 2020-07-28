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
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"NO_CONTACTS"] callbackId:command.callbackId];
        return;
    }

    // check container argument
    if ([container isEqual:[NSNull null]] || container.length == 0) {
        container = nil;
    }

    // save contacts
    [contacts enumerateObjectsUsingBlock:^(NSMutableDictionary* _Nonnull contact, NSUInteger idContacts, BOOL* _Nonnull stopContacts) {
        // create mutable contact
        CNMutableContact* mutableContact = [[CNMutableContact alloc] init];

        /**
         Name
         */
        mutableContact.namePrefix = contact[@"namePrefix"];
        mutableContact.givenName = contact[@"givenName"];
        mutableContact.familyName = contact[@"familyName"];

        /**
         Organization
         */
        mutableContact.organizationName = contact[@"organizationName"];
        mutableContact.jobTitle = contact[@"jobTitle"];

        /**
         Phone Numbers
         */
        NSMutableArray* mutablePhoneNumbers =  [[NSMutableArray alloc] init];

        // iterate phone numbers
        NSArray* phoneNumbers = contact[@"phoneNumbers"];
        [phoneNumbers enumerateObjectsUsingBlock:^(NSMutableDictionary* _Nonnull labeledItem, NSUInteger idAddresses, BOOL* _Nonnull stopAddresses) {
            // get phone number label
            NSString* label = labeledItem[@"label"];

            // get phone number value
            NSDictionary* value = labeledItem[@"value"];

            // check phone number value
            NSString* stringValue = value[@"stringValue"];
            if (stringValue != nil) {
                // create phone number
                CNPhoneNumber* phoneNumber =[CNPhoneNumber phoneNumberWithStringValue:stringValue];

                // add to mutable phone numbers
                if ([label isEqualToString:@"home"]) {
                    [mutablePhoneNumbers addObject:[CNLabeledValue labeledValueWithLabel:CNLabelHome value:phoneNumber]];
                } else if ([label isEqualToString:@"work"]) {
                    [mutablePhoneNumbers addObject:[CNLabeledValue labeledValueWithLabel:CNLabelWork value:phoneNumber]];
                } else if ([label isEqualToString:@"mobile"]) {
                    [mutablePhoneNumbers addObject:[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile value:phoneNumber]];
                } else if ([label isEqualToString:@"homeFax"]) {
                    [mutablePhoneNumbers addObject:[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberHomeFax value:phoneNumber]];
                } else if ([label isEqualToString:@"workFax"]) {
                    [mutablePhoneNumbers addObject:[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberWorkFax value:phoneNumber]];
                } else if ([label isEqualToString:@"otherFax"]) {
                    [mutablePhoneNumbers addObject:[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberOtherFax value:phoneNumber]];
                } else {
                    [mutablePhoneNumbers addObject:[CNLabeledValue labeledValueWithLabel:CNLabelOther value:phoneNumber]];
                }
            }
        }];

        // populate mutable phone numbers
        mutableContact.phoneNumbers = mutablePhoneNumbers;

        /**
         Email Addresses
         */
        NSMutableArray* mutableEmailAddresses =  [[NSMutableArray alloc] init];

        // iterate email addresses
        NSArray* emailAddresses = contact[@"emailAddresses"];
        [emailAddresses enumerateObjectsUsingBlock:^(NSMutableDictionary* _Nonnull labeledItem, NSUInteger idAddresses, BOOL* _Nonnull stopAddresses) {
            // get email address label
            NSString* label = labeledItem[@"label"];

            // get email address value
            NSString* value = labeledItem[@"value"];

            // check email address value
            if (value != nil) {
                // add to mutable email addresses
                if ([label isEqualToString:@"home"]) {
                    [mutableEmailAddresses addObject:[CNLabeledValue labeledValueWithLabel:CNLabelHome value:value]];
                } else if ([label isEqualToString:@"work"]) {
                    [mutableEmailAddresses addObject:[CNLabeledValue labeledValueWithLabel:CNLabelWork value:value]];
                } else {
                    [mutableEmailAddresses addObject:[CNLabeledValue labeledValueWithLabel:CNLabelOther value:value]];
                }
            }
        }];

        // populate mutable email addresses
        mutableContact.emailAddresses = mutableEmailAddresses;

        /**
         Url Addresses
         */
        NSMutableArray* mutableUrlAddresses =  [[NSMutableArray alloc] init];

        // iterate email addresses
        NSArray* urlAddresses = contact[@"urlAddresses"];
        [urlAddresses enumerateObjectsUsingBlock:^(NSMutableDictionary* _Nonnull labeledItem, NSUInteger idAddresses, BOOL* _Nonnull stopAddresses) {
            // get email address label
            NSString* label = labeledItem[@"label"];

            // get email address value
            NSString* value = labeledItem[@"value"];

            // check email address value
            if (value != nil) {
                // add to mutable email addresses
                if ([label isEqualToString:@"home"]) {
                    [mutableUrlAddresses addObject:[CNLabeledValue labeledValueWithLabel:CNLabelHome value:value]];
                } else if ([label isEqualToString:@"work"]) {
                    [mutableUrlAddresses addObject:[CNLabeledValue labeledValueWithLabel:CNLabelWork value:value]];
                } else {
                    [mutableUrlAddresses addObject:[CNLabeledValue labeledValueWithLabel:CNLabelOther value:value]];
                }
            }
        }];

        // populate mutable email addresses
        mutableContact.urlAddresses = mutableUrlAddresses;

        /**
         Postal Addresses
         */
        NSMutableArray* mutablePostalAddresses =  [[NSMutableArray alloc] init];

        // iterate postal addresses
        NSArray* postalAddresses = contact[@"postalAddresses"];
        [postalAddresses enumerateObjectsUsingBlock:^(NSMutableDictionary* _Nonnull labeledItem, NSUInteger idAddresses, BOOL* _Nonnull stopAddresses) {
            // get postal address label
            NSString* label = labeledItem[@"label"];

            // get postal address value
            NSDictionary* value = labeledItem[@"value"];

            // create mutable postal address
            CNMutablePostalAddress* mutablePostalAddress = [[CNMutablePostalAddress alloc] init];

            // populate mutable postal address
            mutablePostalAddress.street = value[@"street"];
            mutablePostalAddress.city = value[@"city"];
            mutablePostalAddress.state = value[@"state"];
            mutablePostalAddress.postalCode = value[@"postalCode"];
            mutablePostalAddress.ISOCountryCode = value[@"ISOCountryCode"];
            if (mutablePostalAddress.ISOCountryCode == nil || mutablePostalAddress.ISOCountryCode.length == 0) {
                mutablePostalAddress.country = value[@"country"];
            }

            // add to mutable postal addresses
            if ([label isEqualToString:@"home"]) {
                [mutablePostalAddresses addObject:[CNLabeledValue labeledValueWithLabel:CNLabelHome value:mutablePostalAddress]];
            } else if ([label isEqualToString:@"work"]) {
                [mutablePostalAddresses addObject:[CNLabeledValue labeledValueWithLabel:CNLabelWork value:mutablePostalAddress]];
            } else {
                [mutablePostalAddresses addObject:[CNLabeledValue labeledValueWithLabel:CNLabelOther value:mutablePostalAddress]];
            }
        }];

        // populate mutable postal addresses
        mutableContact.postalAddresses = mutablePostalAddresses;

        /**
         Image Data
         */
        if (contact[@"imageData"] != nil) {
            mutableContact.imageData = [[NSData alloc] initWithBase64EncodedString:contact[@"imageData"] options:0];
        }

        /**
         Note
         */
        NSString* note = contact[@"note"];
        if (![note isEqual:[NSNull null]]) {
            mutableContact.note = note;
        }

        // create save request
        CNSaveRequest* saveRequest = [[CNSaveRequest alloc] init];

        // add mutable contact to save request
        [saveRequest addContact:mutableContact toContainerWithIdentifier:container];

        // create store
        CNContactStore* store = [[CNContactStore alloc] init];

        // execute save request
        NSError* error;
        if (![store executeSaveRequest:saveRequest error:&error]) {
            // save request failed because of missing permission
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedFailureReason]] callbackId:command.callbackId];
            return;
        }
    }];

    // return success
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

@end
