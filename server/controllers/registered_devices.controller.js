const { to, ReE, ReS } = require('../services/util.service');
const { RegisteredDevices, User } = require('../models');
// const logger = require("../lib/logging");
const { sendDataToProcessId } = require('pm2');
const sendPushNotification = require('../notification');

const create = async function (req, res) {
	res.setHeader('Content-Type', 'application/json');
	const body = req.body;

	if (!body.token) {
		// logger.error("RegisteredDevices Controller - create : Token cannot be empty");
		return ReE(res, new Error('Token is required'), 422);
	} else {
		[err, registeredDevice] = await to(RegisteredDevices.findOne({ where: { token: body.token } }));
		if (registeredDevice) {
			// sendPushNotification({ title: "New Device Registered", body: "A new device has been registered" });
			return ReS(res, { message: 'Device already registered' }, 201);
		} else {
			if (!body.deviceType || !body.softwareVersion || !body.model || !body.os) {
				// logger.error("RegisteredDevices Controller - create : deviceType/softwareVersion/model/os cannot be empty");
				return ReE(res, new Error('Invalid Device.'), 422);
			} else {
				let err, device;

				[err, device] = await to(RegisteredDevices.create(body));
				if (err) {
					// logger.error("RegisteredDevices Controller - create : Device could not be registered", err);
					return ReE(res, err, 422);
				}
				// sendPushNotification({ title: "New Device Registered", body: "A new device has been registered" });
				return ReS(res, { message: 'Successfully registered new device.', device: device.toObject() }, 201);
			}
		}
	}

}
module.exports.create = create;