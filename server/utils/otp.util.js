
// const fast2sms = require("fast-two-sms");
// const {FAST2SMS} = require("../config");
var fast2sms = require('fast2sms');
const config = require('config');

var options = {API_KEY:config.get("FAST2SMS")};
fast2sms.init(options)
exports.generateOTP = (otp_length) => {
  // Declare a digits variable
  // which stores all digits
  var digits = "0123456789";
  let OTP = "";
  for (let i = 0; i < otp_length; i++) {
    OTP += digits[Math.floor(Math.random() * 10)];
  }
  return OTP;
};

exports.fast2sms = async ({ message, contactNumber }, next) => {
  try {
    console.log(message,contactNumber)
    const res = await fast2sms.send({
      message:message,
      to:contactNumber}
      // numbers: [contactNumber],
    );
    // const res = await fast2sms.sendMessage({
    //   authorization: config.get("FAST2SMS"),
    //   message,
    //   numbers: [contactNumber],
    // });
    console.log(res);
  } catch (error) {
    // next(error);
    console.log(error)
  }
};
