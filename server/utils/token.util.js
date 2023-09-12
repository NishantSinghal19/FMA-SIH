const jwt = require("jsonwebtoken");
const { JWT_DECODE_ERR } = require("./auth.errors");
// const { JWT_SECRET } = require("../config");
const config = require('config');
exports.createJwtToken = (payload) => {
    const token = jwt.sign(payload, config.get("jwt").secretKey, { expiresIn: "12h" });
    return token;
};

exports.verifyJwtToken = (token, next) => {
    try {
        const { userId } = jwt.verify(token, config.get("jwt").secretKey);
        return userId;
    } catch (err) {
        next(err);
    }
};