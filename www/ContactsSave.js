var exec = require("cordova/exec");

exports.saveContacts = function (contacts, container, success, error) {
  exec(success, error, "ContactsSave", "saveContacts", [contacts, container]);
};
