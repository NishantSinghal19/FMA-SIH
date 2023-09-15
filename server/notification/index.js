const admin = require('firebase-admin');
const { RegisteredDevices } = require('../models');

const sendPushNotification = async (message) => {
    const msg = {
        notification: {
            title: message.title,
            body: message.body,
        },
        // You can also add data payload here if needed
        // data: {
        //   key1: 'value1',
        //   key2: 'value2',
        // },
    };

    const androidDeviceTokens = await RegisteredDevices.find({ deviceType: "android" }, { token: 1 });
	const registrationTokens = androidDeviceTokens.map((u) => u.get("token"));

    admin
        .messaging()
        .sendMulticast({tokens: registrationTokens, notification: msg.notification})
        .then((response) => {
            console.log('Successfully sent notification:', response);
        })
        .catch((error) => {
            console.error('Error sending notification:', error);
        });
}
module.exports = sendPushNotification;
