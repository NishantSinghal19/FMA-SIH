var express = require('express');
var router = express.Router();

/* GET home page. */
const checkAuth = require("../middleware/checkAuth");
const checkAdmin = require("../middleware/checkAdmin");
const {
  fetchCurrentUser,
  loginUser,
  
  verifyOTP,
  handleAdmin,
  createNewUser
} = require("../controllers/auth.controller.js");
const RegisteredDevicesController = require("../controllers/registered_devices.controller.js");

router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});
router.post("/register", createNewUser);
router.post("/login_with_phone", function(req, res){
  loginUser
});
router.post("/verify", function(req, res){
  verifyOTP
});
router.get("/me", checkAuth, fetchCurrentUser);
router.get("/admin", checkAuth, checkAdmin, handleAdmin);


router.post('/register_device', RegisteredDevicesController.create);


module.exports = router;
