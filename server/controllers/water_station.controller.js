const { to, ReE, ReS } = require('../services/util.service');
const axios = require('axios');
const config = require('config');
const ffisConfig = config.get("ffis-config");
const fs = require('fs');
const station_data_file = JSON.parse(fs.readFileSync('./data/station-data.json').toString());

const getStationAboveWarning = async function (req, res) {
	res.setHeader('Content-Type', 'application/json');

    [err, apiResponse] = await to(axios.get(ffisConfig.stationLevelAboveWarningFetchUrl));
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

const getPresentWaterLevelData = async function (req, res) {
	res.setHeader('Content-Type', 'application/json');

    var id = req.body.id;

    var sort_criteria = encodeURIComponent(
        '{"sortOrderDtos":[{"sortDirection":"DESC","field":"id.dataTime"}]}');
  
    var specification = encodeURIComponent(
        `{"where":{"where":{"expression":{"valueIsRelationField":false,"fieldName":"id.stationCode","operator":"eq","value":${id}}},"and":{"expression":{"valueIsRelationField":false,"fieldName":"id.datatypeCode","operator":"eq","value":"HHS"}}},"and":{"expression":{"valueIsRelationField":false,"fieldName":"dataValue","operator":"null","value":"false"}}}`);
  
    var fetchUrl =
        `https://ffs.india-water.gov.in/iam/api/new-entry-data/specification/sorted-page?sort-criteria=${sort_criteria}&page-number=0&page-size=2&specification=${specification}`;

    [err, apiResponse] = await to(axios.get(fetchUrl, { headers: { 'Class-Name': 'NewEntryDataDto' } }));
    if (err) return ReE(res, err, 422);

    var response = apiResponse.data ?? {};

    return ReS(res, { data: response, message: 'Station data fetched successfully.' }, 200);
}
module.exports.getPresentWaterLevelData = getPresentWaterLevelData;