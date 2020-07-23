# cordova-plugin-contacts-save

[![npm version](https://img.shields.io/npm/v/cordova-plugin-contacts-save)](https://www.npmjs.com/package/cordova-plugin-contacts-save?activeTab=versions)
[![MIT Licence](https://img.shields.io/badge/license-MIT-blue?style=flat)](https://opensource.org/licenses/mit-license.php)

This plugin saves the contacts into the device.

- [Installation](#installation)
- [Supported Platforms](#supported-platforms)
- [Usage](#usage)
- [Types](#types)

## Installation

```shell
cordova plugin add cordova-plugin-contacts-save
```

## Supported Platforms

- iOS

Dont forget to add `NSContactsUsageDescription` to your `plist`.

You can add this in your `config.xml`.

```xml
<platform name="ios">
  ...
  <edit-config file="*-Info.plist" mode="merge" target="NSContactsUsageDescription">
    <string>Used to save business cards</string>
  </edit-config>
  ...
</platform>
```

## Usage

```js
// define contacts
var contacts = [
  {
    givenName: "Steve",
    familyName: "Jobs",
  },
];

// set default store container
var container = "";

// save contacts
window.ContactsSave.saveContacts(
  contacts,
  container,
  (cookies) => {
    // contacts saved
  },
  (error) => {
    // error: NO_CONTACTS or NO_PERMISSON
  }
);
```

## Types

```ts
export interface CNMutableContact {
  namePrefix?: string;
  givenName?: string;
  familyName?: string;
  organizationName?: string;
  jobTitle?: string;
  postalAddresses: CNLabeledValue<"home" | "work" | "other", CNPostalAddress>[];
  phoneNumbers: CNLabeledValue<
    "home" | "work" | "mobile" | "homeFax" | "workFax" | "otherFax" | "other",
    CNPhoneNumber
  >[];
  emailAddresses: CNLabeledValue<"home" | "work" | "other", string>[];
  urlAddresses: CNLabeledValue<"home" | "work" | "other", string>[];
  imageData?: string;
  note?: string;
}

export interface CNLabeledValue<L, V> {
  label?: L;
  value: V;
}

export interface CNPhoneNumber {
  stringValue?: string;
}

export interface CNPostalAddress {
  street?: string;
  city?: string;
  state?: string;
  postalCode?: string;
  ISOCountryCode?: string;
  country?: string;
}
```
