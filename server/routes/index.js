var express = require('express');
var router = express.Router();

/* GET home page. */
const checkAuth = require("../middlewares/checkAuth");
const checkAdmin = require("../middlewares/checkAdmin");
const {
  fetchCurrentUser,
  loginUser,
  registerUser,
  verifyOTP,
  handleAdmin
} = require("../controllers/auth.controller.js");
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
router.post("/register", registerUser);
router.post("/login_with_phone", loginUser);
router.post("/verify", verifyOTP);
router.get("/me", checkAuth, fetchCurrentUser);
router.get("/admin", checkAuth, checkAdmin, handleAdmin);





module.exports = router;
