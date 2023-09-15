"use strict";
const mongoose = require('mongoose');

const User = mongoose.model('User', new mongoose.Schema({
    first: { type: String, required: [true, 'First name is required'] },
    last: { type: String, required: [true, 'Last name is required'] },
    phone: { type: String, allowNull: false, required: [true, 'Phone Number is required'] },
    email: { type: String, allowNull: true },
    role: { type: String, enum: ['admin', 'user'], default: "user" },
    phoneOtp: { type: String },
    status:{type:String,enum:['active','inActive'],default:"inActive"}
}, { timestamps: true }));

module.exports = User;