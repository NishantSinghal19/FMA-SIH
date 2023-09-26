const { to, ReE, ReS } = require('../services/util.service');
const axios = require('axios');
const config = require('config');
const stationLevelAboveWarningFetchUrl = config.get("ffis-config").stationLevelAboveWarningFetchUrl;
const fs = require('fs');
const station_data_file = JSON.parse(fs.readFileSync('./data/station-data.json').toString());

const getStationAboveWarning = async function (req, res) {
	res.setHeader('Content-Type', 'application/json');

    [err, apiResponse] = await to(axios.get(stationLevelAboveWarningFetchUrl));
    if (err) return ReE(res, err, 422);

    var response = apiResponse.data ?? [];

    response = response.map(function (station) {
        var stationData = station_data_file[station.stationCode] ?? {};
        stationData = Object.assign(stationData, station);
        return stationData;
    });

    return ReS(res, { data: response, message: 'Station list fetched successfully.' }, 200);
}
module.exports.getStationAboveWarning = getStationAboveWarning;