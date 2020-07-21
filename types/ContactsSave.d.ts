interface CNMutableContact {
  namePrefix?: string;
  givenName?: string;
  familyName?: string;
}

type ContactsSaveSuccessHandler = (response: string) => void;
type ContactsSaveErrorHandler = (error: string) => void;

declare class ContactsSave {
  saveContacts(
    contacts?: CNMutableContact[],
    container?: string,
    onSuccess?: ContactsSaveSuccessHandler,
    onError?: ContactsSaveErrorHandler
  ): void;
}

interface Window {
  ContactsSave: ContactsSave;
}
