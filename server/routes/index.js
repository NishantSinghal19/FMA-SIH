var express = require('express');
var router = express.Router();

/* GET home page. */

const RegisteredDevicesController = require("../controllers/registered_devices.controller.js");

router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/register_device', RegisteredDevicesController.create);


module.exports = router;
