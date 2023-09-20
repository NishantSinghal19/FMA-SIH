var express = require('express');
var router = express.Router();

/* GET home page. */

const RegisteredDevicesController = require("../controllers/registered_devices.controller.js");
const WaterStationController = require("../controllers/water_station.controller.js");

router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/register_device', RegisteredDevicesController.create);

router.get('/get_station_above_warning', WaterStationController.getStationAboveWarning)
router.post('/getPresentWaterLevelData', WaterStationController.getPresentWaterLevelData)

module.exports = router;
