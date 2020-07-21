declare module "cordova-plugin-contacts-save" {
  interface CNMutableContact {
    namePrefix?: string;
    givenName?: string;
    familyName?: string;
  }

  type ContactsSaveSuccessHandler = (response: string) => void;
  type ContactsSaveErrorHandler = (error: string) => void;

  type saveContacts = (
    contacts?: CNMutableContact,
    container?: string,
    onSuccess?: ContactsSaveSuccessHandler,
    onError?: ContactsSaveErrorHandler
  ) => void;
}
