declare module "cordova-plugin-contacts-save" {
  type ContactsSaveSuccessHandler = (response: string) => void;
  type ContactsSaveErrorHandler = (error: string) => void;

  interface CNMutableContact {
    namePrefix?: string;
    givenName?: string;
    familyName?: string;
  }

  class ContactsSave {
    static saveContacts: (
      contacts?: CNMutableContact[],
      container?: string,
      onSuccess?: ContactsSaveSuccessHandler,
      onError?: ContactsSaveErrorHandler
    ) => void;
  }
}
