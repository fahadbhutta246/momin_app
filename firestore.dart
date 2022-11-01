// rules_version = '2';
// service cloud.firestore {
// match /databases/{database}/documents {
// match /oneSignal/{signalId} {
// allow write: if request.auth != null;
// }
// }
// }