"use strict";
const mongoose = require('mongoose');

const RegisteredDevices = mongoose.model('RegisteredDevices', new mongoose.Schema({
	deviceType: { type: String, enum: ['android', 'ios']},
	softwareVersion: { type: String, allowNull: false, required: [true, 'Software version is required'] },
	model: { type: String, allowNull: false, required: [true, 'Hardware is required'] },
	os: { type: String, allowNull: false, required: [true, 'Software is required'] },
	updatedAt: { type: Date },
	lastContactedAt: { type: Date },
	isActive: { type: Boolean, defaulvalue: false },
	registeredUserId: { type: mongoose.ObjectId, ref: 'User', allowNull: true },
	token: { type: String, allowNull: false, default: '' },
}, { timestamps: true }));

module.exports = RegisteredDevices;