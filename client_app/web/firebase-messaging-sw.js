importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js");

const firebaseConfig = {
    apiKey: "AIzaSyBAQAvWwwa3jakz5J7PzZLXUfQD_Zu8NoM",
    authDomain: "aplavankula.firebaseapp.com",
    projectId: "aplavankula",
    storageBucket: "aplavankula.appspot.com",
    messagingSenderId: "821717593480",
    appId: "1:821717593480:web:1aeea97b31b7ed3ef79e3d",
    measurementId: "G-3B8PMLG0VM"
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});