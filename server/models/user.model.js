"use strict";
const mongoose = require('mongoose');

const User = mongoose.model('Users', new mongoose.Schema({
    first: { type: String, required: [true, 'First name is required'] },
    last: { type: String, required: [true, 'Last name is required'] },
    phone: { type: String, allowNull: false, required: [true, 'Phone Number is required'] },
    email: { type: String, allowNull: true, required: [true, 'Email is required'] },
    role: { type: String, enum: ['admin', 'user'], default: "user" },
    otp: { type: Number }
}, { timestamps: true }));

module.exports = Users;